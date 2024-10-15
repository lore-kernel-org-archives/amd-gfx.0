Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAACCFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A21B410E545;
	Tue, 15 Oct 2024 08:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c9eV5J3s";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E5410E545
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGEhhPn5GEeW1pZ2Dwu15RWKzOfcO4mQdkEGR9Y9FaF5aqAwOcRxe2aHPsnCGyXttU1xXtxIrBp4zPj0E/AkGXbZ2nfBRfpIKUPSiyLOUNlpF+Vzk3tuK91+ShFaN+x0Df6KBXGjHf4uqg2delSwvr60DMc/tDww2Nj0mf1JDTCxHCFpMqLPhBBr2dntk7h6miPy2Li9MjwjSVo+ZakDjPRQeJ5G2d0y7bj18AgkOCba5mUng3P7yu4Qv6e+9A+qwRKFVwGwCzqTM37lSQWdcBKbgbJsFqaDkhpQMS/6CFqlDux7rf2O7yxKp49uwZPpbjA5ByKOBJ2wjaWvTo60/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kplrYZ4UsgSvn1dYKEldXIO/3dq97Jg+fmuABUbi1oM=;
 b=vgIHqV4FN7TCJrepYHUrJVRLIsWZuuJafRT9EDJXPOl22lhAaN4Vyjcl6ZCEiUAbArLnspFuItxlVsF9AZY5Gb9+hGeq8kOJd/Z79Q4FKijz9nGzKm2iB+eE8jY1/itvRcFUdH6ppHSotEWIlj87UiwDOtiu1mLCZIABYirqYWwQZQXiGbwxWYhKafVNPb0btWm/39zWxm3tBKfAz9MLd8H7qiEaQ3StO42vUUAlq7AYrmeCK7V9l8NUL+IyBDGTd9pFVT6OCkf0lbRVPBcJzryIvx/6cEetr7hSIEXkQHGyH1azi5i5mXDf2nyrdx6gEhBOCUnDPu1c9OCfy1ekkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kplrYZ4UsgSvn1dYKEldXIO/3dq97Jg+fmuABUbi1oM=;
 b=c9eV5J3sDP2VaurCISFUp7CWBE3du5EdaQAC3q3JLDzZQR2kbO0kSfe0Nz75xoKPFSh6TfJbIZslZphwaVLmykwVH73wIUlSe+KWbJeDCLqq+owmjxJHqQUN4aiHivK/ZWomCZbDYYTuuxW5i5fc7NW15EBXS6EdNgiut6nFSVg=
Received: from CH0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:610:76::31)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 08:18:29 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::46) by CH0PR04CA0026.outlook.office365.com
 (2603:10b6:610:76::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:27 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:18:22 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 08/10] drm/amd/display: update fullscreen status to SPL
Date: Tue, 15 Oct 2024 16:17:11 +0800
Message-ID: <20241015081713.3042665-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7a6200-6d1d-497f-52bd-08dcecf1f323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RwFAXKxuZ+kBE9kB1QXJOdEaPU1YY69q6eQNGgQkBjQQwWMw5NO0kzLAv0ty?=
 =?us-ascii?Q?jN/ECsZ0GDY0P0fk0xOCgk0T6fY/nrQ/+Fd2i4lMIOpwoFSJ5cyjcLH7eFpz?=
 =?us-ascii?Q?My7INAIzBbgc32JftIz6ZQo1ngenuCe32TJZVnoaAnQyPRW3YXArNHuNx/EU?=
 =?us-ascii?Q?3Sa0xj5bj0+q9pRTqLdMSLSVGYJoAq7EFlKDlNvbuCmU1pRrxqqV5lcMFcjy?=
 =?us-ascii?Q?T87YmsvwE2ozUIlZOOUdkjzlQ3TYIB3yk9q4N9LgGy7hM451MT8NNna0nQUR?=
 =?us-ascii?Q?2Bvw7Bao9s9VOBjMPM6qBl2BG0f5cJ0kGV8TKnTfzIABPM7qrJoDT0OC9vRq?=
 =?us-ascii?Q?AzH0EWSJUwgapC86BWNAfciiWi2lxr6C6C9S7WJSi77UttkibSA7pU0lPbVX?=
 =?us-ascii?Q?vRGlpAu6kiIxxhm0x2WtenpvXEWM8jBdt+IyQlPg2bVAaQ8gJ9rVdlv9SdeT?=
 =?us-ascii?Q?5QOviCktXuifL60OXs/1KhPLPF0bB9WyxjS39ZVML6/sZYYY65fvlFELMUav?=
 =?us-ascii?Q?U7LK1sbC3mfTCI3CSvgnvljUufyzeIMHElB6jQ38nHvud97SekP4l4OGuoAW?=
 =?us-ascii?Q?QrwDzlIzEhj4B8VHzSzIkh+xnBwgTS9PlBlWCkuPScmYBjEu4L4f7pQ1N+g0?=
 =?us-ascii?Q?lOlSSJ1qjqy1TpHkdnrlLNIVaACSq7plnUupfJ6smeFDfCqHMHllcx5GDotn?=
 =?us-ascii?Q?kWi+qByovTkOheELComRRTz3Tb6hHTBHolX9De0DaugsaOVKVFTYBiN99IKW?=
 =?us-ascii?Q?rVdxHAv42F340ljQ2GeU0dLc+LHsB/nRzMYPSAM1YI6sAjkyMhuGdIwIPf/P?=
 =?us-ascii?Q?vHOxBqb4+Zx0BexhUBpKgKa5G+mXvsbp9uQeSPgmk3+meNAbdhn/axtmcUa+?=
 =?us-ascii?Q?THTgaskOUyxsFr3ecJvYkra+ShX7p5z9b2iIAQtM5WuoCBG6h9FqVE5glU3d?=
 =?us-ascii?Q?jzZcdDuLlADdAh+Jz9fNtkomStmS8x3C2+bd7FWde73hPY+4AQIBvWaGiDYk?=
 =?us-ascii?Q?EdAFWBaSvkXqzsyKXJFS4p62/2ptBkBTHUQpMCOjRzMGQm/hp3o2hN3g3Qdc?=
 =?us-ascii?Q?A1mQRxwTK+Jff1EWxZjZ8N6gALB9Sx51Usu23wfOgfDgUn+6xr8ArYgAkXIw?=
 =?us-ascii?Q?dyxj9WdLtJEFR2Urm5CWXMFapdRObjmYr5pXOiUivt7ejC9z0aUxJ4wlEUqV?=
 =?us-ascii?Q?JSCKzoK4bJ6FTSxQhELrOZb2+BaK0rIOh2wu5fDOsVeWyXCorkZmaELmf3fA?=
 =?us-ascii?Q?2uwwT1L72u8RB/hRz5YXvDCtb2G5b7IphRFUIWQ2W0gcnVO+zg0+wWislS+v?=
 =?us-ascii?Q?OkqHwb+ly2gHGyH4U9LyENLimHDLV4lwOHOjO4hWxV4oFUjtNVVW6T3ANJ+c?=
 =?us-ascii?Q?EnQa8vROFzs/de0tKzgnQ/HYg8ch?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:28.9125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7a6200-6d1d-497f-52bd-08dcecf1f323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Current fullscreen check in SPL using dm_helpers is out-of-sync
with dc state. This causes an issue during minimal transition
where we pick an invalid intermediate state because the pre and
post fullscreen status are different.

[How]
Add sharpening_required flag to dc_stream_state. Use this flag to
indicate if we are in fullscreen or not. Propagate flag to SPL for
fullscreen status. Remove workaround in DML

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                     | 5 +++++
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h                   | 3 +++
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c | 1 -
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 743f3292d98e..5a12fc75f97f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2756,6 +2756,9 @@ static enum surface_update_type check_update_surfaces_for_stream(
 		if (stream_update->scaler_sharpener_update)
 			su_flags->bits.scaler_sharpener = 1;
 
+		if (stream_update->sharpening_required)
+			su_flags->bits.sharpening_required = 1;
+
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
 
@@ -3107,6 +3110,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	}
 	if (update->scaler_sharpener_update)
 		stream->scaler_sharpener_update = *update->scaler_sharpener_update;
+	if (update->sharpening_required)
+		stream->sharpening_required = *update->sharpening_required;
 }
 
 static void backup_planes_and_stream_state(
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index eeffe44be9e3..24aa9df892f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -195,7 +195,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	/* Check if it is stream is in fullscreen and if its HDR.
 	 * Use this to determine sharpness levels
 	 */
-	spl_in->is_fullscreen = dm_helpers_is_fullscreen(pipe_ctx->stream->ctx, pipe_ctx->stream);
+	spl_in->is_fullscreen = pipe_ctx->stream->sharpening_required;
 	spl_in->is_hdr_on = dm_helpers_is_hdr_on(pipe_ctx->stream->ctx, pipe_ctx->stream);
 	spl_in->sdr_white_level_nits = plane_state->sdr_white_level_nits;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 14ea47eda0c8..413970588a26 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -143,6 +143,7 @@ union stream_update_flags {
 		uint32_t crtc_timing_adjust : 1;
 		uint32_t fams_changed : 1;
 		uint32_t scaler_sharpener : 1;
+		uint32_t sharpening_required : 1;
 	} bits;
 
 	uint32_t raw;
@@ -310,6 +311,7 @@ struct dc_stream_state {
 
 	struct luminance_data lumin_data;
 	bool scaler_sharpener_update;
+	bool sharpening_required;
 };
 
 #define ABM_LEVEL_IMMEDIATE_DISABLE 255
@@ -356,6 +358,7 @@ struct dc_stream_update {
 	struct dc_cursor_position *cursor_position;
 	bool *hw_cursor_req;
 	bool *scaler_sharpener_update;
+	bool *sharpening_required;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index d901b9f7bc6a..7a01a956e4bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -514,7 +514,6 @@ static void populate_dml21_stream_overrides_from_stream_state(
 		break;
 	}
 	if (!stream->ctx->dc->debug.enable_single_display_2to1_odm_policy ||
-			((stream->ctx->dc->debug.force_sharpness > 1) && stream->ctx->dc->config.use_spl) ||
 			stream->debug.force_odm_combine_segments > 0)
 		stream_desc->overrides.disable_dynamic_odm = true;
 	stream_desc->overrides.disable_subvp = stream->ctx->dc->debug.force_disable_subvp || stream->hw_cursor_req;
-- 
2.37.3


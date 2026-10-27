Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F5606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=G+MyhviW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C931E10F891;
	Tue, 27 Oct 2026 23:21:30 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013025.outbound.protection.outlook.com
 [40.93.196.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AFC10F891
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN2f4d7O6y+ByA5NJL3m91jqctepS5iS6RT8LiKrS/RuJCPa/M6BXYRrTzF6sf1MWLVkPuJrHTJ5kMNmB691Q2POJjbIXy5ZAh/Cg3Qz8nhPNbkT142+2hduC9KcU1xX5RQpmb2pXtDiLbrHuvkkphD+Yotr5Faydv2HuOKbMI854wx79sYmx27FEZVAgqLpvwibrcKorQw4nsW4YBFyNt1TKCU8Fjhe4ev+mN0XRTIsNKlU94urGHj8/xLn3W6YXmAYOU8J1JZ92w8KdTDAGtD1akMPdAbuE+SODPFsdR+M8Z5A4zX1/DoJ7lc1AZXvCbfTSjWIOmMjeC3jNZxFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ng55zvNi0UaBwU4EBAdyua3dmQMRZC4khvHWuWm/Ug=;
 b=e0TV4a4RwAHpYRNfVxWHh9/KrZaxevJBNfoC/tvKTP5wAcw5i51wi5AR9HzH+EPzHxWTldP9JMr7ffmh5nE5I5znxhYPRAgrd1MGB20Q4ojC4jvuk28hAddGlYfRYN5RNQpqTEAWvf7avegyOJgYwe3G65Xgqfd3sdGlH1x5bPL6H6uZKM8bshAbFFWGgOoALsqwkI09x041NYf/kJeZo8+xxB8uzHGN/Xm61cvOzZwkBso6/O4gI58DMt3ylk8ar3tVAkOgTZyk5bEJhz+CsBYtYsZLy4wCnsjdKgxFN/ixzQMr2zXjuLmCIdU6Uy940TZnFPykctjxOzzwePypdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ng55zvNi0UaBwU4EBAdyua3dmQMRZC4khvHWuWm/Ug=;
 b=G+MyhviWlNBNLYRZftKPDnYGQ/bK2efrogUuzRZGZeZQR1fh7CP0lgdNRlbzFEEx3obT38vWc0eh4FklQvhF89LuFjBjlh56yXBbR5eWPdKl+TtdCjenq4nRZhZOxre6W1x+W/Zwg1mY4HFwsQRQ7kh7pr6bbkA7m/IYZZlEcDo=
Received: from BN9PR03CA0940.namprd03.prod.outlook.com (2603:10b6:408:108::15)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:21:18 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::97) by BN9PR03CA0940.outlook.office365.com
 (2603:10b6:408:108::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 27
 Oct 2026 23:21:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:21:17 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:21:15 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 04/28] drm/amd/display: Add visual confirm full viewport debug
 option
Date: Tue, 27 Oct 2026 17:17:00 -0600
Message-ID: <20261027232005.2879750-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 484b2306-e438-41c5-9789-08df3481008b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003|56012099006|3023799007|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: Unrb2/o59SkLBnzxwRUshBmYlTJKeuMvWoZRWuJKAalK8zYkxx6A2kdmpwEGnuGBmRqKkWGU5EkXNDSBiHnJ2kKFYh0kCqCofQPIKk6zO3iPuREJ3/8N+gcyq4c6TkMuntOS0icOWZMeu0yo1XDha0dOLkzHZdzVLgr47WbdKmBNt9+MEtMtJrwRvIP00xN8sCVnHiAAe4fGBBxkH8IG9+UDtAd93EB++FaU9VzCKc4qUOa86gQYWmmEZavHieW9rxi7P7Ork/xn+dwFKydysjA64iFNIyv/Sxh/sLK7BlWA+68tf8sa8fLrEl0jpt+0a/KlzsetnpHW8/4gzNMLDwA24QJCJAEtLsIMN2EZizxuUsETDcHwsZD42ysOW7AaRPCsLx7KN2SCdlz3us0P+YCge+dH/uk6GYeOF5nHN76ioTuOkWrW/2fe8bF/fFu45hD8YUZviORRoZGcrJNnnM2Koq9yiElg/zbrPRSnejsBBslmnqX9QfJUBu9aql5mZSYYT1U2A3SuRzYj0ScwOuEd0UhvgmioSFsvUM/sStzgK8fPfQkpFJXSdlotozCYbE9x0WV5jFvobxpOU57cnSr+5K5r4MzhuXzbn7xZNwSTDyePOXj6cJ7WnaoOM/FnaipqoavgYH5+t1ztBJ8bp/J7N6jJeT6hLF0WA9PhcaYw/+HEbFzsxeUUbHSWH9ldLKMFpxYjb8kDDOK0mtDVrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dbHcjuBbovfANGlcRWLsOP1UbhEedgZVLfr9KCbYRfO0FDPR80ySK51O4Uf73BgFXN8PtOdJ2lE+Y3xeC3NaG0gb0juz9EFjHGeshc8EBnJGFvt33PhaNkODWNOONfc0fc7p95XoWw0HyTdxg9Eo5cfiXocvnXPtBHbO/i+YQnQKHDPYd2FfQFU1H8Ch0wcrh+2cN5FV6hS+tLJEyf0GvgBOqLwijkzZi67fcswzLQaqpyKDeLLFO3Haayn0Zam2LwCZxXYyamHc/c6RoUsilI3nuGx9NJCf7l5f9sR1A5SXYpjptX6mYiTQEOgF+ux8HqbGUUOyMYGagbcnrao8FBCliBHV6zgGS09gHJ3HIQIec72vhpa30lfgKwv6G1CWolZ+EAQcUEaX/KFc2vE6wfVPtIIvSdFWsyLJYDzfmvXMK+Hk3ewISxPQtlMNpEmm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:21:17.4039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b2306-e438-41c5-9789-08df3481008b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Lee <Alvin.Lee2@amd.com>

[WHAT]
The visual confirm overlay shrinks the recout before the viewport is
derived from it, so the viewport shrinks too. The viewport then
programmed into hardware no longer matches the one DML calculated, since
DML sized the pipe for the full viewport. Keep the viewport full and
shrink only the recout used by the overlay. This is to avoid discrepency
between HW programming and DML calculations.

- Add visual_confirm_full_viewport to struct dc_debug_options.
- Derive the viewport from the full recout on the legacy and SPL paths.
- Shrink the recout for HW only after viewport derivation, including the
  dscl_prog_data recout the SPL path programs.

Cc: Samson Tam <samson.tam@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 47 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../dc/resource/dcn60/dcn60_resource.c        |  1 +
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fa44c68b3340..832286f0c0b1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1241,9 +1241,15 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->plane_res.scl_data.recout = shift_rec(
 				&overlapping_area,
 				-odm_slice_src.x, -odm_slice_src.y);
-		adjust_recout_for_visual_confirm(
-				&pipe_ctx->plane_res.scl_data.recout,
-				pipe_ctx);
+		/* Non-SPL path: shrinking the recout here, before the viewport is
+		 * derived from it, shrinks the viewport too (legacy behavior). To keep
+		 * the HW viewport full, skip this and shrink the recout for HW only at
+		 * the tail of resource_build_scaling_params.
+		 */
+		if (!pipe_ctx->stream->ctx->dc->debug.visual_confirm_full_viewport)
+			adjust_recout_for_visual_confirm(
+					&pipe_ctx->plane_res.scl_data.recout,
+					pipe_ctx);
 	} else {
 		/* if there is no overlap, zero recout */
 		memset(&pipe_ctx->plane_res.scl_data.recout, 0,
@@ -1606,10 +1612,22 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 
 		// Convert pipe_ctx to respective input params for SPL
 		translate_SPL_in_params_from_pipe_ctx(pipe_ctx, spl_in);
-		/* Pass visual confirm debug information */
-		calculate_adjust_recout_for_visual_confirm(pipe_ctx,
-			&spl_in->debug.visual_confirm_base_offset,
-			&spl_in->debug.visual_confirm_dpp_offset);
+		/* Pass visual confirm debug information. These offsets are SPL inputs:
+		 * SPL subtracts them from the recout and then derives the viewport from
+		 * that shrunk recout, so the viewport shrinks together with the recout.
+		 */
+		if (pipe_ctx->stream->ctx->dc->debug.visual_confirm_full_viewport) {
+			/* pass 0 so SPL keeps both recout and viewport full; the recout is
+			 * shrunk for HW only at the tail of this function
+			 */
+			spl_in->debug.visual_confirm_base_offset = 0;
+			spl_in->debug.visual_confirm_dpp_offset = 0;
+		} else {
+			/* legacy: let SPL shrink both the recout and the viewport */
+			calculate_adjust_recout_for_visual_confirm(pipe_ctx,
+				&spl_in->debug.visual_confirm_base_offset,
+				&spl_in->debug.visual_confirm_dpp_offset);
+		}
 		// Set SPL output parameters to dscl_prog_data to be used for hw registers
 		spl_out->dscl_prog_data = resource_get_dscl_prog_data(pipe_ctx);
 		// Calculate scaler parameters from SPL
@@ -1723,6 +1741,21 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 #ifdef CONFIG_DRM_AMD_DC_FP
 	}
 #endif
+	/* Common tail for both paths (legacy and SPL): the viewport has now been derived from the
+	 * full recout, so shrink the recout for HW only. This runs only when
+	 * keeping the viewport full; the legacy paths above already shrank the
+	 * recout before the viewport was computed.
+	 */
+	if (pipe_ctx->stream->ctx->dc->debug.visual_confirm_full_viewport) {
+		adjust_recout_for_visual_confirm(
+				&pipe_ctx->plane_res.scl_data.recout, pipe_ctx);
+		/* SPL programs the HW recout from dscl_prog_data, not scl_data.recout */
+		if (pipe_ctx->stream->ctx->dc->config.use_spl &&
+				!pipe_ctx->stream->ctx->dc->debug.disable_spl)
+			adjust_recout_for_visual_confirm((struct rect *)
+					&pipe_ctx->plane_res.scl_data.dscl_prog_data.recout,
+					pipe_ctx);
+	}
 	DC_LOG_SCALER("%s pipe %d:\nViewport: height:%d width:%d x:%d y:%d  Recout: height:%d width:%d x:%d y:%d  HACTIVE:%d VACTIVE:%d\n"
 			"src_rect: height:%d width:%d x:%d y:%d  dst_rect: height:%d width:%d x:%d y:%d  clip_rect: height:%d width:%d x:%d y:%d\n",
 			__func__,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d983bab7eea3..fa4c142ac271 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1350,6 +1350,8 @@ struct dc_debug_options {
 	uint32_t dml21_custom_derate_at_dpm[DML2_MAX_NUM_DPM_LVL];
 	bool override_utm_client_qc_profile;
 	uint8_t utm_client_qc_profiles[4];
+	/* keep HW viewport unchanged by shrinking only recout for visual confirm */
+	bool visual_confirm_full_viewport;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 3b70e97c0a6a..f192c95952ab 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -675,6 +675,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.force_cositing = CHROMA_COSITING_NONE + 1,
+	.visual_confirm_full_viewport = true,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.53.0


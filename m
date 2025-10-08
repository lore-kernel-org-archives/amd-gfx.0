Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D050CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C777710E8C5;
	Wed,  8 Oct 2025 18:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8kdXLC7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A2110E8C5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwqkTepb9oKQBlZ9zloHz0AviMVvbeVRJreQaUAj7IKysr+f6D6UUp0mLplFHY+M3h1RNa5Ki9Ve2cP34Wu2RAVCTzbWngZrh/BgSKGjJzolIORwqIgGfYtN02JRxR1lMzjN+jeQnnJr3CCz18CJskm4qHttSnMwBrYszxC3D90EcbKtoPf2m6SzHWU1YD2F2mmxR5vK4tQCVWjntqWQq8jWsh8/8w/fvfuARKBxW3iQulouD9q6+Y2938Stl0lQaSm2oG/1LdV+TAUEOwOOJC0Nqkws/RVUnV9rBHexz2B2FD1LGxf89uraGPFMG/lKSAd/mNg19CP/xFBNuGAaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSWLj6bghbGM3a2NeX/mPcicqX6DhZdjpJg99UUB1AU=;
 b=nHOm9BG1e+ob9qg/qbVHlX0sNiSoexm6V/bxHIzMbyc9KZfs3DNSLJjOTB4dDkSPcN/LabxaOmsaIsBzCWAJZkQAen/J5z+mdwJW3gRwLnuadGn+BPYXm2cvkRwd6VY17V1DTG14h7zbfERjxvxAM61i7O/vshvGpY62RYKQ3J++tboPG8oF8MvpkNu6FRFgvHyXq/Tx7C6udNzEP5vJwGGq71zwq+v4xZs/aXChxDhPH6KwWCSwR92LjDkcvWUi3wDZjSt1MwKLXIE7oIyRXjwPOvZ+h3X34vcSpOILGe+5X7olhzphTYhOYajARDqb1TQq6tQrK6v1AQpStieCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSWLj6bghbGM3a2NeX/mPcicqX6DhZdjpJg99UUB1AU=;
 b=R8kdXLC7MJAky18g3RsaaNE8YXO5yBMg2UahO9UD5QYgLXWpbz7m59cVlcYvgY1mZ5MgyVZuyVOulCJOBaNPsUG8rLDmmAIdEifB09yfu3OpXchgbn9jybjj++tBeRM9gLIy+uFQYY51hj4DXEZDASyQaTsjBe6uQRH5NfloRic=
Received: from BYAPR06CA0045.namprd06.prod.outlook.com (2603:10b6:a03:14b::22)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:38 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::58) by BYAPR06CA0045.outlook.office365.com
 (2603:10b6:a03:14b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.19 via Frontend Transport; Wed,
 8 Oct 2025 18:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:49:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:52 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:52 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:51 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 18/22] drm/amd/display: Remove dc state from check_update
Date: Wed, 8 Oct 2025 14:47:12 -0400
Message-ID: <20251008184839.78916-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 405b800a-9452-45fa-a6e8-08de069b6e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AKZz0F/Qn3COxEToxc39E/XcbKuorG/bluGEHOZRB38rFFeFTK9MdmfLOD2w?=
 =?us-ascii?Q?YW1TRD2JALii+DQhcNx0XXSAdN/H8UQY4XJGA0OiVYQ7oXZJt6NFKDRxo5Ge?=
 =?us-ascii?Q?YBDdANcKLV7Di0ZNhbEBj96uHYLFJUssM4+4BfLlt4w6ZTXAaBx4uByMXC3B?=
 =?us-ascii?Q?/qz8TPND1+p1ZQje+PGwH6Am118g1uecRv2zD1K+o8HDpy0I8YyHODyYhQb5?=
 =?us-ascii?Q?ldOJoU43wwG6WNFwQIAg+iHid1E15njrm4IZE/uQOnBWrpWT8L1HcM70P0ar?=
 =?us-ascii?Q?Zj2Ngj9WcFkD516mvMbeMUNklK/JTLHBacaztgj7nBO40Ixn3Zs39eWYLk0G?=
 =?us-ascii?Q?Q1q1cRuXaWJHwcxhd1d10CO35v56rPiQSPillKLFv7SfD3BwlfP75Ehq1K+w?=
 =?us-ascii?Q?rF87hmPDg7XDJ9iDSWbdIN/oYc/AREHV8cMpalH7mHNGSpzApSRRTjdaRmrt?=
 =?us-ascii?Q?/J0YEuqUlCIKD5dwoVdyilLPbgDXguZGFXQkAgdZXUnbS3chOWJErbM0bH3J?=
 =?us-ascii?Q?/eJIlB+jvfcOS8GxJkQM2kMkIP6HAkLIYyZ+b/wmvFBhpxwphkxXf9JXmV43?=
 =?us-ascii?Q?3zaP70tz/PEdwY2YDI51f430adxRd13EqOFqKO4aQOHuY8iYUsCO9eiq6gRO?=
 =?us-ascii?Q?CxaG7XdZ7u3WNBIvKGQZnMX0Ziw+60LOYI2IFdvQETtOe8mM45tOI5wDAYnh?=
 =?us-ascii?Q?Gp5q+VQBl78uPMDMzbNSVi4kgDLL/sZtwgKpG+n7qY8RwemMcmJjMG1FeH4t?=
 =?us-ascii?Q?ZGzZeH6SnBdcrHSQyyI0Lvta94zNCoAVQS4aRKWK/Z6MyYcmasiE9OyrGSRl?=
 =?us-ascii?Q?ntKZlR1+VwIptZ89ZGajxrMXxXcNHULFKE9bV5joKX8qHcIkyRRff1ZrupsK?=
 =?us-ascii?Q?m4Tr3r/tN4MJ7YBXLaxXEWUuQk7DdoJ1ac/KEuYFeHoSddvxgK/Y9IhHlv3p?=
 =?us-ascii?Q?EXh3DPOwWYL1lQ9MkKOBKXKqM7Q61GOF0E5aue/VONXynNRt2I6E8tx4mIui?=
 =?us-ascii?Q?F2ylwfgJy6fUrXaCPnShLWpaQnrkJ4M04PfQQPTOHgLp0MsSUmLL1XQrGY15?=
 =?us-ascii?Q?quKui27sLGWhhPP0v+YPFYzGCfWULT/UeRIaf4+OIi7SbG7tYecBYgi/I87A?=
 =?us-ascii?Q?D5pt3nEuK/Cx+++zKVh61yccM017n1quHYM7ajcCamYe3TULm2XiqmVEhuyp?=
 =?us-ascii?Q?h7C7StGt/vE3++8NJ+/IFT0RTS/OhTRjokvza21+xz7jVlIMUObq6dLUEOep?=
 =?us-ascii?Q?UsZGjKH7wtAJ2UaiHJP09IqQGx68hdjNe7VlEbyLqGxWYoNbmt6fe41uCwnT?=
 =?us-ascii?Q?6UUpTNxboXXBpkqbvGmQ9uUUb4hbdkGk+QzF1I1+i8xC4DgUFu9bkaUphoKz?=
 =?us-ascii?Q?q5ioFqgv6v432+qhqYyIG3oOQ6ASu9tP9ztr7FlC5AdjencSBaFtP7aJNBk4?=
 =?us-ascii?Q?POYHQStfkUiB42IFd9eG1fTIAUic41/3H/XdDm1hhGdLODmA6wgeZ6piywaU?=
 =?us-ascii?Q?ASPvE+G6GnOJigUSpw1IXHYS/LEvLvqb3KJWwBNami1xWuyGQeVGoAXNBdfD?=
 =?us-ascii?Q?p/yTKxbmoM6ai1BJQro=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:36.7478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405b800a-9452-45fa-a6e8-08de069b6e06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
dc_check_update_surfaces_for_stream should not have access to entire
DC, especially not a mutable one. Concurrent checks should be able
to run independently of one another, without risk of changing state.

[How]
* Remove access to dc state other than debug and capacity.
* Move some checks from DC to DM caller.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 81 ++++++++++++------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2c2635b6cb0f..34e417a12304 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2725,21 +2725,32 @@ static enum surface_update_type get_plane_info_update_type(const struct dc *dc,
 		elevate_update_type(&update_type, UPDATE_TYPE_MED);
 	}
 
+	const struct dc_tiling_info *tiling = &u->plane_info->tiling_info;
 
-	if (memcmp(&u->plane_info->tiling_info, &u->surface->tiling_info,
-			sizeof(struct dc_tiling_info)) != 0) {
+	if (memcmp(tiling, &u->surface->tiling_info, sizeof(*tiling)) != 0) {
 		update_flags->bits.swizzle_change = 1;
 		elevate_update_type(&update_type, UPDATE_TYPE_MED);
 
-		/* todo: below are HW dependent, we should add a hook to
-		 * DCE/N resource and validated there.
-		 */
-		if (!dc->debug.skip_full_updated_if_possible) {
-			/* swizzled mode requires RQ to be setup properly,
-			 * thus need to run DML to calculate RQ settings
-			 */
-			update_flags->bits.bandwidth_change = 1;
-			elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+		switch (tiling->gfxversion) {
+		case DcGfxVersion9:
+		case DcGfxVersion10:
+		case DcGfxVersion11:
+			if (tiling->gfx9.swizzle != DC_SW_LINEAR) {
+				elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+				update_flags->bits.bandwidth_change = 1;
+			}
+			break;
+		case DcGfxAddr3:
+			if (tiling->gfx_addr3.swizzle != DC_ADDR3_SW_LINEAR) {
+				elevate_update_type(&update_type, UPDATE_TYPE_FULL);
+				update_flags->bits.bandwidth_change = 1;
+			}
+			break;
+		case DcGfxVersion7:
+		case DcGfxVersion8:
+		case DcGfxVersionUnknown:
+		default:
+			break;
 		}
 	}
 
@@ -2808,12 +2819,11 @@ static enum surface_update_type get_scaling_info_update_type(
 static enum surface_update_type det_surface_update(const struct dc *dc,
 		const struct dc_surface_update *u)
 {
-	const struct dc_state *context = dc->current_state;
 	enum surface_update_type type;
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
-	if (!is_surface_in_context(context, u->surface) || u->surface->force_full_update) {
+	if (u->surface->force_full_update) {
 		update_flags->raw = 0xFFFFFFFF;
 		return UPDATE_TYPE_FULL;
 	}
@@ -2944,12 +2954,6 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	int i;
 	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
 
-	if (dc->idle_optimizations_allowed || dc_can_clear_cursor_limit(dc))
-		overall_type = UPDATE_TYPE_FULL;
-
-	if (stream_status == NULL || stream_status->plane_count != surface_count)
-		overall_type = UPDATE_TYPE_FULL;
-
 	if (stream_update && stream_update->pending_test_pattern) {
 		overall_type = UPDATE_TYPE_FULL;
 	}
@@ -3046,27 +3050,6 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 		updates[i].surface->update_flags.raw = 0;
 
 	type = check_update_surfaces_for_stream(dc, updates, surface_count, stream_update, stream_status);
-	if (type == UPDATE_TYPE_FULL) {
-		if (stream_update) {
-			uint32_t dsc_changed = stream_update->stream->update_flags.bits.dsc_changed;
-			stream_update->stream->update_flags.raw = 0xFFFFFFFF;
-			stream_update->stream->update_flags.bits.dsc_changed = dsc_changed;
-		}
-		for (i = 0; i < surface_count; i++)
-			updates[i].surface->update_flags.raw = 0xFFFFFFFF;
-	}
-
-	if (type == UPDATE_TYPE_FAST) {
-		// If there's an available clock comparator, we use that.
-		if (dc->clk_mgr->funcs->are_clock_states_equal) {
-			if (!dc->clk_mgr->funcs->are_clock_states_equal(&dc->clk_mgr->clks, &dc->current_state->bw_ctx.bw.dcn.clk))
-				dc->optimized_required = true;
-		// Else we fallback to mem compare.
-		} else if (memcmp(&dc->current_state->bw_ctx.bw.dcn.clk, &dc->clk_mgr->clks, offsetof(struct dc_clocks, prev_p_state_change_support)) != 0) {
-			dc->optimized_required = true;
-		}
-	}
-
 	return type;
 }
 
@@ -3436,6 +3419,12 @@ static void update_seamless_boot_flags(struct dc *dc,
 	}
 }
 
+static bool full_update_required(struct dc *dc,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update,
+		struct dc_stream_state *stream);
+
 /**
  * update_planes_and_stream_state() - The function takes planes and stream
  * updates as inputs and determines the appropriate update type. If update type
@@ -3483,6 +3472,8 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	context = dc->current_state;
 	update_type = dc_check_update_surfaces_for_stream(
 			dc, srf_updates, surface_count, stream_update, stream_status);
+	if (full_update_required(dc, srf_updates, surface_count, stream_update, stream))
+		update_type = UPDATE_TYPE_FULL;
 	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
 	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
 	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
@@ -3514,6 +3505,16 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		}
 	}
 
+	if (update_type == UPDATE_TYPE_FULL) {
+		if (stream_update) {
+			uint32_t dsc_changed = stream_update->stream->update_flags.bits.dsc_changed;
+			stream_update->stream->update_flags.raw = 0xFFFFFFFF;
+			stream_update->stream->update_flags.bits.dsc_changed = dsc_changed;
+		}
+		for (i = 0; i < surface_count; i++)
+			srf_updates[i].surface->update_flags.raw = 0xFFFFFFFF;
+	}
+
 	if (update_type >= update_surface_trace_level)
 		update_surface_trace(dc, srf_updates, surface_count);
 
-- 
2.51.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303D0E9A04A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA0910E602;
	Wed, 18 Feb 2026 16:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJb3C9L6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB71710E601
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFgMibuswHUrxb+BtMYE/ERYP0NaQIR2yfO6ARLlN3/Q1S+7P/YqMRktj+AiXBY6a3ZS59rYaDNx3JSllNkAKUDjk8go1fe5dTWCGkzNh4qSx71qAudcp6aYUDNaGClISVSRlgx6gDBC4TTS1vwvkbX3MPogGlHG7VNNEbYh3ga0SanFbWnqUB/tVE+lVt6MzYZbAQjtw2QOnKC5115YF+V/m7zxKRZ2BheNxCPK18ES5HvGhivG5RojThb2eJPbfl11rKAXaEvnkUvwqvLiQhZdbDwEc9Zwy+MBODEOBJquZoCxvarNopKjWXb3SlfWr2XZrK0AMf/kwm+5b4i3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9SDbz2yodGORKUXG+29hKHBjLpoi2DLY3gKOjXrSLs=;
 b=GSebERRtbE1SeepQg7b6R3kj6IjqmKBLNBhd+u4XOXUSBBkmV1gJuYKj7NVcnll0TnPF+YS1px8WWjWK5wRkwAFpgpmUUDldU09NDZzGGwiWQTzuj29q2ItXKvzEb+dgfkFFNA7m8s+nWNahEOIIXgZ3P+B5PRNiq0BSv3mr2DetMOpDHnMRYWRmPqMgiOnhKinoUPcK0BxIjWdnH/WxqUgvSgmG4LzKR4CWg3PYIO1XUI2oDGCeSXZ5qXAmkpQ85ykjPPMXFuDbExboH7R0EL9MbhWYmw9FVvJSIaSzy+8PqzCrjpsgVlj6kNlx9h0oIlkPRYGd+OrDE99TGwynPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9SDbz2yodGORKUXG+29hKHBjLpoi2DLY3gKOjXrSLs=;
 b=MJb3C9L6TD66k1DlRgZYjvwpuxRK+2eQeZDH6HOroPtBSy9qsqI0rrM2g7LfxL7VBxoH6awUdWp64RUQLhAemcvFAJNfrxjJkavQcP8WFixVwOCQeuKPWdX8RvM4JE86sY0wfE6QnK+16wfyUCS0UHup88N3AD/mczWSO9JavMU=
Received: from BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 16:51:32 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::79) by BN9PR03CA0183.outlook.office365.com
 (2603:10b6:408:f9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Wed,
 18 Feb 2026 16:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:25 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:25 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Muaaz Nisar <muanisar@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 7/9] drm/amd/display: Add Visual Confirm Support for Testing
Date: Wed, 18 Feb 2026 11:48:08 -0500
Message-ID: <20260218165116.155001-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: adab4c85-c98c-4295-2cdf-08de6f0df870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o2mk3VDXhAh6ramPE0jRfbKGMElED5pFb+LUnO6o5nGSsYLOYwjjfhrqnE8k?=
 =?us-ascii?Q?+uQ70PxuWmYlM9NlLDo2X/foAX+s8FPfS7yEkMJnaoIyCY2zgczQU0WQXuTx?=
 =?us-ascii?Q?M3XJ1v5U/x6KnjJpb+MrcMu3b07Qz6PfTLrKb38QYEF5w8uCPwNhFfc8Ky2j?=
 =?us-ascii?Q?rMukdYPbO78Cak4/wdzukc/PJID9FfeCdkB17qwQJEVwv487+KZnRcOjgH50?=
 =?us-ascii?Q?Jvf4VaMTsG4Knrd/VGGLXAFiSzjCQXwHWiRbSZOZ4C8eZhF+0jmiH4QRd3tM?=
 =?us-ascii?Q?Dxhl3jMNPUZzuxAQtK8HraORnzvvb0rpCQ4nwTH/CPKo+DwePBVLKMhNynbZ?=
 =?us-ascii?Q?Bl62VNq1h7xVkrTBmff+GGgteTG6+WrZK5k4f8zs95BoaX2Lm1euY0OQNqGt?=
 =?us-ascii?Q?2zioLOkoeSnYRhXrl2Zm1ZIg3K8rj6jqzxSR0+NRYjR26s4GtO+zaYHBb3Wz?=
 =?us-ascii?Q?+L3dmsHv/bR8n/aXjdgO/qCTVRdaR6jKkdB8h/aqlq70PDmfggbGnYQNKhMq?=
 =?us-ascii?Q?6wkFSz7+fvfi3WuLloowgPiPLumFd5uj0wCBFESnP2lj1B1XqCKyzthVtDlS?=
 =?us-ascii?Q?VldY+qdMLDtBZ9KkMMY2kjEIsTe0owaa+tXqoKkhGXxvzR7AQePsJ2hBeZRg?=
 =?us-ascii?Q?gtAhBsPdNkhFTawL9jRXB+6aEwfoO0LhoBkeCGBsOplbBRD92c4lkvqX7fDe?=
 =?us-ascii?Q?cnZ8vZ9hF7cdmnd5vwqSrkiS50NJSqTSJSiIVzw2fVwE5J9/Qj6Hot3hrNw3?=
 =?us-ascii?Q?uyR1MXnAtHE10oKc9rO9hyLm9YjOYAHeDOPuQGQJu+wWsLI9JCgCXuhqpOIE?=
 =?us-ascii?Q?Q7bUA4RnpCzZtRPoQOnJXH/fb07v8K3QRbdeUicrOFVqb+7iQXU09mBadsyl?=
 =?us-ascii?Q?CXHwPbP3Cdq59p2XJzxSyECr0IGfqVguz11ElqGqJvCMSKGL4uvncFAFCZPx?=
 =?us-ascii?Q?cUXF3o6rYz8tMQK5cNgnS/YWl3HP1p4LIwExw+85HJGyBV8dI2EYrt7A/XKQ?=
 =?us-ascii?Q?1fcCGqwnb1BqcBXbUFhUfaszV/ZfztbIPpFEqbchS3hFLa1Se3rPHphc3WNj?=
 =?us-ascii?Q?XweJAbTUsCBtByGtNRDn6UQG7Oth/74VbBuuKmuPTQx4qn/VXT86ciwfq7ap?=
 =?us-ascii?Q?EZeBJXUVYxkQIcDfz+wtXjaiCQdRSAz0K5BkpuEPcmTN8lHKdF6zudCrmjCc?=
 =?us-ascii?Q?fK4G146gk0dL36HzQiaScRNv0OaS4QJh3ufc5HmZkUGG5W7TCKaPHC7WmGzW?=
 =?us-ascii?Q?q8Tm1uPwyZuqNNgCwpaTExFNxNlm/XO35ChwjEYav9PnP2ZUVY5sgPcxConB?=
 =?us-ascii?Q?CQS6JTNksIoQ1Wcw+KEE0k/xABGiknGYkVoHDkwOzM3SYTY6DajkIUu7lIVY?=
 =?us-ascii?Q?7rgc15YphbPI5H2iFl0QpYfNmCeFxLVxJBcUfo7Z5on5Y09Tq1hkP1GB5N3b?=
 =?us-ascii?Q?WkzcqVy0Fe3DNSX6AUE4LHFBgtJNJ1mvKUbdn2bfFklxtWm8KIbfvRX+Hehq?=
 =?us-ascii?Q?Gn9Gx2tD8m/Za7VL62AYSx2zn0jvbOwZavHXwcAaRo4LhE9FQRHr7OBvzTfS?=
 =?us-ascii?Q?R8U3BjiAY9np0PpBaJCvFHPT601zoZYneQq20emaKM+EDhAPUToQ79LN3bHs?=
 =?us-ascii?Q?9aY1uPfogPLNIqUMdowXVMpFuEaTG0bT5phB4UZWKpjGktUkflgpzAqjBVpN?=
 =?us-ascii?Q?Y3ecNA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bCDOmd059Xh/KkcY5wi+1gJvpGVgrmI9DquFTjnx9eZYfjhtf8j1TL23prKR5laA6bS/AkBfPvDiN+YqIfEKJvbZIH9bYw9h/pPn1050ujRpW7Fj761MVgBdXWHN7dCKKgEx7pONbZ73pC17Ad1Iz0U3IWWGNWqgQcsm7EnqkeNORi6kfH/qZ1qmFpCVtiSRGV7jWbVDP6zIj8n8GOf5uzixLAxf9m2HxbNsslIzYucryFbPD+JfiaE20CffJkHOKyYi/bcMk9VZt+ZbaxxEjyunRQSqZ2p84lYIjUDnWGsXEI8EB7GlKQaX9vVzxaJ5y8zwQBUkXKzqGd9xbBAbpSgkMwvTodAsVPdDN23T95UUdkaZfxME7WMGgwutl8jiPttOpAqUgAlhKcST+i2SDvvNnw2pM9s/S9i+6tZ8ZS4zET2Yn+N92I89LA3xCe7W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:32.6126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adab4c85-c98c-4295-2cdf-08de6f0df870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

From: Muaaz Nisar <muanisar@amd.com>

[WHY+HOW]
Adding visual confirm to visually track changes in refresh rate.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Muaaz Nisar <muanisar@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 148 ++++++++++--------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  21 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   4 +
 4 files changed, 105 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0421012803b8..c17f065a88d4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -442,75 +442,6 @@ static bool set_long_vtotal(struct dc *dc, struct dc_stream_state *stream, struc
 	return false;
 }
 
-/**
- *  dc_stream_adjust_vmin_vmax - look up pipe context & update parts of DRR
- *  @dc:     dc reference
- *  @stream: Initial dc stream state
- *  @adjust: Updated parameters for vertical_total_min and vertical_total_max
- *
- *  Looks up the pipe context of dc_stream_state and updates the
- *  vertical_total_min and vertical_total_max of the DRR, Dynamic Refresh
- *  Rate, which is a power-saving feature that targets reducing panel
- *  refresh rate while the screen is static
- *
- *  Return: %true if the pipe context is found and adjusted;
- *          %false if the pipe context is not found.
- */
-bool dc_stream_adjust_vmin_vmax(struct dc *dc,
-		struct dc_stream_state *stream,
-		struct dc_crtc_timing_adjust *adjust)
-{
-	int i;
-
-	/*
-	 * Don't adjust DRR while there's bandwidth optimizations pending to
-	 * avoid conflicting with firmware updates.
-	 */
-	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
-		if (dc->optimized_required &&
-			(stream->adjust.v_total_max != adjust->v_total_max ||
-			stream->adjust.v_total_min != adjust->v_total_min)) {
-			stream->adjust.timing_adjust_pending = true;
-			return false;
-		}
-	}
-
-	dc_exit_ips_for_hw_access(dc);
-
-	stream->adjust.v_total_max = adjust->v_total_max;
-	stream->adjust.v_total_mid = adjust->v_total_mid;
-	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
-	stream->adjust.v_total_min = adjust->v_total_min;
-	stream->adjust.allow_otg_v_count_halt = adjust->allow_otg_v_count_halt;
-
-	if (dc->caps.max_v_total != 0 &&
-		(adjust->v_total_max > dc->caps.max_v_total || adjust->v_total_min > dc->caps.max_v_total)) {
-		stream->adjust.timing_adjust_pending = false;
-		if (adjust->allow_otg_v_count_halt)
-			return set_long_vtotal(dc, stream, adjust);
-		else
-			return false;
-	}
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-
-		if (pipe->stream == stream && pipe->stream_res.tg) {
-			dc->hwss.set_drr(&pipe,
-					1,
-					*adjust);
-			stream->adjust.timing_adjust_pending = false;
-
-			if (dc->hwss.notify_cursor_offload_drr_update)
-				dc->hwss.notify_cursor_offload_drr_update(dc, dc->current_state, stream);
-
-			return true;
-		}
-	}
-
-	return false;
-}
-
 /**
  * dc_stream_get_last_used_drr_vtotal - Looks up the pipe context of
  * dc_stream_state and gets the last VTOTAL used by DRR (Dynamic Refresh Rate)
@@ -1274,6 +1205,8 @@ static void dc_update_visual_confirm_color(struct dc *dc, struct dc_state *conte
 				get_fams2_visual_confirm_color(dc, context, pipe_ctx, &(pipe_ctx->visual_confirm_color));
 			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_VABC)
 				get_vabc_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_BOOSTED_REFRESH_RATE)
+				get_refresh_rate_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
 		}
 	}
 }
@@ -1323,6 +1256,83 @@ void dc_get_visual_confirm_for_stream(
 	}
 }
 
+/**
+ *  dc_stream_adjust_vmin_vmax - look up pipe context & update parts of DRR
+ *  @dc:     dc reference
+ *  @stream: Initial dc stream state
+ *  @adjust: Updated parameters for vertical_total_min and vertical_total_max
+ *
+ *  Looks up the pipe context of dc_stream_state and updates the
+ *  vertical_total_min and vertical_total_max of the DRR, Dynamic Refresh
+ *  Rate, which is a power-saving feature that targets reducing panel
+ *  refresh rate while the screen is static
+ *
+ *  Return: %true if the pipe context is found and adjusted;
+ *          %false if the pipe context is not found.
+ */
+bool dc_stream_adjust_vmin_vmax(struct dc *dc,
+		struct dc_stream_state *stream,
+		struct dc_crtc_timing_adjust *adjust)
+{
+	int i;
+
+	/*
+	 * Don't adjust DRR while there's bandwidth optimizations pending to
+	 * avoid conflicting with firmware updates.
+	 */
+	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
+		if (dc->optimized_required &&
+			(stream->adjust.v_total_max != adjust->v_total_max ||
+			stream->adjust.v_total_min != adjust->v_total_min)) {
+			stream->adjust.timing_adjust_pending = true;
+			return false;
+		}
+	}
+
+	dc_exit_ips_for_hw_access(dc);
+
+	stream->adjust.v_total_max = adjust->v_total_max;
+	stream->adjust.v_total_mid = adjust->v_total_mid;
+	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
+	stream->adjust.v_total_min = adjust->v_total_min;
+	stream->adjust.allow_otg_v_count_halt = adjust->allow_otg_v_count_halt;
+
+	if (dc->caps.max_v_total != 0 &&
+		(adjust->v_total_max > dc->caps.max_v_total || adjust->v_total_min > dc->caps.max_v_total)) {
+		stream->adjust.timing_adjust_pending = false;
+		if (adjust->allow_otg_v_count_halt)
+			return set_long_vtotal(dc, stream, adjust);
+		else
+			return false;
+	}
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream && pipe->stream_res.tg) {
+			dc->hwss.set_drr(&pipe,
+					1,
+					*adjust);
+			stream->adjust.timing_adjust_pending = false;
+
+			if (dc->debug.visual_confirm == VISUAL_CONFIRM_BOOSTED_REFRESH_RATE) {
+				if (pipe->stream && pipe->plane_state) {
+					dc_update_visual_confirm_color(dc, dc->current_state, pipe);
+					dc->hwss.update_visual_confirm_color(dc, pipe, pipe->plane_res.hubp->mpcc_id);
+
+				}
+			}
+
+			if (dc->hwss.notify_cursor_offload_drr_update)
+				dc->hwss.notify_cursor_offload_drr_update(dc, dc->current_state, stream);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index b38004441616..5b3695e72e19 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -4108,3 +4108,24 @@ void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
 		(*seq_state->num_steps)++;
 	}
 }
+
+
+void get_refresh_rate_confirm_color(struct pipe_ctx *pipe_ctx, struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	unsigned int refresh_rate = 0;
+	uint32_t scaling_factor = 0;
+	if (pipe_ctx && pipe_ctx->stream && color) {
+		refresh_rate = (pipe_ctx->stream->timing.pix_clk_100hz * 100) / (pipe_ctx->stream->adjust.v_total_max * pipe_ctx->stream->timing.h_total);
+
+		uint32_t min_refresh_rate = pipe_ctx->stream->timing.min_refresh_in_uhz / 1000000;
+		uint32_t max_refresh_rate = pipe_ctx->stream->timing.max_refresh_in_uhz / 1000000;
+
+		if (max_refresh_rate - min_refresh_rate)
+			scaling_factor = MAX_TG_COLOR_VALUE * (refresh_rate - min_refresh_rate) / (max_refresh_rate - min_refresh_rate);
+
+		pipe_ctx->visual_confirm_color.color_r_cr = color_value;
+		pipe_ctx->visual_confirm_color.color_g_y = scaling_factor;
+		pipe_ctx->visual_confirm_color.color_b_cb = color_value;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d2ea4e03c963..7126dc278a53 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -581,6 +581,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_HW_CURSOR = 20,
 	VISUAL_CONFIRM_VABC = 21,
 	VISUAL_CONFIRM_DCC = 22,
+	VISUAL_CONFIRM_BOOSTED_REFRESH_RATE = 23,
 	VISUAL_CONFIRM_EXPLICIT = 0x80000000,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d699640ba5b4..d1dba7ffcd9b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1365,6 +1365,10 @@ void get_dcc_visual_confirm_color(
 	struct pipe_ctx *pipe_ctx,
 	struct tg_color *color);
 
+void get_refresh_rate_confirm_color(
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
+
 void set_p_state_switch_method(
 		struct dc *dc,
 		struct dc_state *context,
-- 
2.43.0


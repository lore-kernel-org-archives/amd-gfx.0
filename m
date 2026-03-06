Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C57F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0FF510E26B;
	Fri,  6 Mar 2026 03:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bhAAJC5m";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F37510E26B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ71cCP+tguegXYEbRbfQsLvKHLdP2DzZ+frz/4gxmozKit65cz9P4vwyht6PuQZrP9UiTy8wLacKr0R6OIljGxeFYAZ/HP0WqugXpPWZZRZ89jJZY+ghYElVRqljdJIWxJUQZebxQH3mqB7chN9LQkR7wFi75cfSNulztoDCQRfSRM5AmKSLf/Senm/ovCUjcdGqzcetfi5uZo/VIzA6KMMNSyJQp3BD3IOKm/zQR36hvvN7o9PRy0Dk6yLkq+s22jQ7UZ3Dgts9wdf7HI6qo6snylvD2pRemMLDrsMuneTXaqB3MabdkZrBtWrY1AlrORGgsVWr2NPM4Bf8eYUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGp6AoUPSlY9wr7a/t3VIAr+KKl100vvadLnYXE6znI=;
 b=nebdx5LG6pzzNUUUm9N3Vje866UfLjlEu5nEzGfTLsXmT0oCJRVZeZrm7+X3n9MfMcajJ+D6li2+S9W82Diyj9H/ZGQggq7Mx9oHQWq4SN6eZtSNPvnT+5xUYTkq7g19dHLgXaBm89qVCOu6vooOgP3V4rZn+tMi7gQdjq///4KLEh4HKowLEfbwA372pDnjWxBXuRviTCmIujVogAXj9rMQZJ65ey+ythVF2OgrNpf6sF1ePN2sfYhb6NzpKe3NQD92pw7Kyi9JA9bxYXB/6K7VNmYNfwPEOiIPmBJwvspX4dJ6RmWxnAEilFX7YA9IlZECEhWGwfzWq0H7c89wGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGp6AoUPSlY9wr7a/t3VIAr+KKl100vvadLnYXE6znI=;
 b=bhAAJC5mXRSSXf585OiArxbInWF2AuDboR4l6Szg+x4zqnRJ7xknG3stuHQKJCYSc657RInDKbkY2uPM6BKwCsI10T99VKeEi7V8O2QU27rV0HWDHzBDlgPmJXvEIju2+xI8QwWRKqpYbHsOoPhtZaNRL5Wps3biKZiy7o/8pjM=
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 03:24:02 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::6f) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Fri,
 6 Mar 2026 03:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:24:00 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:23:58 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 01/21] drm/amd/display: Clean up NULL pointer warnings in dml2
Date: Thu, 5 Mar 2026 20:13:27 -0700
Message-ID: <20260306031932.136179-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c767ce-cd29-407a-5f97-08de7b2fcf85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016; 
X-Microsoft-Antispam-Message-Info: b43bJrsKbPG3QKCz7BqR4I61e4D4THkpWQSb56ayGjGs25dBt2vInXRdV+sKdwDZON3qofrbdPIgijR4iSM8EkWdy8P9fiwCLEivtDQ0r7Ob/13s8tw37a/ixFt7FBp+VUfZEYGIowCPi6lMBygZ7kmRCt2Hlg+UQMxsAATgoeqUSllKegSanF1hPcqPpGqEtrwvDFjSzKXa9kBI/hq66D1gqk8Wbk6TwwlbAVkzc5yej4Q29JMoBF+sfIZb4P3ICnIrVow25wMX9ixxlCQ3wN8nvTZGUBzly9gNxe2rLJFK8q+5T10WjosLNdaysfcYXm+UzNHorTxpCdGC3juyxO05LpANiYF/dbCmZZtTLVu9pDzKKTyQp2RpZjvO1xYFETZUZ4ugWsP7DCTp1+cvzv4vlhA4lNuuJknaYxKKaqZP88WXzpSBhgnWeRvNj7Q1T+wF9BVWsJ17L27fyQ92dT9ZO1rfjKBhIOJz6rRPH51uolX5GUE3qPbi5t89W05tE5QezpKbPkIC/FXduKGwPTDJJtb0qAYakhnIpGLm6fLBaoRrTQagpOv4lEDzxxKKhbUHBUJcgvpW6xbmsFMIcyU6dmpQI2Ydm5Jq90Zu024JtEuJqIUT222yRibJzWk1K+YfzCsE1iMHt5kCSAui+Gv5rIJUCT8uKR48+jD8oCAaRHqsOwmggI7hnLHtjYcvze5ZXSAdWT7JCRJFVearqBianr+dwkFKmqaaX81gPnGUrD1dVKUXAzdcD4x69nNgopWXkDRD5a/HV5elH6JPOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RzcSqkFB+3oGoMeglJw1x/GwNawpzynmpb+hY1eRbRcZF54vihaeDvGdc2z+OT5Xo/klZMJ24aFJEiGt+OEWC4/l7jATcPAjbVxZ5lplsK90JnDAqU55By90uNECDxwjZLn8LVZAc2DHCGwwMlGo7UO8EeKFoPTtyYyDkJ97pTxmygPiJ3XY9aYbPioH/dt1vYiGQCTgD3R6eM4NiDjmIEhKSEeoNYG8d4c5KHa2i0hCj0DMRXcVel8d76bNBOS7tGd1NIh02VtMIxQoBQk+WleGbt6IPcvfqeBFcgUZxpf87URw6g232/yZ8GkbqQtq1DI3VMnZ+3FxXguAI6MpDN0ByMBORygQijolbr3kB7gCVrMiSPBleOdA7M4cjifVZdNuxv1nJRcQ/crVzEJOXF0Z8HhzBK29dcPCrN58Y6x5LFVtwRJHHBg7X1STAUvK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:24:00.7117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c767ce-cd29-407a-5f97-08de7b2fcf85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

This commit addresses multiple warnings by adding defensive
checks for NULL pointers before dereferencing them. The changes ensure
that pointers such as are validated, preventing potential undefined
behavior.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c | 41 +++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index 66040c877d68..d56e58ce26c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -357,7 +357,7 @@ static bool enough_pipes_for_subvp(struct dml2_context *ctx, struct dc_state *st
  */
 static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *context)
 {
-	struct pipe_ctx *subvp_pipes[2];
+	struct pipe_ctx *subvp_pipes[2] = { NULL, NULL };
 	struct dc_stream_state *phantom = NULL;
 	uint32_t microschedule_lines = 0;
 	uint32_t index = 0;
@@ -369,6 +369,9 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		uint32_t time_us = 0;
 
+		if (pipe == NULL || pipe->stream == NULL)
+			continue;
+
 		/* Loop to calculate the maximum microschedule time between the two SubVP pipes,
 		 * and also to store the two main SubVP pipe pointers in subvp_pipes[2].
 		 */
@@ -386,14 +389,19 @@ static bool subvp_subvp_schedulable(struct dml2_context *ctx, struct dc_state *c
 			if (time_us > max_microschedule_us)
 				max_microschedule_us = time_us;
 
-			subvp_pipes[index] = pipe;
-			index++;
+			if (index < 2)
+				subvp_pipes[index++] = pipe;
 
 			// Maximum 2 SubVP pipes
 			if (index == 2)
 				break;
 		}
 	}
+
+	/* Minimal guard to avoid C6001 before subvp_pipes[0]/[1] dereference */
+	if (index < 2 || !subvp_pipes[0] || !subvp_pipes[1])
+		return false;
+
 	vactive1_us = ((subvp_pipes[0]->stream->timing.v_addressable * subvp_pipes[0]->stream->timing.h_total) /
 			(double)(subvp_pipes[0]->stream->timing.pix_clk_100hz * 100)) * 1000000;
 	vactive2_us = ((subvp_pipes[1]->stream->timing.v_addressable * subvp_pipes[1]->stream->timing.h_total) /
@@ -459,6 +467,11 @@ bool dml2_svp_drr_schedulable(struct dml2_context *ctx, struct dc_state *context
 			break;
 	}
 
+	if (pipe == NULL || pipe->stream == NULL) {
+		// Defensive: should never happen, try to catch in debug
+		ASSERT(0);
+		return false;
+	}
 	phantom_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(context, pipe->stream);
 	main_timing = &pipe->stream->timing;
 	phantom_timing = &phantom_stream->timing;
@@ -549,6 +562,13 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 		if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
+
+	if (subvp_pipe == NULL) {
+		// Defensive: should never happen, catch in debug
+		ASSERT(0);
+		return false;
+	}
+
 	// Use ignore_msa_timing_param flag to identify as DRR
 	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
 		// SUBVP + DRR case
@@ -753,6 +773,12 @@ static void enable_phantom_plane(struct dml2_context *ctx,
 				return;
 		}
 
+		/* Minimal NULL guard for C6011 */
+		if (!phantom_plane) {
+			ASSERT(0);
+			continue;
+		}
+
 		memcpy(&phantom_plane->address, &curr_pipe->plane_state->address, sizeof(phantom_plane->address));
 		memcpy(&phantom_plane->scaling_quality, &curr_pipe->plane_state->scaling_quality,
 				sizeof(phantom_plane->scaling_quality));
@@ -880,6 +906,11 @@ bool dml2_svp_add_phantom_pipe_to_dc_state(struct dml2_context *ctx, struct dc_s
 	if (ctx->config.svp_pstate.force_disable_subvp)
 		return false;
 
+	if (!state) {
+		ASSERT(0);
+		return false;
+	}
+
 	if (!all_pipes_have_stream_and_plane(ctx, state))
 		return false;
 
@@ -898,6 +929,10 @@ bool dml2_svp_add_phantom_pipe_to_dc_state(struct dml2_context *ctx, struct dc_s
 	}
 
 	if (enough_pipes_for_subvp(ctx, state) && assign_subvp_pipe(ctx, state, &dc_pipe_idx)) {
+		if (state->res_ctx.pipe_ctx[dc_pipe_idx].stream == NULL) {
+			ASSERT(0);
+			return false;
+		}
 		dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(ctx, state->res_ctx.pipe_ctx[dc_pipe_idx].stream->stream_id);
 		svp_height = mode_support_info->SubViewportLinesNeededInMALL[dml_pipe_idx];
 		vstartup = dml_get_vstartup_calculated(&ctx->v20.dml_core_ctx, dml_pipe_idx);
-- 
2.43.0


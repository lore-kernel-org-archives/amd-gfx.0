Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE59CA0FE0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C8F10E7EA;
	Wed, 20 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cEY3LHVn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E172710E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/6KFRqlymT9u5SmtTnqTDAOhCZ9onEnTqfixCT4Ltzxcp7pRa6ssDvOYJ1FyAZTdyEZYuLuIsxbt0Wme8P3NxikqXsiYXc+Gy7uKtlt+Xpfa/+dGUsaIbJtifh9wDJC/Bgc9G1biDXZWORBf020cagZlHJi5QrcG0ggKCe++hBLSRZUwf2xXnbBhLryY4znS0dRKcwEOjnqj6uoDcXsh2lp3dm/ok2vvbNQF8DTeaFW7+kb50LWiXBl00n7yod3g+UxzscwErsU/7e4IeWSUePVZRBDaGpe6nozlf8qkYPAPRulDT5eLTFqee8VCHb5flEm8oL8+tSb+li8ggoFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddeAEP1EG2nqd6eBiGuNbkf+cViF8Az7OljzX9cQuqA=;
 b=b4JE1j5XzLhwu/ChlmVkIJYWPwWLcBmRb8+RF28Q1mWMRHrF6eadDyHZ+DJosSq7O0UT34y7BMC+ZtWOCF5JCdwXz4uI3WkOpLceNrR1ozt1zbsxkQDBWeAQWfPDsGHRTJTdlpJLxksKUFZaURmTKBRFXAF5ILuWPLpfyOJKpghXCSrWPISktA/kuDwTqTMRBsSDtwO3iGD45ZwV4ShKNE1MwRbFy229u7y4RSMeyKr/wVmWFrObusy+PEBrNq6aefudKfIWqJ1zFQ5DNoEG6K9/AiGtbYxMNxKftF5v/S8asxhAKDiDFQHBeNhxxkpMqUTzweZrGt3HwhDC7hPG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddeAEP1EG2nqd6eBiGuNbkf+cViF8Az7OljzX9cQuqA=;
 b=cEY3LHVnvm7sO6BXDbvdPqhdJxC3xiE/AiP7oNgUo63WUVbxbHRSLd/hi3ZpIODhNo9H0sCBjT+RgMBNLSO8f+uoZN5qF/bRylhPh47HTrKq0oA648m7ScTfOhnnYFzTyqtWJXQ9Vw54cibYvbBHf67bD1Rb4gpQJWbgpLDeuAg=
Received: from CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30)
 by CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 20:21:11 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::3c) by CH0PR03CA0055.outlook.office365.com
 (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 20:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:07 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/12] drm/amd/display: Support HW cursor 180 rot for any
 number of pipe splits
Date: Wed, 20 Aug 2025 16:19:55 -0400
Message-ID: <20250820202103.1122706-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: ff698a80-b293-470e-d0a1-08dde0271aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rVQ1uPQZE6wL9Qky88fCEsi9hPLDjS+KwTGhQKxkO0HQNMRtK3dTSLG9Ajxi?=
 =?us-ascii?Q?9CqA9wENWfDBO//gP42szSWzboYe9solGe1IhhEiVQyJid3zsNSxg4BshXn4?=
 =?us-ascii?Q?67PG0DkPHl2Ln1jnTnL23UeeT7lUAH8ameK6FPT+HFSbWhO1HOk4/5+1THK2?=
 =?us-ascii?Q?v7Z1yMoQTtmz74VATlRXJAmAoDTJCM92qmi1OjZX05Bc3lWqZ9Ngc4TmZiND?=
 =?us-ascii?Q?NAHO7CT8Xnr0wB9hv/SsLvzqjzJ0gsVHpEY5cr8n/Y9EMDpZoONBoCIoHzbw?=
 =?us-ascii?Q?83Yz3aPyUcQBXSrxwGxHcS2tQWdUMOWwaU11SuxcavTeuCjk8JirKHrBa8bW?=
 =?us-ascii?Q?Uiy6dxq3/Om0vcROzkNEL6PrGXEpqN6f9FWpxHTnuQ8wpqnrO/My9UKJSp7b?=
 =?us-ascii?Q?KcY6A1kwXf9Z32HCHk9kFoTGK/mYzsINxIp3jWY/dWjFmzE+L9LXl3j2pn8k?=
 =?us-ascii?Q?rIUCHwF9X2IfXT+uTFbTHjVPaGJUc9RzEehRp7tZGszOsXFIPSS8JSDb5RJX?=
 =?us-ascii?Q?6Gv/Vkqu0A3ZeIFREUcvORTGelBtXEypBY2O49zAEJKrKpXWPkM2l5sbA055?=
 =?us-ascii?Q?DZl3h0tQenF1h5ROoePojhCXS0o66t3ml+Rgv9UR/N/k/7Uc8/Gdh0tORxq0?=
 =?us-ascii?Q?SoVq2c+uoeHxIwPnJ1nbvlmiJbTJJA6X/eI8578t0G3jO+Zli2D3tSEka4kC?=
 =?us-ascii?Q?MyQtbwtV025yy14cXColT1nJKyehGppb+o5UL6QRFbznJsG6pcvD50/ALXpW?=
 =?us-ascii?Q?cb7KaNQRyLKGIXQtKGUevFyEZvSsOhcwzK/TFko5kmIIs3sv4X+zmSWyufCu?=
 =?us-ascii?Q?lf56NxyAUeyVyY52TztNULo3IKf8khXiqoB/SOtF1LyoyAx6jcHHhXJC6Qqr?=
 =?us-ascii?Q?Woe1SCELjCpmJa9jfXkVaDpHryY5l9u//ytzEEMxvdwgTO89BiizUITSg7+a?=
 =?us-ascii?Q?DeRTuBxnXIpmlHy/JdFPxbxIv/7gi5LWp/PEc3RbUPRHRLaI94lPaF6OpV2n?=
 =?us-ascii?Q?+ohsi9iqyJde1Ojfzl9oBQuBVBso/dY9Dhr64v/mUHJIkMeDBaLF17FCTeQW?=
 =?us-ascii?Q?nAKwZv6Dbhoq5fcCxKfwOaCyI7LoBys20TqOPurQH7Rc68HMCUP/r2q9m75/?=
 =?us-ascii?Q?4KX+XS/gyDC/ou2tttyLzMIp2Mp9phfG7h5nD077Ywt2FVe/9XUNFFbiC1zU?=
 =?us-ascii?Q?XaQIrMMt7KsgQifXSLd3pJ9l2m47HojOScd67icuq2JMoiPWPJ7RGaLKUW7N?=
 =?us-ascii?Q?5KQ35ncJdkNhf/SUUOIqmttGPt1aB0jmsbk2MTBmAf2yY6h/NzPxXo7ycrzJ?=
 =?us-ascii?Q?tdEFkXXvMgGnbWX807t0ODwX6P4twVCptG11o8xwWYB6mIatBPqhGR7ERVZ7?=
 =?us-ascii?Q?UPZVMZnYtu/7BVJM9QH/0QI33t4n7IJwJqU/CccB6rJzVwCVYIxqdilY+nRx?=
 =?us-ascii?Q?EmDyI9TpkYZZyKGkZcKSM6k3VTUKgc5bh/FJv2c8mov49fhOsHZ5y33WMobg?=
 =?us-ascii?Q?NbNre5+RJBXQKtIFAV5fafYWfJ0yhIR4c0d7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:11.6985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff698a80-b293-470e-d0a1-08dde0271aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
For the HW cursor, its current position in the pipe_ctx->stream struct is
not affected by the 180 rotation, i. e. the top left corner is still at
0,0. However, the DPP & HUBP set_cursor_position functions require rotated
position.

The current approach is hard-coded for ODM 2:1, thus it's failing for
ODM 4:1, resulting in a double cursor.

[How]
Instead of calculating the new cursor position relatively to the
viewports, we calculate it using a viewavable clip_rect of each plane.

The clip_rects are first offset and scaled to the same space as the
src_rect, i. e. Stream space -> Plane space.

In case of a pipe split, which divides the plane into 2 or more viewports,
the clip_rect is the union of all the viewports of the given plane.

With the assumption that the viewports in HUBP's set_cursor_position are
in the Plane space as well, it should produce a correct cursor position
for any number of pipe splits.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 73 +++++++------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index d633033c98f2..506c3bbbf221 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3663,6 +3663,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int y_plane = pipe_ctx->plane_state->dst_rect.y;
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
+	int clip_x = pipe_ctx->plane_state->clip_rect.x;
+	int clip_width = pipe_ctx->plane_state->clip_rect.width;
 
 	if ((pipe_ctx->top_pipe != NULL) || (pipe_ctx->bottom_pipe != NULL)) {
 		if ((pipe_ctx->plane_state->src_rect.width != pipe_ctx->plane_res.scl_data.viewport.width) ||
@@ -3681,7 +3683,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 */
 
 	/**
-	 * Translate cursor from stream space to plane space.
+	 * Translate cursor and clip offset from stream space to plane space.
 	 *
 	 * If the cursor is scaled then we need to scale the position
 	 * to be in the approximately correct place. We can't do anything
@@ -3698,6 +3700,10 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 				pipe_ctx->plane_state->dst_rect.width;
 		y_pos = (y_pos - y_plane) * pipe_ctx->plane_state->src_rect.height /
 				pipe_ctx->plane_state->dst_rect.height;
+		clip_x = (clip_x - x_plane) * pipe_ctx->plane_state->src_rect.width /
+				pipe_ctx->plane_state->dst_rect.width;
+		clip_width = clip_width * pipe_ctx->plane_state->src_rect.width /
+				pipe_ctx->plane_state->dst_rect.width;
 	}
 
 	/**
@@ -3744,30 +3750,18 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 
 
 	if (param.rotation == ROTATION_ANGLE_0) {
-		int viewport_width =
-			pipe_ctx->plane_res.scl_data.viewport.width;
-		int viewport_x =
-			pipe_ctx->plane_res.scl_data.viewport.x;
 
 		if (param.mirror) {
-			if (pipe_split_on || odm_combine_on) {
-				if (pos_cpy.x >= viewport_width + viewport_x) {
-					pos_cpy.x = 2 * viewport_width
-							- pos_cpy.x + 2 * viewport_x;
-				} else {
-					uint32_t temp_x = pos_cpy.x;
-
-					pos_cpy.x = 2 * viewport_x - pos_cpy.x;
-					if (temp_x >= viewport_x +
-						(int)hubp->curs_attr.width || pos_cpy.x
-						<= (int)hubp->curs_attr.width +
-						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = 2 * viewport_width - temp_x;
-					}
-				}
-			} else {
-				pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
-			}
+			/*
+			 * The plane is split into multiple viewports.
+			 * The combination of all viewports span the
+			 * entirety of the clip rect.
+			 *
+			 * For no pipe_split, viewport_width is represents
+			 * the full width of the clip_rect, so we can just
+			 * mirror it.
+			 */
+			pos_cpy.x = clip_width - pos_cpy.x + 2 * clip_x;
 		}
 	}
 	// Swap axis and mirror horizontally
@@ -3837,30 +3831,17 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	}
 	// Mirror horizontally and vertically
 	else if (param.rotation == ROTATION_ANGLE_180) {
-		int viewport_width =
-			pipe_ctx->plane_res.scl_data.viewport.width;
-		int viewport_x =
-			pipe_ctx->plane_res.scl_data.viewport.x;
-
 		if (!param.mirror) {
-			if (pipe_split_on || odm_combine_on) {
-				if (pos_cpy.x >= viewport_width + viewport_x) {
-					pos_cpy.x = 2 * viewport_width
-							- pos_cpy.x + 2 * viewport_x;
-				} else {
-					uint32_t temp_x = pos_cpy.x;
-
-					pos_cpy.x = 2 * viewport_x - pos_cpy.x;
-					if (temp_x >= viewport_x +
-						(int)hubp->curs_attr.width || pos_cpy.x
-						<= (int)hubp->curs_attr.width +
-						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = temp_x + viewport_width;
-					}
-				}
-			} else {
-				pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
-			}
+			/*
+			 * The plane is split into multiple viewports.
+			 * The combination of all viewports span the
+			 * entirety of the clip rect.
+			 *
+			 * For no pipe_split, viewport_width is represents
+			 * the full width of the clip_rect, so we can just
+			 * mirror it.
+			 */
+			pos_cpy.x = clip_width - pos_cpy.x + 2 * clip_x;
 		}
 
 		/**
-- 
2.50.1


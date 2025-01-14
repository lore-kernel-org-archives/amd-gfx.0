Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32574C02184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90EC10E849;
	Tue, 14 Jan 2025 02:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jy5vQd11";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8384B10E848
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+NeCY1/6kOZXLzkRNgcqYxYvfQHR0jSl6H0tVlrHegC/PBfHXR/Gu/Vpvs4uIo+wxU4FKZkc7FGc7qx57V0Lr58UGrgHEA6UuK3MjfHIh6ImFdk89mxOnPPveQXUbYoq+HO8+3y3Br6XANnVZuvr67gL5pAhAKj3VmNRiiHNChuDckjAkbeHXqJZ1uL/fxz90qTSPyRKDLcUlp0MefxlBqQ5MwRtpjn/V+3WKyM+xMjE/NsH2dTXTmSHJyqy4NrQT6lLvk89MI2kjSyngU/VMNIaxgK1G/6jjXM/hDxhXU7g8g63F1KqADjPNTd8Cupgm4AupnqZlZdDDbSQXa+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct922yIEeS00f/NrXTlvYupjZTZs3bRsWp9kGMx6/Cw=;
 b=pjK465hmg0OyXp9zxWddf/JoIvP6FDHzApJyy4M7ws0FS0mmWWnZ9ydeLR9TxAbiRiZVy18nrqZDol3j18l+I/pGUYJrJfnugaIEOxvIJ+qBIETBDDzgCpaiPag2ghccyo+OGDu1Voi1gwt1qST3otXQa3fT2rbjyNkUPTN9yaISDHjw+UfhoPdjyK4BrFp5NVgEeSt8dV4RvMyYCpMERb712u55lcB3ygVUr+FDL6vAfNqSfgQ55PUutCo7uaQRfBHC7S5oySrwpX+k9QjePLzDTeLZtQwCX7LI5EQOzFqskmIhiMfses85R7dNE3lmS9pzdP8U/0Lkd/4c2IWhig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct922yIEeS00f/NrXTlvYupjZTZs3bRsWp9kGMx6/Cw=;
 b=Jy5vQd11Jl8XnvBttOOc4EthwbvHW6oCzRWBY/3i3Tob7w7rmya/+eGgfaljJWLkg+89b8Me36cC7CocfWI/hEqgUKUMiIjyvPAVNSDhYTev5HsQyjFByRJnhzp5HUpNYBopldI1btNub5doScp30OpLXlODWyHD8fzysLcYLa0=
Received: from BLAPR03CA0150.namprd03.prod.outlook.com (2603:10b6:208:32e::35)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:11:16 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::55) by BLAPR03CA0150.outlook.office365.com
 (2603:10b6:208:32e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:11:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:11:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:11:09 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:11:04 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Peterson Guo
 <peterson.guo@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 10/11] drm/amd/display: Reverse the visual confirm recouts
Date: Tue, 14 Jan 2025 10:08:59 +0800
Message-ID: <20250114020900.3804152-11-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: a7666e41-e934-407a-c352-08dd3440ba5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z0wk/0YTwE25//DVz3kdswhqAAE1jL8FOMgVQewMICNwToRoovb9ToZVQglm?=
 =?us-ascii?Q?4V7GMXWqiZ58hqAeab0rvn/LlHZCaomo3TLCQV7PlmNWvXg/Ah+F4d3GJEJy?=
 =?us-ascii?Q?mxpN2MsnENlmWP+R/9ydc+FTj3ssQywrRoTWUU6uxAkumkEZkfooVUIVkb2o?=
 =?us-ascii?Q?ncMTBDKJNhylvP4Pl9kPlnsV9DBKNwSLXrdnBC+dzMvc/fDhQI0Dilwjz6H0?=
 =?us-ascii?Q?wmoPM0hZVgc4lNMVu4VtCPo5Na3227qqYladqYL5mYEiH7aBQR4Y/CmcBaD4?=
 =?us-ascii?Q?eJBfy/Fx6/0w1sURUKdZnpDgEoIwy6/YJWTQo1EeZjYFBVLemdu0L+ceDSUS?=
 =?us-ascii?Q?hjn8vT0WjpSC7TwdkoizTuCo0sUUMp85D1n2wqt+shzVGtp59TKkNxjhdSmS?=
 =?us-ascii?Q?HYGV6FEHIYFlhZhWY/nJZFtvYJlUbA+jrO630vOV4H3ZVDSqno871YjEoSTL?=
 =?us-ascii?Q?5lHYS5zEjDvllXejelwhXDsNtjRygMHy0934S7vZBWwTCdiMHjhvGskxquE+?=
 =?us-ascii?Q?c7WRfkAUmnvjWAKVTT26fEmrHUIG28NdB5mru0s6ZOuN5Td1jR2SPbIAWRw+?=
 =?us-ascii?Q?pQHzJ97YKqJ4zNlzj5v9dkOJg9xoOpIokmg935gvBgbkruHjJ0qDMFtBUSmw?=
 =?us-ascii?Q?Q1QgREBuoIxW3ikqsmo6GjJPbOhWwP70L3tY0VmRnwMsLKZ1SMyQr6Rh+YtR?=
 =?us-ascii?Q?Lcg5cTTtVdJsSElojgBI9E+6z3yZIfHinQQyC+uafuEpo5JTI+FVr7tjj5Ht?=
 =?us-ascii?Q?EOxeODjexLERREZZLyKPVDFUDzqmIZdCFWLs3XXKUPC99Vwzo3ww83rR7tld?=
 =?us-ascii?Q?OSW6E94GgCZtb7c0fgtePyTBu48aroF4pb9tIyVpAahhZe8WpYh/VvjAwcBj?=
 =?us-ascii?Q?aQ9poY01suOim4h5Tu1DXCWb1kmgBKizXQFYImUK67H1iiXAHQdzGz4NHzBd?=
 =?us-ascii?Q?EtCp96Us7MJGaEKlyrK4aSOrgo449rNEl5jzklRwT+1nR78WAThFZizFbbFo?=
 =?us-ascii?Q?zMLG6tD198mW/7c98n2Pwctb5bOFzvPNLv5CqQ/e0gUyaUigEy9MKW9JacTm?=
 =?us-ascii?Q?6D3NfrtDM3en2wdTUspO3rpi6TRh8d4lvkbxEmGD7TCKKlJigpNJmRQ90qQn?=
 =?us-ascii?Q?Xh2UgmdTvLIGQ+x+CqAfsMXK5oV/x00Gf8aAztK6JWjdz8ofRek0TQ/tZGAt?=
 =?us-ascii?Q?T2NLMHnGbsyrg7vAr4Uw+COZ/HMHYAKnnZlTNETZP98olSZ8gf8w/GsV6uH0?=
 =?us-ascii?Q?bMQHQ33MtkQ8i71PDRh729S4ZjTFGqd9ClGMwXRrosqV8VIFCmi00CzhkiZJ?=
 =?us-ascii?Q?mtmzJFA0hl0/zaz5klgbTN/9W97VAf9b9z6vRY43lxh9wxw76Mf+HcdGGSVS?=
 =?us-ascii?Q?fCJpWHPtva70IDKer73DzAvoZ0Cb+5Mf1BF1NLYIAj1NgJL0EyALXnv6iHZg?=
 =?us-ascii?Q?tYgfYEKClMbvlom1eBfiGQwyBv1izJMmYH9njqcj95CsNhaztP4aOjD7ZNkn?=
 =?us-ascii?Q?BBlC0l5aZN6HC2M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:11:16.5242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7666e41-e934-407a-c352-08dd3440ba5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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

From: Peterson Guo <peterson.guo@amd.com>

[WHY]
When checking if a pipe can disable cursor to prevent duplicate cursors,
having visual confirm on will prevent disabling cursors on planes which
cover the bottom of the screen.

[HOW]
When checking if a plane can disable visual confirm, the pipe first
reverses these calculations before doing the checks.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Peterson Guo <peterson.guo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 67 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 50 +-------------
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 48 +------------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 48 +------------
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 +
 5 files changed, 73 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 520a34a42827..72c88fdeb28c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -941,6 +941,17 @@ static void calculate_adjust_recout_for_visual_confirm(struct pipe_ctx *pipe_ctx
 		*base_offset = VISUAL_CONFIRM_BASE_DEFAULT;
 }
 
+static void reverse_adjust_recout_for_visual_confirm(struct rect *recout,
+		struct pipe_ctx *pipe_ctx)
+{
+	int dpp_offset, base_offset;
+
+	calculate_adjust_recout_for_visual_confirm(pipe_ctx, &base_offset,
+		&dpp_offset);
+	recout->height += base_offset;
+	recout->height += dpp_offset;
+}
+
 static void adjust_recout_for_visual_confirm(struct rect *recout,
 		struct pipe_ctx *pipe_ctx)
 {
@@ -1641,6 +1652,62 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	return res;
 }
 
+bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *test_pipe, *split_pipe;
+	struct rect r1 = pipe_ctx->plane_res.scl_data.recout;
+	int r1_right, r1_bottom;
+	int cur_layer = pipe_ctx->plane_state->layer_index;
+
+	reverse_adjust_recout_for_visual_confirm(&r1, pipe_ctx);
+	r1_right = r1.x + r1.width;
+	r1_bottom = r1.y + r1.height;
+
+	/**
+	 * Disable the cursor if there's another pipe above this with a
+	 * plane that contains this pipe's viewport to prevent double cursor
+	 * and incorrect scaling artifacts.
+	 */
+	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
+	     test_pipe = test_pipe->top_pipe) {
+		struct rect r2;
+		int r2_right, r2_bottom;
+		// Skip invisible layer and pipe-split plane on same layer
+		if (!test_pipe->plane_state ||
+		    !test_pipe->plane_state->visible ||
+		    test_pipe->plane_state->layer_index == cur_layer)
+			continue;
+
+		r2 = test_pipe->plane_res.scl_data.recout;
+		reverse_adjust_recout_for_visual_confirm(&r2, test_pipe);
+		r2_right = r2.x + r2.width;
+		r2_bottom = r2.y + r2.height;
+
+		/**
+		 * There is another half plane on same layer because of
+		 * pipe-split, merge together per same height.
+		 */
+		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
+		     split_pipe = split_pipe->top_pipe)
+			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
+				struct rect r2_half;
+
+				r2_half = split_pipe->plane_res.scl_data.recout;
+				reverse_adjust_recout_for_visual_confirm(&r2_half, split_pipe);
+				r2.x = min(r2_half.x, r2.x);
+				r2.width = r2.width + r2_half.width;
+				r2_right = r2.x + r2.width;
+				r2_bottom = min(r2_bottom, r2_half.y + r2_half.height);
+				break;
+			}
+
+		if (r1.x >= r2.x && r1.y >= r2.y && r1_right <= r2_right && r1_bottom <= r2_bottom)
+			return true;
+	}
+
+	return false;
+}
+
 
 enum dc_status resource_build_scaling_params_for_context(
 	const struct dc  *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 44ff9abe2880..87b4c2793df3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -991,57 +991,11 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 	DC_LOG_DEBUG("    is_cw6_en          : %d", diag_data.is_cw6_enabled);
 }
 
-static bool dc_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
-{
-	struct pipe_ctx *test_pipe, *split_pipe;
-	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
-	struct rect r1 = scl_data->recout, r2, r2_half;
-	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
-	int cur_layer = pipe_ctx->plane_state->layer_index;
-
-	/**
-	 * Disable the cursor if there's another pipe above this with a
-	 * plane that contains this pipe's viewport to prevent double cursor
-	 * and incorrect scaling artifacts.
-	 */
-	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
-	     test_pipe = test_pipe->top_pipe) {
-		// Skip invisible layer and pipe-split plane on same layer
-		if (!test_pipe->plane_state->visible || test_pipe->plane_state->layer_index == cur_layer)
-			continue;
-
-		r2 = test_pipe->plane_res.scl_data.recout;
-		r2_r = r2.x + r2.width;
-		r2_b = r2.y + r2.height;
-
-		/**
-		 * There is another half plane on same layer because of
-		 * pipe-split, merge together per same height.
-		 */
-		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
-		     split_pipe = split_pipe->top_pipe)
-			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
-				r2_half = split_pipe->plane_res.scl_data.recout;
-				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
-				r2.width = r2.width + r2_half.width;
-				r2_r = r2.x + r2.width;
-				break;
-			}
-
-		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
-			return true;
-	}
-
-	return false;
-}
-
 static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state != NULL) {
-		if (pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
-			return false;
-
-		if (dc_can_pipe_disable_cursor(pipe_ctx))
+		if (pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE ||
+			resource_can_pipe_disable_cursor(pipe_ctx))
 			return false;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index c3cf2706b6ba..906934128912 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3432,52 +3432,6 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 	hubbub->funcs->update_dchub(hubbub, dh_data);
 }
 
-static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
-{
-	struct pipe_ctx *test_pipe, *split_pipe;
-	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
-	struct rect r1 = scl_data->recout, r2, r2_half;
-	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
-	int cur_layer = pipe_ctx->plane_state->layer_index;
-
-	/**
-	 * Disable the cursor if there's another pipe above this with a
-	 * plane that contains this pipe's viewport to prevent double cursor
-	 * and incorrect scaling artifacts.
-	 */
-	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
-	     test_pipe = test_pipe->top_pipe) {
-		// Skip invisible layer and pipe-split plane on same layer
-		if (!test_pipe->plane_state ||
-		    !test_pipe->plane_state->visible ||
-		    test_pipe->plane_state->layer_index == cur_layer)
-			continue;
-
-		r2 = test_pipe->plane_res.scl_data.recout;
-		r2_r = r2.x + r2.width;
-		r2_b = r2.y + r2.height;
-
-		/**
-		 * There is another half plane on same layer because of
-		 * pipe-split, merge together per same height.
-		 */
-		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
-		     split_pipe = split_pipe->top_pipe)
-			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
-				r2_half = split_pipe->plane_res.scl_data.recout;
-				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
-				r2.width = r2.width + r2_half.width;
-				r2_r = r2.x + r2.width;
-				break;
-			}
-
-		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
-			return true;
-	}
-
-	return false;
-}
-
 void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
@@ -3577,7 +3531,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
 		pos_cpy.enable = false;
 
-	if (pos_cpy.enable && dcn10_can_pipe_disable_cursor(pipe_ctx))
+	if (pos_cpy.enable && resource_can_pipe_disable_cursor(pipe_ctx))
 		pos_cpy.enable = false;
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 555a9f590cd7..92bb820817b9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -972,52 +972,6 @@ void dcn401_setup_hpo_hw_control(const struct dce_hwseq *hws, bool enable)
 	REG_UPDATE(HPO_TOP_HW_CONTROL, HPO_IO_EN, enable);
 }
 
-static bool dcn401_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
-{
-	struct pipe_ctx *test_pipe, *split_pipe;
-	const struct scaler_data *scl_data = &pipe_ctx->plane_res.scl_data;
-	struct rect r1 = scl_data->recout, r2, r2_half;
-	int r1_r = r1.x + r1.width, r1_b = r1.y + r1.height, r2_r, r2_b;
-	int cur_layer = pipe_ctx->plane_state->layer_index;
-
-	/**
-	 * Disable the cursor if there's another pipe above this with a
-	 * plane that contains this pipe's viewport to prevent double cursor
-	 * and incorrect scaling artifacts.
-	 */
-	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
-		test_pipe = test_pipe->top_pipe) {
-		// Skip invisible layer and pipe-split plane on same layer
-		if (!test_pipe->plane_state ||
-			!test_pipe->plane_state->visible ||
-			test_pipe->plane_state->layer_index == cur_layer)
-			continue;
-
-		r2 = test_pipe->plane_res.scl_data.recout;
-		r2_r = r2.x + r2.width;
-		r2_b = r2.y + r2.height;
-
-		/**
-		 * There is another half plane on same layer because of
-		 * pipe-split, merge together per same height.
-		 */
-		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
-			split_pipe = split_pipe->top_pipe)
-			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
-				r2_half = split_pipe->plane_res.scl_data.recout;
-				r2.x = (r2_half.x < r2.x) ? r2_half.x : r2.x;
-				r2.width = r2.width + r2_half.width;
-				r2_r = r2.x + r2.width;
-				break;
-			}
-
-		if (r1.x >= r2.x && r1.y >= r2.y && r1_r <= r2_r && r1_b <= r2_b)
-			return true;
-	}
-
-	return false;
-}
-
 void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy)
 {
 	if (cursor_width <= 128) {
@@ -1208,7 +1162,7 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	pos_cpy.x = (uint32_t)x_pos;
 	pos_cpy.y = (uint32_t)y_pos;
 
-	if (pos_cpy.enable && dcn401_can_pipe_disable_cursor(pipe_ctx))
+	if (pos_cpy.enable && resource_can_pipe_disable_cursor(pipe_ctx))
 		pos_cpy.enable = false;
 
 	x_pos = pos_cpy.x - param.recout.x;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index cd1157d225ab..b32d07ce0f08 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -152,6 +152,8 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
+bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx);
+
 #define FREE_PIPE_INDEX_NOT_FOUND -1
 
 /*
-- 
2.37.3


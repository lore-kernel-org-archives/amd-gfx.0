Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655A2C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A2F10E4E2;
	Wed, 19 Jul 2023 18:34:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052EB10E4E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi/OI5l0bS/5D4CV+FKs/NMwJ5iTxuJGzeLqEWXcktnRViXOOdKFys1fvJ6EwRHvIG0OMhdvivSRh9T/vDfx8U/ufmdBBrH/RJ/hBFIm58t2UEgN4fImsglr8692sAfnbQE+LXqTYGbUPKnVEM5CQzMkWaN0v7RjVEwqx1lDp+o3SPTIbT6g856VDhXZyr5z2Se46VGqbUIj6zCWhlbTAteO1r4jmkVm8slxPLcrx726se3ZxZ7sJF8lcOZ1EvjssfFl3WLL/FePo0bm8UOt7uBYEOk9KUFjB5E+390LK8oTKAvDDnF40mftbkNM3gCq9nszICPBkcXQfjA9dLJJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmhxD2BL/+4ozMOaTEcPbMBOx8i+6KpviszjGVr3GD8=;
 b=AUw9YBPjDTMYPxusytHIznIQqxTLYPRQvph2CEa5ej5/zmtRLpy6cigU8q4J62vqamEsb6erWITsHsFzptAn4J5C6rhNKSXanpL8A2guusGmMAuVeShq30RZYZdKf6IuUF3bPBE/8wDI7FU3OwUNsOGobLf2eNUnoRpTD7+Kd4HCzk3kvDB4IwOxRG+ttHDOdVq7rkLbAIXDka9Er1zBbeo56NlonxFsmsZbR6oJdh2Y5OppomZphjz5+HptYQfHbDf9JXPsSYS+VK1OaXRPVMRk5c9cxJ+7OyHyJv6ITJQHt0WPiuhJWV3rGC21i68lW7ES6eFrZgLMPunVpxc+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmhxD2BL/+4ozMOaTEcPbMBOx8i+6KpviszjGVr3GD8=;
 b=vQupYOmzEJD9ESxdpkK4ys4ZX/+Yd+G/wpSzdhLF/ZjMZcgGMf0uSEIfrsH+9sP1FN8g+hQCb0CexWkVd7pO6rfBEzzJKBVktXsOB+XxuZqtwi7XP5CJ5IHZ/l6q+7ciSitl6tLh/Up8ujYLDnsnDND7qE53c2D9gpqP86uisjA=
Received: from BN9PR03CA0230.namprd03.prod.outlook.com (2603:10b6:408:f8::25)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:34:28 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::c7) by BN9PR03CA0230.outlook.office365.com
 (2603:10b6:408:f8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:34:28 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:34:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Refactor recout calculation with a
 more generic formula
Date: Wed, 19 Jul 2023 12:27:57 -0600
Message-ID: <20230719183211.153690-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5440e0e4-375a-4178-b148-08db8886c906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJQdiQK+aO18VIxkdE1kP6c9Yn+CI/3yF2qigojCvka8+36wy/DuOeOY25NQMcbiR2xeMyg+LxxlrroQ0dhh4JsaovBZP7WAr5dcyTcs3DYE9GtIG23urGX2wK6LVJCj406fInNPEvdg4PcABy8tzvpN57absNzuqsketERMBUYujCvY+gPQ/g5SOOGAdEyHxkD/zwZgnZtrVq7r66Gv6vfHhivJwY2/BNVw2dyvWdhCyrBBnr94v2NpjyeFY4zskwaVGZDhyq8bvRAXpRCtETOILmUdDMVoeHnprtA/lj5iX3IBw+7b1Ulc/qJQ+IgHmE4RQ9U+0yjfGYzdLbJcoIzoc+RfP0AfD2r/vBOtZK2n9lTQbIE1q3yCy9XxTv1yygBYJCWY2a7HQzsZf7rkVV/nMF0uD+cMpTBlbMEUrsS5KRhzGdPkdVN4y+e+SNHioomE12Dkdh2ehsJ8pHdJ92eY47/DYHBCjFo/x9Iw9sODQA6LBOX864mrUomHRtWMSaYky0Q5gRZUtWVALz4qW7miC3B0kNx6tIj9T1H6niU5w9nBQcY0KP+nIad+Wb79vLqLBuZygwn5F/5FlLqqZmrqxYxAjb5Uh31bBDcp7Kb+VKmmVP/Theov1KqkcCgdyANzmk0aQYVBYpjsp50hK5lp65RpNcijmTJbH5x5NZyIvRqGH27gi180biSNQY0wUxn6RfsIj5XVyw0vp/DW4obLm/mimgBPAhcEZeHZ5KiF4yRg28CmlosJNBenuU3hnGk0NQLSQIZD11Ls99Ult6BJ362NaSBzmdVJI2KIV0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(81166007)(36756003)(356005)(82740400003)(86362001)(40460700003)(30864003)(7696005)(6666004)(2906002)(478600001)(36860700001)(426003)(26005)(2616005)(186003)(336012)(47076005)(1076003)(16526019)(4326008)(6916009)(8936002)(41300700001)(54906003)(70206006)(70586007)(316002)(40480700001)(5660300002)(8676002)(83380400001)(44832011)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:34:28.2242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5440e0e4-375a-4178-b148-08db8886c906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex
 Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Current recout calculation has a few assumptions and implementation
for MPO + ODM combine calculation is very specific. The equation has
too many cases without enough comments to document the detail.

[How]
The change remove the following assumptions:
1. When MPO is enabled, we only allow ODM Combine 2:1
2. ODM Combine always has even segment width.
3. Secondary MPO plane's pipe_ctx copies pre_odm_pipe from
its top pipe.

The change applies a generic formula with more details in comment to
document this solution so it is eaiser to learn and debug later.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 560 +++++++++++++-----
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   4 +-
 4 files changed, 404 insertions(+), 168 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a680ae3e8577..d0f4b86cadf1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -69,9 +69,10 @@
 #include "../dcn32/dcn32_resource.h"
 #include "../dcn321/dcn321_resource.h"
 
-#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
-#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
-#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
+#define VISUAL_CONFIRM_BASE_DEFAULT 3
+#define VISUAL_CONFIRM_BASE_MIN 1
+#define VISUAL_CONFIRM_BASE_MAX 10
+#define VISUAL_CONFIRM_DPP_OFFSET 3
 
 #define DC_LOGGER_INIT(logger)
 
@@ -746,7 +747,12 @@ int get_num_mpc_splits(struct pipe_ctx *pipe)
 int get_num_odm_splits(struct pipe_ctx *pipe)
 {
 	int odm_split_count = 0;
-	struct pipe_ctx *next_pipe = pipe->next_odm_pipe;
+	struct pipe_ctx *next_pipe = NULL;
+
+	while (pipe->top_pipe)
+		pipe = pipe->top_pipe;
+
+	next_pipe = pipe->next_odm_pipe;
 	while (next_pipe) {
 		odm_split_count++;
 		next_pipe = next_pipe->next_odm_pipe;
@@ -759,32 +765,35 @@ int get_num_odm_splits(struct pipe_ctx *pipe)
 	return odm_split_count;
 }
 
-static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *split_count, int *split_idx)
+static int get_odm_split_index(struct pipe_ctx *pipe_ctx)
 {
-	*split_count = get_num_odm_splits(pipe_ctx);
-	*split_idx = 0;
-	if (*split_count == 0) {
-		/*Check for mpc split*/
-		struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
-
-		*split_count = get_num_mpc_splits(pipe_ctx);
-		while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
-			(*split_idx)++;
-			split_pipe = split_pipe->top_pipe;
-		}
+	struct pipe_ctx *split_pipe = NULL;
+	int index = 0;
 
-		/* MPO window on right side of ODM split */
-		if (split_pipe && split_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe)
-			(*split_idx)++;
-	} else {
-		/*Get odm split index*/
-		struct pipe_ctx *split_pipe = pipe_ctx->prev_odm_pipe;
+	while (pipe_ctx->top_pipe)
+		pipe_ctx = pipe_ctx->top_pipe;
 
-		while (split_pipe) {
-			(*split_idx)++;
-			split_pipe = split_pipe->prev_odm_pipe;
-		}
+	split_pipe = pipe_ctx->prev_odm_pipe;
+
+	while (split_pipe) {
+		index++;
+		split_pipe = split_pipe->prev_odm_pipe;
 	}
+
+	return index;
+}
+
+static int get_mpc_split_index(struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
+	int index = 0;
+
+	while (split_pipe && split_pipe->plane_state == pipe_ctx->plane_state) {
+		index++;
+		split_pipe = split_pipe->top_pipe;
+	}
+
+	return index;
 }
 
 /*
@@ -806,101 +815,357 @@ static void calculate_viewport_size(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static void calculate_recout(struct pipe_ctx *pipe_ctx)
+static struct rect intersect_rec(const struct rect *r0, const struct rect *r1)
 {
-	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-	const struct dc_stream_state *stream = pipe_ctx->stream;
-	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
-	struct rect surf_clip = plane_state->clip_rect;
-	bool split_tb = stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM;
-	int split_count, split_idx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
+	struct rect rec;
+	int r0_x_end = r0->x + r0->width;
+	int r1_x_end = r1->x + r1->width;
+	int r0_y_end = r0->y + r0->height;
+	int r1_y_end = r1->y + r1->height;
+
+	rec.x = r0->x > r1->x ? r0->x : r1->x;
+	rec.width = r0_x_end > r1_x_end ? r1_x_end - rec.x : r0_x_end - rec.x;
+	rec.y = r0->y > r1->y ? r0->y : r1->y;
+	rec.height = r0_y_end > r1_y_end ? r1_y_end - rec.y : r0_y_end - rec.y;
+
+	/* in case that there is no intersection */
+	if (rec.width < 0 || rec.height < 0)
+		memset(&rec, 0, sizeof(rec));
+
+	return rec;
+}
 
-	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
-	if (stream->view_format == VIEW_3D_FORMAT_SIDE_BY_SIDE)
-		split_idx = 0;
+static struct rect shift_rec(const struct rect *rec_in, int x, int y)
+{
+	struct rect rec_out = *rec_in;
+
+	rec_out.x += x;
+	rec_out.y += y;
+
+	return rec_out;
+}
 
+static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ctx)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	int odm_slice_count = get_num_odm_splits(pipe_ctx) + 1;
+	int odm_slice_idx = get_odm_split_index(pipe_ctx);
+	bool is_last_odm_slice = (odm_slice_idx + 1) == odm_slice_count;
+	int h_active = stream->timing.h_addressable +
+			stream->timing.h_border_left +
+			stream->timing.h_border_right;
+	int odm_slice_width = h_active / odm_slice_count;
+	struct rect odm_rec;
+
+	odm_rec.x = odm_slice_width * odm_slice_idx;
+	odm_rec.width = is_last_odm_slice ?
+			/* last slice width is the reminder of h_active */
+			h_active - odm_slice_width * (odm_slice_count - 1) :
+			/* odm slice width is the floor of h_active / count */
+			odm_slice_width;
+	odm_rec.y = 0;
+	odm_rec.height = stream->timing.v_addressable +
+			stream->timing.v_border_bottom +
+			stream->timing.v_border_top;
+
+	return odm_rec;
+}
+
+static struct rect calculate_plane_rec_in_timing_active(
+		struct pipe_ctx *pipe_ctx,
+		const struct rect *rec_in)
+{
 	/*
-	 * Only the leftmost ODM pipe should be offset by a nonzero distance
+	 * The following diagram shows an example where we map a 1920x1200
+	 * desktop to a 2560x1440 timing with a plane rect in the middle
+	 * of the screen. To map a plane rect from Stream Source to Timing
+	 * Active space, we first multiply stream scaling ratios (i.e 2304/1920
+	 * horizontal and 1440/1200 vertical) to the plane's x and y, then
+	 * we add stream destination offsets (i.e 128 horizontal, 0 vertical).
+	 * This will give us a plane rect's position in Timing Active. However
+	 * we have to remove the fractional. The rule is that we find left/right
+	 * and top/bottom positions and round the value to the adjacent integer.
+	 *
+	 * Stream Source Space
+	 * ------------
+	 *        __________________________________________________
+	 *       |Stream Source (1920 x 1200) ^                     |
+	 *       |                            y                     |
+	 *       |         <------- w --------|>                    |
+	 *       |          __________________V                     |
+	 *       |<-- x -->|Plane//////////////| ^                  |
+	 *       |         |(pre scale)////////| |                  |
+	 *       |         |///////////////////| |                  |
+	 *       |         |///////////////////| h                  |
+	 *       |         |///////////////////| |                  |
+	 *       |         |///////////////////| |                  |
+	 *       |         |///////////////////| V                  |
+	 *       |                                                  |
+	 *       |                                                  |
+	 *       |__________________________________________________|
+	 *
+	 *
+	 * Timing Active Space
+	 * ---------------------------------
+	 *
+	 *       Timing Active (2560 x 1440)
+	 *        __________________________________________________
+	 *       |*****|  Stteam Destination (2304 x 1440)    |*****|
+	 *       |*****|                                      |*****|
+	 *       |<128>|                                      |*****|
+	 *       |*****|     __________________               |*****|
+	 *       |*****|    |Plane/////////////|              |*****|
+	 *       |*****|    |(post scale)//////|              |*****|
+	 *       |*****|    |//////////////////|              |*****|
+	 *       |*****|    |//////////////////|              |*****|
+	 *       |*****|    |//////////////////|              |*****|
+	 *       |*****|    |//////////////////|              |*****|
+	 *       |*****|                                      |*****|
+	 *       |*****|                                      |*****|
+	 *       |*****|                                      |*****|
+	 *       |*****|______________________________________|*****|
+	 *
+	 * So the resulting formulas are shown below:
+	 *
+	 * recout_x = 128 + round(plane_x * 2304 / 1920)
+	 * recout_w = 128 + round((plane_x + plane_w) * 2304 / 1920) - recout_x
+	 * recout_y = 0 + round(plane_y * 1440 / 1280)
+	 * recout_h = 0 + round((plane_y + plane_h) * 1440 / 1200) - recout_y
+	 *
+	 * NOTE: fixed point division is not error free. To reduce errors
+	 * introduced by fixed point division, we divide only after
+	 * multiplication is complete.
 	 */
-	if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe) {
-		/* MPO window on right side of ODM split */
-		data->recout.x = stream->dst.x + (surf_clip.x - stream->src.x - stream->src.width/2) *
-				stream->dst.width / stream->src.width;
-	} else if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
-		data->recout.x = stream->dst.x;
-		if (stream->src.x < surf_clip.x)
-			data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
-						/ stream->src.width;
-	} else
-		data->recout.x = 0;
-
-	if (stream->src.x > surf_clip.x)
-		surf_clip.width -= stream->src.x - surf_clip.x;
-	data->recout.width = surf_clip.width * stream->dst.width / stream->src.width;
-	if (data->recout.width + data->recout.x > stream->dst.x + stream->dst.width)
-		data->recout.width = stream->dst.x + stream->dst.width - data->recout.x;
-
-	data->recout.y = stream->dst.y;
-	if (stream->src.y < surf_clip.y)
-		data->recout.y += (surf_clip.y - stream->src.y) * stream->dst.height
-						/ stream->src.height;
-	else if (stream->src.y > surf_clip.y)
-		surf_clip.height -= stream->src.y - surf_clip.y;
-
-	data->recout.height = surf_clip.height * stream->dst.height / stream->src.height;
-	if (data->recout.height + data->recout.y > stream->dst.y + stream->dst.height)
-		data->recout.height = stream->dst.y + stream->dst.height - data->recout.y;
-
-	/* Handle h & v split */
-	if (split_tb) {
-		ASSERT(data->recout.height % 2 == 0);
-		data->recout.height /= 2;
-	} else if (split_count) {
-		if (!pipe_ctx->next_odm_pipe && !pipe_ctx->prev_odm_pipe) {
-			/* extra pixels in the division remainder need to go to pipes after
-			 * the extra pixel index minus one(epimo) defined here as:
-			 */
-			int epimo = split_count - data->recout.width % (split_count + 1);
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	struct rect rec_out = {0};
+	struct fixed31_32 temp;
 
-			data->recout.x += (data->recout.width / (split_count + 1)) * split_idx;
-			if (split_idx > epimo)
-				data->recout.x += split_idx - epimo - 1;
-			ASSERT(stream->view_format != VIEW_3D_FORMAT_SIDE_BY_SIDE || data->recout.width % 2 == 0);
-			data->recout.width = data->recout.width / (split_count + 1) + (split_idx > epimo ? 1 : 0);
-		} else {
-			/* odm */
-			if (split_idx == split_count) {
-				/* rightmost pipe is the remainder recout */
-				data->recout.width -= data->h_active * split_count - data->recout.x;
-
-				/* ODM combine cases with MPO we can get negative widths */
-				if (data->recout.width < 0)
-					data->recout.width = 0;
-
-				data->recout.x = 0;
-			} else
-				data->recout.width = data->h_active - data->recout.x;
-		}
-	}
+	temp = dc_fixpt_from_fraction(rec_in->x * stream->dst.width,
+			stream->src.width);
+	rec_out.x = stream->dst.x + dc_fixpt_round(temp);
 
-	/* Check bounds to ensure the VC bar height was set to a sane value */
-	if (dpp != NULL) {
-		if ((dpp->ctx->dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_RECT_HEIGHT_MIN) &&
-			(dpp->ctx->dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_RECT_HEIGHT_MAX)) {
-			visual_confirm_rect_height = dpp->ctx->dc->debug.visual_confirm_rect_height;
-		}
+	temp = dc_fixpt_from_fraction(
+			(rec_in->x + rec_in->width) * stream->dst.width,
+			stream->src.width);
+	rec_out.width = stream->dst.x + dc_fixpt_round(temp) - rec_out.x;
+
+	temp = dc_fixpt_from_fraction(rec_in->y * stream->dst.height,
+			stream->src.height);
+	rec_out.y = stream->dst.y + dc_fixpt_round(temp);
+
+	temp = dc_fixpt_from_fraction(
+			(rec_in->y + rec_in->height) * stream->dst.height,
+			stream->src.height);
+	rec_out.height = stream->dst.y + dc_fixpt_round(temp) - rec_out.y;
 
-		if (dpp->ctx->dc->debug.visual_confirm !=
-		    VISUAL_CONFIRM_DISABLE)
-			data->recout.height = data->recout.height -
-				2 * ((pipe_ctx->prev_odm_pipe ||
-				      (pipe_ctx->top_pipe &&
-				      pipe_ctx->top_pipe->plane_state ==
-				      pipe_ctx->plane_state)) +
-				     visual_confirm_rect_height);
+	return rec_out;
+}
+
+static struct rect calculate_mpc_slice_in_timing_active(
+		struct pipe_ctx *pipe_ctx,
+		struct rect *plane_clip_rec)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	int mpc_slice_count = get_num_mpc_splits(pipe_ctx) + 1;
+	int mpc_slice_idx = get_mpc_split_index(pipe_ctx);
+	int epimo = mpc_slice_count - plane_clip_rec->width % mpc_slice_count - 1;
+	struct rect mpc_rec;
+
+	mpc_rec.width = plane_clip_rec->width / mpc_slice_count;
+	mpc_rec.x = plane_clip_rec->x + mpc_rec.width * mpc_slice_idx;
+	mpc_rec.height = plane_clip_rec->height;
+	mpc_rec.y = plane_clip_rec->y;
+	ASSERT(mpc_slice_count == 1 ||
+			stream->view_format != VIEW_3D_FORMAT_SIDE_BY_SIDE ||
+			mpc_rec.width % 2 == 0);
+
+	/* extra pixels in the division remainder need to go to pipes after
+	 * the extra pixel index minus one(epimo) defined here as:
+	 */
+	if (mpc_slice_idx > epimo) {
+		mpc_rec.x += mpc_slice_idx - epimo - 1;
+		mpc_rec.width += 1;
 	}
+
+	if (stream->view_format == VIEW_3D_FORMAT_TOP_AND_BOTTOM) {
+		ASSERT(mpc_rec.height % 2 == 0);
+		mpc_rec.height /= 2;
+	}
+	return mpc_rec;
+}
+
+static void adjust_recout_for_visual_confirm(struct rect *recout,
+		struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	int dpp_offset, base_offset;
+
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE)
+		return;
+
+	dpp_offset = pipe_ctx->plane_res.dpp->inst * VISUAL_CONFIRM_DPP_OFFSET;
+
+	if ((dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_BASE_MIN) &&
+			dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_BASE_MAX)
+		base_offset = dc->debug.visual_confirm_rect_height;
+	else
+		base_offset = VISUAL_CONFIRM_BASE_DEFAULT;
+
+	recout->height -= base_offset;
+	recout->height -= dpp_offset;
+}
+
+/*
+ * The function maps a plane clip from Stream Source Space to ODM Slice Space
+ * and calculates the rec of the overlapping area of MPC slice of the plane
+ * clip, ODM slice associated with the pipe context and stream destination rec.
+ */
+static void calculate_recout(struct pipe_ctx *pipe_ctx)
+{
+	/*
+	 * A plane clip represents the desired plane size and position in Stream
+	 * Source Space. Stream Source is the destination where all planes are
+	 * blended (i.e. positioned, scaled and overlaid). It is a canvas where
+	 * all planes associated with the current stream are drawn together.
+	 * After Stream Source is completed, we will further scale and
+	 * reposition the entire canvas of the stream source to Stream
+	 * Destination in Timing Active Space. This could be due to display
+	 * overscan adjustment where we will need to rescale and reposition all
+	 * the planes so they can fit into a TV with overscan or downscale
+	 * upscale features such as GPU scaling or VSR.
+	 *
+	 * This two step blending is a virtual procedure in software. In
+	 * hardware there is no such thing as Stream Source. all planes are
+	 * blended once in Timing Active Space. Software virtualizes a Stream
+	 * Source space to decouple the math complicity so scaling param
+	 * calculation focuses on one step at a time.
+	 *
+	 * In the following two diagrams, user applied 10% overscan adjustment
+	 * so the Stream Source needs to be scaled down a little before mapping
+	 * to Timing Active Space. As a result the Plane Clip is also scaled
+	 * down by the same ratio, Plane Clip position (i.e. x and y) with
+	 * respect to Stream Source is also scaled down. To map it in Timing
+	 * Active Space additional x and y offsets from Stream Destination are
+	 * added to Plane Clip as well.
+	 *
+	 * Stream Source Space
+	 * ------------
+	 *        __________________________________________________
+	 *       |Stream Source (3840 x 2160) ^                     |
+	 *       |                            y                     |
+	 *       |                            |                     |
+	 *       |          __________________V                     |
+	 *       |<-- x -->|Plane Clip/////////|                    |
+	 *       |         |(pre scale)////////|                    |
+	 *       |         |///////////////////|                    |
+	 *       |         |///////////////////|                    |
+	 *       |         |///////////////////|                    |
+	 *       |         |///////////////////|                    |
+	 *       |         |///////////////////|                    |
+	 *       |                                                  |
+	 *       |                                                  |
+	 *       |__________________________________________________|
+	 *
+	 *
+	 * Timing Active Space (3840 x 2160)
+	 * ---------------------------------
+	 *
+	 *       Timing Active
+	 *        __________________________________________________
+	 *       | y_____________________________________________   |
+	 *       |x |Stream Destination (3456 x 1944)            |  |
+	 *       |  |                                            |  |
+	 *       |  |        __________________                  |  |
+	 *       |  |       |Plane Clip////////|                 |  |
+	 *       |  |       |(post scale)//////|                 |  |
+	 *       |  |       |//////////////////|                 |  |
+	 *       |  |       |//////////////////|                 |  |
+	 *       |  |       |//////////////////|                 |  |
+	 *       |  |       |//////////////////|                 |  |
+	 *       |  |                                            |  |
+	 *       |  |                                            |  |
+	 *       |  |____________________________________________|  |
+	 *       |__________________________________________________|
+	 *
+	 *
+	 * In Timing Active Space a plane clip could be further sliced into
+	 * pieces called MPC slices. Each Pipe Context is responsible for
+	 * processing only one MPC slice so the plane processing workload can be
+	 * distributed to multiple DPP Pipes. MPC slices could be blended
+	 * together to a single ODM slice. Each ODM slice is responsible for
+	 * processing a portion of Timing Active divided horizontally so the
+	 * output pixel processing workload can be distributed to multiple OPP
+	 * pipes. All ODM slices are mapped together in ODM block so all MPC
+	 * slices belong to different ODM slices could be pieced together to
+	 * form a single image in Timing Active. MPC slices must belong to
+	 * single ODM slice. If an MPC slice goes across ODM slice boundary, it
+	 * needs to be divided into two MPC slices one for each ODM slice.
+	 *
+	 * In the following diagram the output pixel processing workload is
+	 * divided horizontally into two ODM slices one for each OPP blend tree.
+	 * OPP0 blend tree is responsible for processing left half of Timing
+	 * Active, while OPP2 blend tree is responsible for processing right
+	 * half.
+	 *
+	 * The plane has two MPC slices. However since the right MPC slice goes
+	 * across ODM boundary, two DPP pipes are needed one for each OPP blend
+	 * tree. (i.e. DPP1 for OPP0 blend tree and DPP2 for OPP2 blend tree).
+	 *
+	 * Assuming that we have a Pipe Context associated with OPP0 and DPP1
+	 * working on processing the plane in the diagram. We want to know the
+	 * width and height of the shaded rectangle and its relative position
+	 * with respect to the ODM slice0. This is called the recout of the pipe
+	 * context.
+	 *
+	 * Planes can be at arbitrary size and position and there could be an
+	 * arbitrary number of MPC and ODM slices. The algorithm needs to take
+	 * all scenarios into account.
+	 *
+	 * Timing Active Space (3840 x 2160)
+	 * ---------------------------------
+	 *
+	 *       Timing Active
+	 *        __________________________________________________
+	 *       |OPP0(ODM slice0)^        |OPP2(ODM slice1)        |
+	 *       |                y        |                        |
+	 *       |                |  <- w ->                        |
+	 *       |           _____V________|____                    |
+	 *       |          |DPP0 ^  |DPP1 |DPP2|                   |
+	 *       |<------ x |-----|->|/////|    |                   |
+	 *       |          |     |  |/////|    |                   |
+	 *       |          |     h  |/////|    |                   |
+	 *       |          |     |  |/////|    |                   |
+	 *       |          |_____V__|/////|____|                   |
+	 *       |                         |                        |
+	 *       |                         |                        |
+	 *       |                         |                        |
+	 *       |_________________________|________________________|
+	 *
+	 *
+	 */
+	struct rect plane_clip;
+	struct rect mpc_slice_of_plane_clip;
+	struct rect odm_slice;
+	struct rect overlapping_area;
+
+	plane_clip = calculate_plane_rec_in_timing_active(pipe_ctx,
+			&pipe_ctx->plane_state->clip_rect);
+	/* guard plane clip from drawing beyond stream dst here */
+	plane_clip = intersect_rec(&plane_clip,
+				&pipe_ctx->stream->dst);
+	mpc_slice_of_plane_clip = calculate_mpc_slice_in_timing_active(
+			pipe_ctx, &plane_clip);
+	odm_slice = calculate_odm_slice_in_timing_active(pipe_ctx);
+	overlapping_area = intersect_rec(&mpc_slice_of_plane_clip, &odm_slice);
+	/* shift the overlapping area so it is with respect to current ODM
+	 * slice's position
+	 */
+	pipe_ctx->plane_res.scl_data.recout = shift_rec(
+			&overlapping_area,
+			-odm_slice.x, -odm_slice.y);
+
+	adjust_recout_for_visual_confirm(&pipe_ctx->plane_res.scl_data.recout,
+			pipe_ctx);
 }
 
 static void calculate_scaling_ratios(struct pipe_ctx *pipe_ctx)
@@ -1022,34 +1287,25 @@ static void calculate_init_and_vp(
 static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-	const struct dc_stream_state *stream = pipe_ctx->stream;
 	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
 	struct rect src = plane_state->src_rect;
+	struct rect recout_dst_in_active_timing;
+	struct rect recout_clip_in_active_timing;
+	struct rect recout_clip_in_recout_dst;
+	struct rect odm_slice = calculate_odm_slice_in_timing_active(pipe_ctx);
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
 				|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
-	int split_count, split_idx, ro_lb, ro_tb, recout_full_x, recout_full_y;
 	bool orthogonal_rotation, flip_vert_scan_dir, flip_horz_scan_dir;
 
-	calculate_split_count_and_index(pipe_ctx, &split_count, &split_idx);
-	/*
-	 * recout full is what the recout would have been if we didnt clip
-	 * the source plane at all. We only care about left(ro_lb) and top(ro_tb)
-	 * offsets of recout within recout full because those are the directions
-	 * we scan from and therefore the only ones that affect inits.
-	 */
-	recout_full_x = stream->dst.x + (plane_state->dst_rect.x - stream->src.x)
-			* stream->dst.width / stream->src.width;
-	recout_full_y = stream->dst.y + (plane_state->dst_rect.y - stream->src.y)
-			* stream->dst.height / stream->src.height;
-	if (pipe_ctx->prev_odm_pipe && split_idx)
-		ro_lb = data->h_active * split_idx - recout_full_x;
-	else if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe)
-		ro_lb = data->h_active * split_idx - recout_full_x + data->recout.x;
-	else
-		ro_lb = data->recout.x - recout_full_x;
-	ro_tb = data->recout.y - recout_full_y;
-	ASSERT(ro_lb >= 0 && ro_tb >= 0);
-
+	recout_clip_in_active_timing = shift_rec(
+			&data->recout, odm_slice.x, odm_slice.y);
+	recout_dst_in_active_timing = calculate_plane_rec_in_timing_active(
+			pipe_ctx, &plane_state->dst_rect);
+	recout_clip_in_recout_dst = shift_rec(&recout_clip_in_active_timing,
+			-recout_dst_in_active_timing.x,
+			-recout_dst_in_active_timing.y);
+	ASSERT(recout_clip_in_recout_dst.x >= 0 &&
+			recout_clip_in_recout_dst.y >= 0);
 	/*
 	 * Work in recout rotation since that requires less transformations
 	 */
@@ -1067,7 +1323,7 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 
 	calculate_init_and_vp(
 			flip_horz_scan_dir,
-			ro_lb,
+			recout_clip_in_recout_dst.x,
 			data->recout.width,
 			src.width,
 			data->taps.h_taps,
@@ -1077,7 +1333,7 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			&data->viewport.width);
 	calculate_init_and_vp(
 			flip_horz_scan_dir,
-			ro_lb,
+			recout_clip_in_recout_dst.x,
 			data->recout.width,
 			src.width / vpc_div,
 			data->taps.h_taps_c,
@@ -1087,7 +1343,7 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			&data->viewport_c.width);
 	calculate_init_and_vp(
 			flip_vert_scan_dir,
-			ro_tb,
+			recout_clip_in_recout_dst.y,
 			data->recout.height,
 			src.height,
 			data->taps.v_taps,
@@ -1097,7 +1353,7 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			&data->viewport.height);
 	calculate_init_and_vp(
 			flip_vert_scan_dir,
-			ro_tb,
+			recout_clip_in_recout_dst.y,
 			data->recout.height,
 			src.height / vpc_div,
 			data->taps.v_taps_c,
@@ -1122,6 +1378,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
+	const struct rect odm_slice_rec = calculate_odm_slice_in_timing_active(pipe_ctx);
 	bool res = false;
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
@@ -1146,30 +1403,9 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dst.y += timing->v_border_top;
 
 	/* Calculate H and V active size */
-	pipe_ctx->plane_res.scl_data.h_active = timing->h_addressable +
-			timing->h_border_left + timing->h_border_right;
-	pipe_ctx->plane_res.scl_data.v_active = timing->v_addressable +
-		timing->v_border_top + timing->v_border_bottom;
-	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe) {
-		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx) + 1;
-
-		DC_LOG_SCALER("%s pipe %d: next_odm_pipe:%d   prev_odm_pipe:%d\n",
-				__func__,
-				pipe_ctx->pipe_idx,
-				pipe_ctx->next_odm_pipe ? pipe_ctx->next_odm_pipe->pipe_idx : -1,
-				pipe_ctx->prev_odm_pipe ? pipe_ctx->prev_odm_pipe->pipe_idx : -1);
-	}	/* ODM + windows MPO, where window is on either right or left ODM half */
-	else if (pipe_ctx->top_pipe && (pipe_ctx->top_pipe->next_odm_pipe || pipe_ctx->top_pipe->prev_odm_pipe)) {
-
-		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx->top_pipe) + 1;
-
-		DC_LOG_SCALER("%s ODM + windows MPO: pipe:%d top_pipe:%d   top_pipe->next_odm_pipe:%d   top_pipe->prev_odm_pipe:%d\n",
-				__func__,
-				pipe_ctx->pipe_idx,
-				pipe_ctx->top_pipe->pipe_idx,
-				pipe_ctx->top_pipe->next_odm_pipe ? pipe_ctx->top_pipe->next_odm_pipe->pipe_idx : -1,
-				pipe_ctx->top_pipe->prev_odm_pipe ? pipe_ctx->top_pipe->prev_odm_pipe->pipe_idx : -1);
-	}
+	pipe_ctx->plane_res.scl_data.h_active = odm_slice_rec.width;
+	pipe_ctx->plane_res.scl_data.v_active = odm_slice_rec.height;
+
 	/* depends on h_active */
 	calculate_recout(pipe_ctx);
 	/* depends on pixel format */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index d693ea42d033..82dfcf773b1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -854,8 +854,8 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 		/* We only support full screen mpo with ODM */
 		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
 				&& pipe->plane_state && mpo_pipe
-				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
-						&pipe->plane_res.scl_data.recout,
+				&& memcmp(&mpo_pipe->plane_state->clip_rect,
+						&pipe->stream->src,
 						sizeof(struct rect)) != 0) {
 			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
 			goto validate_fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index abe4c12a10b5..f5bfcd2a0dbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1705,8 +1705,8 @@ noinline bool dcn30_internal_validate_bw(
 			/* We only support full screen mpo with ODM */
 			if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
 					&& pipe->plane_state && mpo_pipe
-					&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
-							&pipe->plane_res.scl_data.recout,
+					&& memcmp(&mpo_pipe->plane_state->clip_rect,
+							&pipe->stream->src,
 							sizeof(struct rect)) != 0) {
 				ASSERT(mpo_pipe->plane_state != pipe->plane_state);
 				goto validate_fail;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0e2f25985378..0f882b879b0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1717,8 +1717,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
 				&& !dc->config.enable_windowed_mpo_odm
 				&& pipe->plane_state && mpo_pipe
-				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
-						&pipe->plane_res.scl_data.recout,
+				&& memcmp(&mpo_pipe->plane_state->clip_rect,
+						&pipe->stream->src,
 						sizeof(struct rect)) != 0) {
 			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
 			goto validate_fail;
-- 
2.41.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD7FCF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9040F10E758;
	Thu, 19 Sep 2024 18:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OazgNd9d";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559C310E758
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDjIzVFOcyf173+YAb7BppPPipZFzk/ieoxCNEM1CmsOOtbbjTKc5UrrNYdFcZYo95T8GuM80Y3YI0/DA1GejmNXLzoTkzZ5bO+vYKm8t3RXcHNaPC4Ytepd8Wj3WtB6RpxzlVClu3jUzmWIkNgzjwJNvKorj62RC33kIQ1xW8ISIW2NdfedCc80dsdEbcsPrkX3rtUApHqsix0yYVnmkmssI+155JdHRtLgUuu0r1WozAOmxy/qGeuoHCbxFNHh/B6+pdTcUiQQs5Zn585AK5sVhkqI+0durJyew0+koqLzTnPT/oAHW1V/6Ypwdy1RkIjfhdec1eyRiDcTEWm9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6SQNR4XkDtiV3b+K1Ww64Ny1UaIUWCM5y+Z1mfQiwQ=;
 b=RoUW6ZObRudHyxoQtkR8bEtVKEZFDg9/N5Ra3gtUyw7ZUfFRsVH5LMII4QdGXBt359jGDwVRAeeywwvsY9v0g4rn1T26lrykaFUmfqc3ZwK3vmZuaxhbu6+JrI91wCtu0oiAWOT+9pEesiPR2dNdp9axRJhKjUyl9yLK86g95+wRZbk7RR+vF+AdB4C7vFnO4c+6zWYmW/bn5KrNkBVrurEDCh/VcvZ27oq5zvWR3oXZUkTNwjmfNkhZgofMPMASWJCsvgQuFwKKmbJtCPNfVbkAEfucaBsIIi0RR5eqfkSGtKIR7i5JTAKLrGbgW15LGyON3/R9GFynZUR3DiaV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6SQNR4XkDtiV3b+K1Ww64Ny1UaIUWCM5y+Z1mfQiwQ=;
 b=OazgNd9dQ6wBWhO/eiNyk43viookAYoQ0xtJKYNnQq1ITi7w0qh+fK7m3Hx1uSFTqNfOMPGwj7kZhpu/rf0cVRMzKTRQigk2yRZAJLshtCRZPut3TUTJ4E9rK4QRFQA0HAUdf4Cy371pNCuoUaw/ykN2c7EyHsLCX5oD0O9ARDk=
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:35:08 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::4) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:35:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:35:03 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:35:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 17/21] drm/amd/display: Clip rect size changes should be full
 updates
Date: Thu, 19 Sep 2024 14:33:35 -0400
Message-ID: <20240919183435.1896209-18-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 3702a74f-dc64-4adf-f3a9-08dcd8d9c94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FGJyMczI/Ph6ibk7F2RhwWYeZYU+IUKaxsvGP22x61KZmaeHKgDt3uOS/kDB?=
 =?us-ascii?Q?EAkGOaOVJiJmEtEU2NBLln1MXs8LbRp2KUuCE3zBqmPqWVEEvHb/YdOFgJw+?=
 =?us-ascii?Q?b1ridYoK9j3l1TmriyMAXDalK+z2dBEieNHjge5hazOjx6/wPl7CLqxLfzfm?=
 =?us-ascii?Q?XI+WmiJiKzMTKlaJjFjrqA3hYrtZ5voY08sC/qxJa+AFRO4g6YDe404TSmfE?=
 =?us-ascii?Q?sCAjtG/nHveMEbdw/jBjMNXlzg1VfC6VvNkKvl88VK3yTR1uQmFU1WmUFvvG?=
 =?us-ascii?Q?u1MX1xaaiKskvlkQWvaoLAZsp82Z1qEPmPEs7WBZEN5RRfJb+1BaxukgGPgp?=
 =?us-ascii?Q?OoBCy21jVSW8XcT0tFRPya5VXhjDu5o5Q8yxWCybxxhGEQAemB0HWVNibVRo?=
 =?us-ascii?Q?zBr/fM3w17zee1hXjk5uoC23oqwurYvyInlndasgiN6Z5zEwPdmgqMiAJ8w/?=
 =?us-ascii?Q?fsObmJNm39clBQ8wmYEo9yag/sLKUCyem51HCSHssuHn3Ji7Wm0Z0q4N/5Ov?=
 =?us-ascii?Q?YjpSIGfZhxfLkfTqyNUAd2/8aRq7XfOBDtkPnIgqWDYWRFqDb00eS7B/sbTm?=
 =?us-ascii?Q?j2YJeiw6lIaONb3sC3h8DEcjNOfYOLPA7EeQgJ+tuhkN6ZmEt3hEmEq5wjo7?=
 =?us-ascii?Q?MpmoyonIbuSyh/KDkGlBXOhlgD8LoS8h1bsIy1EZoHFcY9p3fPCxk+/kuxg0?=
 =?us-ascii?Q?cJ36sznzma4kEDJHMplClbZkMODSETj4SJQzRdrUH0VPD79YmEkI9B2t6/bB?=
 =?us-ascii?Q?D1xZe6Kr6pdXPtxoocXukik2TDlNK44k1czYycR9o7pr8/0TJCV+zPZUdesT?=
 =?us-ascii?Q?dIOxrzFet/jNQTODME13wtk5b5rY37iTX1j/1O/86Wx4ECiISlS275Z3drKd?=
 =?us-ascii?Q?IWr/JU2fSktsGwyoNE/+C2+0nlGXHOC5G6SnpLr4Fd7/Vm/fjkeZvbyV+6EQ?=
 =?us-ascii?Q?k8Eeq6Gvfz03zlb3QukTCjlSW4E2IQqW+Su1JI3V0RkUk0up2AbpaZ/TQ3aW?=
 =?us-ascii?Q?hzi+5fpKov0S2KcrMxMbA2HHqPNd1GIm0lkM6JZJ8Se4uQG036nnPLYswMyD?=
 =?us-ascii?Q?w8Wsn52AMzqBDCumOzWC38n0AmtTNDaTCgFBLcfsvxeyEXRHwn2N0DTdnfkC?=
 =?us-ascii?Q?hdJM//0lN7Wp/l5gq7qkta5HafZ99q/7Jv/WFGvgwa3z25Uu8utwNDHEeNe8?=
 =?us-ascii?Q?WFqSnUC2WJw+bzkZRsuPQ0O5GgExEGmqr8ZLNCxIF9mcDRdRAoiZ8luwrpLj?=
 =?us-ascii?Q?ckiUc4R6+9xZ7cZ3ix+CtFMXsibqNhlVOA/hkhVMQfaKgi+X/hhuFMbLObi+?=
 =?us-ascii?Q?IAj29HQGHyCR/4wmvurLr+NxMvPyg0t/pXu2sswsiD42JHMB+EF87HIz7E8n?=
 =?us-ascii?Q?esQ1VypQTEcE+cuQsVdGjfghJ9ECwc8OjwGTmc4FhdXhE+fgl5/VSw1YS8rx?=
 =?us-ascii?Q?OpTFsJXYDtWNumrm0xymHmO1WSPqZBTU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:35:07.6105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3702a74f-dc64-4adf-f3a9-08dcd8d9c94f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
In cases where an MPO plane is being dragged around partially off-screen,
it is possible to get a flip where the only scaling parameters to change
are the clip rect size and position. Currently, clip rect size changes
are considered medium updates, which can result in the clip rect being used
for HW programming being larger than the clip rect that was used for the
last DML validation. This can lead to mismatches in different parts of the
pipe and can result in a p-state hang.

[How]
 - consider clip rect size changes scaling changes, therefore full updates
 - refactor get_scaling_info_update_type for clarity
 - remove clip_size_change update flag

Clip rect size changes were previously demoted from full updates as an
optimization when the MPO + ODM policy changed to always pre-allocate MPO
pipes, but it created the issue described above. Personally testing this
use case, the performance feels fine with full update spam, and we expect
this is a fairly infrequent use case. If the performance needs to be
optimized in the future, consider reworking the entire update type logic
to run a DML pass and determine the update type based on what DML says
will actually change.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 45 ++++++++-----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 -
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index fbc2e1dfb610..5c9a88e834e6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2515,41 +2515,35 @@ static enum surface_update_type get_scaling_info_update_type(
 	if (!u->scaling_info)
 		return UPDATE_TYPE_FAST;
 
-	if (u->scaling_info->dst_rect.width != u->surface->dst_rect.width
+	if (u->scaling_info->src_rect.width != u->surface->src_rect.width
+			|| u->scaling_info->src_rect.height != u->surface->src_rect.height
+			|| u->scaling_info->dst_rect.width != u->surface->dst_rect.width
 			|| u->scaling_info->dst_rect.height != u->surface->dst_rect.height
+			|| u->scaling_info->clip_rect.width != u->surface->clip_rect.width
+			|| u->scaling_info->clip_rect.height != u->surface->clip_rect.height
 			|| u->scaling_info->scaling_quality.integer_scaling !=
-				u->surface->scaling_quality.integer_scaling
-			) {
+					u->surface->scaling_quality.integer_scaling) {
 		update_flags->bits.scaling_change = 1;
 
+		if (u->scaling_info->src_rect.width > u->surface->src_rect.width
+				|| u->scaling_info->src_rect.height > u->surface->src_rect.height)
+			/* Making src rect bigger requires a bandwidth change */
+			update_flags->bits.clock_change = 1;
+
 		if ((u->scaling_info->dst_rect.width < u->surface->dst_rect.width
 			|| u->scaling_info->dst_rect.height < u->surface->dst_rect.height)
 				&& (u->scaling_info->dst_rect.width < u->surface->src_rect.width
 					|| u->scaling_info->dst_rect.height < u->surface->src_rect.height))
 			/* Making dst rect smaller requires a bandwidth change */
 			update_flags->bits.bandwidth_change = 1;
-	}
-
-	if (u->scaling_info->src_rect.width != u->surface->src_rect.width
-		|| u->scaling_info->src_rect.height != u->surface->src_rect.height) {
 
-		update_flags->bits.scaling_change = 1;
-		if (u->scaling_info->src_rect.width > u->surface->src_rect.width
-				|| u->scaling_info->src_rect.height > u->surface->src_rect.height)
-			/* Making src rect bigger requires a bandwidth change */
-			update_flags->bits.clock_change = 1;
+		if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
+			(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
+			 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
+			 /* Changing clip size of a large surface may result in MPC slice count change */
+			update_flags->bits.bandwidth_change = 1;
 	}
 
-	if (u->scaling_info->src_rect.width > dc->caps.max_optimizable_video_width &&
-		(u->scaling_info->clip_rect.width > u->surface->clip_rect.width ||
-		 u->scaling_info->clip_rect.height > u->surface->clip_rect.height))
-		 /* Changing clip size of a large surface may result in MPC slice count change */
-		update_flags->bits.bandwidth_change = 1;
-
-	if (u->scaling_info->clip_rect.width != u->surface->clip_rect.width ||
-			u->scaling_info->clip_rect.height != u->surface->clip_rect.height)
-		update_flags->bits.clip_size_change = 1;
-
 	if (u->scaling_info->src_rect.x != u->surface->src_rect.x
 			|| u->scaling_info->src_rect.y != u->surface->src_rect.y
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
@@ -2558,13 +2552,13 @@ static enum surface_update_type get_scaling_info_update_type(
 			|| u->scaling_info->dst_rect.y != u->surface->dst_rect.y)
 		update_flags->bits.position_change = 1;
 
+	/* process every update flag before returning */
 	if (update_flags->bits.clock_change
 			|| update_flags->bits.bandwidth_change
 			|| update_flags->bits.scaling_change)
 		return UPDATE_TYPE_FULL;
 
-	if (update_flags->bits.position_change ||
-			update_flags->bits.clip_size_change)
+	if (update_flags->bits.position_change)
 		return UPDATE_TYPE_MED;
 
 	return UPDATE_TYPE_FAST;
@@ -3263,8 +3257,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 
 		if (update_type != UPDATE_TYPE_MED)
 			continue;
-		if (surface->update_flags.bits.clip_size_change ||
-				surface->update_flags.bits.position_change) {
+		if (surface->update_flags.bits.position_change) {
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
 				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3b6a389fece..6d60f7597f88 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1254,7 +1254,6 @@ union surface_update_flags {
 		uint32_t rotation_change:1;
 		uint32_t swizzle_change:1;
 		uint32_t scaling_change:1;
-		uint32_t clip_size_change: 1;
 		uint32_t position_change:1;
 		uint32_t in_transfer_func_change:1;
 		uint32_t input_csc_change:1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b383ed8cb4d4..e89499536c46 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1732,7 +1732,6 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.scaler ||
 			plane_state->update_flags.bits.scaling_change ||
 			plane_state->update_flags.bits.position_change ||
-			plane_state->update_flags.bits.clip_size_change ||
 			plane_state->update_flags.bits.per_pixel_alpha_change ||
 			pipe_ctx->stream->update_flags.bits.scaling) {
 		pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
@@ -1745,7 +1744,6 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.viewport ||
 			(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
 			(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
-			(context == dc->current_state && plane_state->update_flags.bits.clip_size_change) ||
 			(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
 
 		hubp->funcs->mem_program_viewport(
-- 
2.46.0


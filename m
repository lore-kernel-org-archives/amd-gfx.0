Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC5CF34D9
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4890710E9AF;
	Thu,  3 Oct 2024 23:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ul2MdaAC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E126610E9AB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNbdilKSht58JzCT3uQ6zz0pYPWvlgz8/83WoZVGGJCv6LVOM1X4z4iqovDnmhZMNkzeTrCq3DT2QV+Iqd8zdzWZEk+BbtGJcJtQ3QDOWf3CoY5GTSJQqzcpSkhPOW/FNKl8oZ2yKohi8n/Fdt4F+s/n9230aTHeUxREA1ciRolr+DhxoXWyp6PynVSwrHgS20BPP6ztoDpUPOwe4l2+nikvCjATSOp7jdPsXNT3ECJHIIkQzUfV81B4/jHj1eB2uRSd1HolYPTtuVhoJ6mzG10IC0v7DZTB22JVFM+4FLVCgAsV8J6QGdqEOFKE+APDYyybfEUQ+wMmhjHDN4fwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyrwaOoBxrA4djMTG6t7vzxqKGnnv2gsAt84epSwR5U=;
 b=Uu/f9ld9HcccglN3pYDfM7XAxcSvN+KLSPhQ7ha5DUrmcOuQSlUkZ8gVD8p7tB/d+TnaAClTWnyEOytt6wFYwqmM9rwyCFc90+yF4G4RGc9PeP96zycsdyBsNTLKL7OVtkwEA8tTGNbMWRuGerop/6gh0CbnS8P3kddz6Ng5GVN8oBZEjGgcIwNHrwCTt1T2jFszZDsYKgZMfl5elrzmFazS7cKcI0FHGZylYPERD6uWnAHVGz8MijUWNjFC2byRwsLHOBgFKR/dSjYvnh0InnByXOWnSUSPQc13UiB02PwCYjgfuTwFggsQe7lQ1LX3V9BJx/SVkrjMzYQVyRmW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyrwaOoBxrA4djMTG6t7vzxqKGnnv2gsAt84epSwR5U=;
 b=Ul2MdaACuw1viyLxITDyKgxc/dPTo2D6w/k1CpsVRQ79pQjIJ1s0mzNdkhKGLhLByUyWG43V9cJWY3LAHwvwY8SJhEv4CkwMn7rgDwXW9ZEKLvKjhWL/NaEVc+jsBsP0EnqtoRCD9GXe6j1WPZPEximo+fsm8eluaXoPXvx6HF4=
Received: from PH3PEPF000040A0.namprd05.prod.outlook.com (2603:10b6:518:1::51)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:36:03 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH3PEPF000040A0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>
Subject: [PATCH 15/26] drm/amd/display: calculate final viewport before TAP
 optimization
Date: Thu, 3 Oct 2024 17:33:33 -0600
Message-ID: <20241003233509.210919-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d15957-a003-4eed-9abb-08dce40424d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LXy5SFEauu5P9hHPLM1pSKxXiJd96/lZgecNycOkpFI58zpmL2p9xkgkkuZ3?=
 =?us-ascii?Q?4k24Bj5RCAk0fuvFPtiaoCwwWJOAFoG7/92vYPz+ryFia15Ne5UxD2WlP43x?=
 =?us-ascii?Q?0QBAqa6RLPUW51+ADQdkX2poGhduAzG+DvjFW/okqWM/U+zRoJE/2MJhdSnP?=
 =?us-ascii?Q?qFzvrHiZxwTTiP+INEHnWe4JR3xG1lYCKwqU5jXawtKxHz0AToEVqes76i94?=
 =?us-ascii?Q?5n3bRXohl3+/Nh4vuD8QHHcOYCJtJUayOa0kyFdBkuLdfkUAVGZs29mB3lSE?=
 =?us-ascii?Q?D4TD96DIV35FwTdRG5jVWS9m1Djs1TRB+CWKJE80ryWNkgZfOzvgPZCgRGJP?=
 =?us-ascii?Q?wDtwFE3E7ZS246sgYZshG7jCIIEXQ+JxfRXOfe0bHuCQznAns6VGx4Eqa/SK?=
 =?us-ascii?Q?hsz4AYrCN+vIxMih7O23obZcMQHOWLy2nsLs0Q5wZBbrdxaqzJaMzIDyE2yl?=
 =?us-ascii?Q?OcChbPfcLqnxOFTogPTau4zAGhMcTA/yzhiCYoJLYrg+VCZFeOAqWhUVq7s/?=
 =?us-ascii?Q?rajBbu5Pt3kK9psy0/MNVYRSbgGOzXDci0u4ik+cffXtYz2oWwOjY51dFufx?=
 =?us-ascii?Q?qoTpap1v+uVRmzb5CSHQqB5UCCenaIxtfXjHlEsNu8GynX9odsHzFyUDeVzR?=
 =?us-ascii?Q?0HBUMtiR2lGCNUDotAqzLvhzlxvxKRUp0dqjEZGi08EdFga7qeYvuuUMmN1F?=
 =?us-ascii?Q?fneaz+KCtSBv6OvVTByfhH70LsUp4zoqe8idAoIRYGaSaPpijxpuYdLetEoL?=
 =?us-ascii?Q?cCGDZ1fKO2dU6fL/qQEZXF9IZajoB8t6GUSimpV2djR0fpynIdLYUuBq4bTc?=
 =?us-ascii?Q?FEfa4NQOnJV2jjLy+rrvkHXnaNVsas1xyYuz6qYgVMp9vRQobefFA1pXyE7Y?=
 =?us-ascii?Q?d6AmYJ33UCbPFd2fn+uaPyM0k9a4YDs2aqqv1cCap0wvYHiET9ffWPeuQXbf?=
 =?us-ascii?Q?/uq11MJspSvYFGtsbn8TvZe+5Ym0nyZ/hwVBxF2WjiaGUh9jJbU6Um3yg/8Z?=
 =?us-ascii?Q?UyeyNnvhU62oHEOyJ6VdCNlHsPUIlvJEriM0pUptowCSfqmbUwx6vhLu0asI?=
 =?us-ascii?Q?IFVvdFbMDpaffI6B6kbgGgxvRFajOb8eQv17nnI8mgr5LkLRmDs0HO+3bQsu?=
 =?us-ascii?Q?VTul/6gDmtqQJktetbbfEgcOg+K128t4+XhsQtgAXulQy5aSjLWJuouNxnBK?=
 =?us-ascii?Q?njLNljAY3ELe21t3lrPljNgjKRw3lI/mwkuCwp9DaL1StGkuNRJEDSz6D/yo?=
 =?us-ascii?Q?VK5MS/pHRexCbpmrPZZFOQKvh8AOXIbBTu1s7ZWa6mULP654yvFKR6jx8GhD?=
 =?us-ascii?Q?rv6Ya0ixTq2ZPH4HslAejV7R7VEZLBwhk6neQpw7WE3AH99lXLWOupmWZToG?=
 =?us-ascii?Q?s3T1K5gYwYXc11Q14ASpGDzdOodR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:02.6601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d15957-a003-4eed-9abb-08dce40424d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

Viewport size excess surface size observed sometime with some timings or
resizing the MPO video window to cause MPO unsupported. Calculate final
viewport size first with a 100x100 dummy viewport to get the max TAP
support and then re-run final viewport calculation if TAP value changed.
Removed obsolete preliminary viewport calculation for TAP validation.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 49 +++++++++----------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c7599c40d4be..df513dbd32bd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -765,25 +765,6 @@ static inline void get_vp_scan_direction(
 		*flip_horz_scan_dir = !*flip_horz_scan_dir;
 }
 
-/*
- * This is a preliminary vp size calculation to allow us to check taps support.
- * The result is completely overridden afterwards.
- */
-static void calculate_viewport_size(struct pipe_ctx *pipe_ctx)
-{
-	struct scaler_data *data = &pipe_ctx->plane_res.scl_data;
-
-	data->viewport.width = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.horz, data->recout.width));
-	data->viewport.height = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.vert, data->recout.height));
-	data->viewport_c.width = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.horz_c, data->recout.width));
-	data->viewport_c.height = dc_fixpt_ceil(dc_fixpt_mul_int(data->ratios.vert_c, data->recout.height));
-	if (pipe_ctx->plane_state->rotation == ROTATION_ANGLE_90 ||
-			pipe_ctx->plane_state->rotation == ROTATION_ANGLE_270) {
-		swap(data->viewport.width, data->viewport.height);
-		swap(data->viewport_c.width, data->viewport_c.height);
-	}
-}
-
 static struct rect intersect_rec(const struct rect *r0, const struct rect *r1)
 {
 	struct rect rec;
@@ -1468,6 +1449,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	const struct rect odm_slice_src = resource_get_odm_slice_src_rect(pipe_ctx);
+	struct scaling_taps temp = {0};
 	bool res = false;
 
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
@@ -1525,8 +1507,6 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	calculate_recout(pipe_ctx);
 	/* depends on pixel format */
 	calculate_scaling_ratios(pipe_ctx);
-	/* depends on scaling ratios and recout, does not calculate offset yet */
-	calculate_viewport_size(pipe_ctx);
 
 	/*
 	 * LB calculations depend on vp size, h/v_active and scaling ratios
@@ -1547,6 +1527,24 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 
 	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
 
+	// get TAP value with 100x100 dummy data for max scaling qualify, override
+	// if a new scaling quality required
+	pipe_ctx->plane_res.scl_data.viewport.width = 100;
+	pipe_ctx->plane_res.scl_data.viewport.height = 100;
+	pipe_ctx->plane_res.scl_data.viewport_c.width = 100;
+	pipe_ctx->plane_res.scl_data.viewport_c.height = 100;
+	if (pipe_ctx->plane_res.xfm != NULL)
+		res = pipe_ctx->plane_res.xfm->funcs->transform_get_optimal_number_of_taps(
+				pipe_ctx->plane_res.xfm, &pipe_ctx->plane_res.scl_data, &plane_state->scaling_quality);
+
+	if (pipe_ctx->plane_res.dpp != NULL)
+		res = pipe_ctx->plane_res.dpp->funcs->dpp_get_optimal_number_of_taps(
+				pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data, &plane_state->scaling_quality);
+
+	temp = pipe_ctx->plane_res.scl_data.taps;
+
+	calculate_inits_and_viewports(pipe_ctx);
+
 	if (pipe_ctx->plane_res.xfm != NULL)
 		res = pipe_ctx->plane_res.xfm->funcs->transform_get_optimal_number_of_taps(
 				pipe_ctx->plane_res.xfm, &pipe_ctx->plane_res.scl_data, &plane_state->scaling_quality);
@@ -1573,11 +1571,10 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 					&plane_state->scaling_quality);
 	}
 
-	/*
-	 * Depends on recout, scaling ratios, h_active and taps
-	 * May need to re-check lb size after this in some obscure scenario
-	 */
-	if (res)
+	if (res && (pipe_ctx->plane_res.scl_data.taps.v_taps != temp.v_taps ||
+		pipe_ctx->plane_res.scl_data.taps.h_taps != temp.h_taps ||
+		pipe_ctx->plane_res.scl_data.taps.v_taps_c != temp.v_taps_c ||
+		pipe_ctx->plane_res.scl_data.taps.h_taps_c != temp.h_taps_c))
 		calculate_inits_and_viewports(pipe_ctx);
 
 	/*
-- 
2.45.2


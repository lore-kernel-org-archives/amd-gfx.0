Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F2CC2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F77D10EB4F;
	Thu, 27 Jun 2024 21:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeF3FsI2";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184CF10EB4F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4ujC8o372QZlzekitw6y+55WmEoqhfoXlv/mblRILQQwvXVYrbc+d1OyDl1xc3FOqYNrLbDu88Yqtu6A4pZQ1Nsslhvi6mRCuIykycwIaAQlHP5fLMlb6dWomPHQBBIfwlHHH2ADnH6/LWiM5w94kb3h2JQcsli5h6VylUyGsWYWW27S0LTdSiq0QABb5H05L6c5Biiu0tLotvCsLVWTM9LsBURbDzdnaB+Bo/r89e1b8hqB4c3KhaGjBi/vbWjrCpbWMW8E6Zuf49AiAK/VAq2wKhYCkDWQyijSFJjjkj9zWKtaRBUpKJhSCv7MaUwjjucjKIf39EvAwxPA2QYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqY2jwVsHjmaCKeVVTLkIJp2euo7ath84O6XyFKEbrI=;
 b=XwX3LIr7aBDKV/q7XsxUL/NoVkEhtgyz/qE4JpmowkJwpQWVUX42ZrDOyYiYokdgkLIeng6YY2YvLl4w/1f5C5nfHES3V9cs1bhzNRMRLZXRj4DqZB+nYZH7PCoU7Tg/O1k1lO1NPOV6mrjKCk8vPZCMg9Qgq1b66q+Sd+OkOwkIkVQKqiBi/MK/ld16IfvQ/UHwVXyb/CBmjFs8c6/HXREO6agW5JsICUx6RMDya5fET9UJB4lkU40+jO+MWE+rbKW992aMGsX6A0HWW8bfTuWjRqaIiSsW4nM1UNnGbfEHtOnZAu+NpdtrAjl8CXI7jLtewDKAJxhMSE9Gfc1ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqY2jwVsHjmaCKeVVTLkIJp2euo7ath84O6XyFKEbrI=;
 b=GeF3FsI20TGJQ7zg38Rga8Ln8N032PDEsnvYVp6JFCj9dj7ugBEykoJExufz8EbNj6gvBFFJIQ9pkr0GFfm2r3DcsNdmY3XvjX66cgK97vz1iaApH4+M8scG8gw5KzDISL0h5yRVp0O/ZZIe9C4eBOQmH1ftCk82lkgqsP12e/M=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Thu, 27 Jun
 2024 21:14:07 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::db) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:05 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:59 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 08/26] drm/amd/display: Fix possible overflow in integer
 multiplication
Date: Thu, 27 Jun 2024 17:13:11 -0400
Message-ID: <20240627211329.26386-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3f70d5-6366-4017-e957-08dc96ee1486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tT2AdLgVbuh3Sx+MpHjbILmCwWaXfqD52SnbVTzaKfAjNvTdbr6a423mQxkr?=
 =?us-ascii?Q?tEnHOUyAFAJAG83sQx4OWoUvOLt6fkktI8BLuOE0lldRmlZZKXxDC/PXB4gF?=
 =?us-ascii?Q?2j25rQVDndnDJBujAb846w2Wkasb9vf5dV5FuUrkBquO+etUvbM57IV2Z36g?=
 =?us-ascii?Q?XcG0gDGKwxsIi3uHsjUFU633S1Rsvyw1fYb8aWreEoUZrK3iGjoOgQMGIDhi?=
 =?us-ascii?Q?SrJFVtKFcFJohDq1L2L5urvojttv2qdH34D0OXfAjb8Ka3ngQNnNI0sah65g?=
 =?us-ascii?Q?iRnyPpA6MXgQwyNW31XnZDbWIOJGYrlKy3NF/UrtNaHiWmRb894YCviUMVfl?=
 =?us-ascii?Q?1+RyVsc2V3Wd5dza3yGIcLJiNKUYf1nIL8xjcgqtNOSsvPc5QK2VuvLaK357?=
 =?us-ascii?Q?7J7gw6sal5iKA8uCvh3WKnJqBotCbiJGU568gOmtIaoXxbugvmxQqau6AV6L?=
 =?us-ascii?Q?xrVj0G3+4f3w88229Pt3eJJaEcgaii7dQOcqKI4dX2BXXMi4ygLk3AF35xl3?=
 =?us-ascii?Q?SRz73k/bmhSXYaKOgx+Ns2odD04Qfx3yqTub6tMkv6/Q2lacm81KLhLUDHwS?=
 =?us-ascii?Q?9PWZqpT8raUJh8BAETlNWaN/TFk2zFAov9MztY+PFuY2ZePBTf9eJ+qO7vqi?=
 =?us-ascii?Q?P4TauKVIsVeYA3sMsQ0j041aePtRB1U+3oZtQfw0P7gxAUA+3hqlXr+4JReW?=
 =?us-ascii?Q?8k7xB9Ozs6y+drzcFtHIioLc+rJN30rqSyZ976UhzZN8p4eK1fcqYwCowXma?=
 =?us-ascii?Q?BfAIbid6Kj/eT+0u5HoXzuTaW3vuli2zQ7Thn76BmF7IEUsRbJf1LXMfeT/G?=
 =?us-ascii?Q?TTEWmgp+OO30Q+OhL9eP0HnxmjT989aur+THVI+mZnYgWHyXlPLcvYc04Vdw?=
 =?us-ascii?Q?4RtnhC+AInKueuT1g2VBTyLy3prH8KC5Zmdk1v3iLs4O4X2kJQffMzVhqR9P?=
 =?us-ascii?Q?cWvR48lqXaCichNNYOzrCHMpMT1hbYnGIL/I05/XNtvKmEktg6Ep/VXYrTB0?=
 =?us-ascii?Q?o/DWnxcVxNvWnppvnUFMT9OBO7+EMbCGo7Ph7ppLNrI7W4uUXyuMUKUNO3kA?=
 =?us-ascii?Q?c0IwUawJT8EdyeWLoopV3pjtIhxVikWRUIdveTDGB3rXQ8dbZRqQY3ztfp1I?=
 =?us-ascii?Q?ST6r9/NTSr9Ef+wM6l5jtEY914nmWfCBfJv3Lppqyj5nvPqCpKN64u3qc4s9?=
 =?us-ascii?Q?EtZshJd/6GN9/gU37BfccTUGbumHvJ5abyrCCQykqIeILUL8SdRfRts9C+1L?=
 =?us-ascii?Q?vJ3MJRGc/VArZiDkeRWWdxqcoM9RJzUur2KPiTMzqfjFo/3y6KsR3NTpa2kH?=
 =?us-ascii?Q?ZtoNAErYCDnc/wUniMfq5xK418cK+iiQCKZUQDf2Q+Y8MD1x5aO222bKIDwZ?=
 =?us-ascii?Q?v/CEqKo5jm4QmogAYJgOLXhWIpmCxCHKD7GTpljMWD1Dj/wPg5h6N/qfHx4f?=
 =?us-ascii?Q?pu/Dk4OXzPLACYrWJhPTIpaKvS99nfwb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:06.7724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3f70d5-6366-4017-e957-08dc96ee1486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Integer multiplies integer may overflow in context that expects an
expression of unsigned/siged long long (64 bits). This can be fixed
by casting integer to unsigned/siged long long to force 64 bits results.

This fixes 26 OVERFLOW_BEFORE_WIDEN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c         | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         | 8 ++++----
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c           | 6 +++---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c     | 8 ++++----
 drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 2 +-
 .../display/dc/link/protocols/link_edp_panel_control.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c               | 8 ++++----
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c   | 2 +-
 13 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 633ab1c16dc6..f40240aafe98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -158,7 +158,7 @@ void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	DRM_DEBUG_DRIVER("Enabling psr...\n");
 
 	vsync_rate_hz = div64_u64(div64_u64((
-			stream->timing.pix_clk_100hz * 100),
+			stream->timing.pix_clk_100hz * (uint64_t)100),
 			stream->timing.v_total),
 			stream->timing.h_total);
 
diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index b30c2cdc1a61..e47e9db062f4 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -1853,7 +1853,7 @@ static void calculate_bandwidth(
 	/*compute total time to request one chunk from each active display pipe*/
 	for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
 		if (data->enable[i]) {
-			data->chunk_request_time = bw_add(data->chunk_request_time, (bw_div((bw_div(bw_int_to_fixed(pixels_per_chunk * data->bytes_per_pixel[i]), data->useful_bytes_per_request[i])), bw_min2(sclk[data->sclk_level], bw_div(data->dispclk, bw_int_to_fixed(2))))));
+			data->chunk_request_time = bw_add(data->chunk_request_time, (bw_div((bw_div(bw_int_to_fixed(pixels_per_chunk * (int64_t)data->bytes_per_pixel[i]), data->useful_bytes_per_request[i])), bw_min2(sclk[data->sclk_level], bw_div(data->dispclk, bw_int_to_fixed(2))))));
 		}
 	}
 	/*compute total time to request cursor data*/
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 3b10b24f5e23..084994c650c4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -576,7 +576,7 @@ static void dcn32_auto_dpm_test_log(
 			p_state_list[i] = curr_pipe_ctx->p_state_type;
 
 			refresh_rate = (curr_pipe_ctx->stream->timing.pix_clk_100hz * (uint64_t)100 +
-				curr_pipe_ctx->stream->timing.v_total * curr_pipe_ctx->stream->timing.h_total - (uint64_t)1);
+				curr_pipe_ctx->stream->timing.v_total * (uint64_t)curr_pipe_ctx->stream->timing.h_total - (uint64_t)1);
 			refresh_rate = div_u64(refresh_rate, curr_pipe_ctx->stream->timing.v_total);
 			refresh_rate = div_u64(refresh_rate, curr_pipe_ctx->stream->timing.h_total);
 			disp_src_refresh_list[i] = refresh_rate;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index eb053e1791c0..bcb5267b5a6b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -888,21 +888,21 @@ static struct rect calculate_plane_rec_in_timing_active(
 	struct rect rec_out = {0};
 	struct fixed31_32 temp;
 
-	temp = dc_fixpt_from_fraction(rec_in->x * stream->dst.width,
+	temp = dc_fixpt_from_fraction(rec_in->x * (long long)stream->dst.width,
 			stream->src.width);
 	rec_out.x = stream->dst.x + dc_fixpt_round(temp);
 
 	temp = dc_fixpt_from_fraction(
-			(rec_in->x + rec_in->width) * stream->dst.width,
+			(rec_in->x + rec_in->width) * (long long)stream->dst.width,
 			stream->src.width);
 	rec_out.width = stream->dst.x + dc_fixpt_round(temp) - rec_out.x;
 
-	temp = dc_fixpt_from_fraction(rec_in->y * stream->dst.height,
+	temp = dc_fixpt_from_fraction(rec_in->y * (long long)stream->dst.height,
 			stream->src.height);
 	rec_out.y = stream->dst.y + dc_fixpt_round(temp);
 
 	temp = dc_fixpt_from_fraction(
-			(rec_in->y + rec_in->height) * stream->dst.height,
+			(rec_in->y + rec_in->height) * (long long)stream->dst.height,
 			stream->src.height);
 	rec_out.height = stream->dst.y + dc_fixpt_round(temp) - rec_out.y;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index de0633f98158..be2638c763d7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -975,7 +975,7 @@ static int dc_stream_calculate_flickerless_refresh_rate(struct dc_stream_state *
 	}
 
 	if (search_for_max_increase)
-		return (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*stream->timing.h_total);
+		return (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*(long long)stream->timing.h_total);
 	else
 		return stream->lumin_data.refresh_rate_hz[0];
 }
@@ -1024,7 +1024,7 @@ static unsigned int dc_stream_get_max_flickerless_instant_vtotal_delta(struct dc
 	if (stream->timing.v_total * stream->timing.h_total == 0)
 		return 0;
 
-	int current_refresh_hz = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*stream->timing.h_total);
+	int current_refresh_hz = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*(long long)stream->timing.h_total);
 
 	int safe_refresh_hz = dc_stream_calculate_flickerless_refresh_rate(stream,
 							 dc_stream_get_brightness_millinits_from_refresh(stream, current_refresh_hz),
@@ -1032,7 +1032,7 @@ static unsigned int dc_stream_get_max_flickerless_instant_vtotal_delta(struct dc
 							 is_gaming,
 							 increase);
 
-	int safe_refresh_v_total = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, safe_refresh_hz*stream->timing.h_total);
+	int safe_refresh_v_total = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, safe_refresh_hz*(long long)stream->timing.h_total);
 
 	if (increase)
 		return (((int) stream->timing.v_total - safe_refresh_v_total) >= 0) ? (stream->timing.v_total - safe_refresh_v_total) : 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 12f3c35b3a34..c3deb4ab3992 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -353,7 +353,7 @@ static uint32_t calculate_required_audio_bw_in_symbols(
 	/* DP spec recommends between 1.05 to 1.1 safety margin to prevent sample under-run */
 	struct fixed31_32 audio_sdp_margin = dc_fixpt_from_fraction(110, 100);
 	struct fixed31_32 horizontal_line_freq_khz = dc_fixpt_from_fraction(
-			crtc_info->requested_pixel_clock_100Hz, crtc_info->h_total * 10);
+			crtc_info->requested_pixel_clock_100Hz, (long long)crtc_info->h_total * 10);
 	struct fixed31_32 samples_per_line;
 	struct fixed31_32 layouts_per_line;
 	struct fixed31_32 symbols_per_sdp_max_layout;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 042a4187fff4..b700608e4240 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -217,7 +217,7 @@ static bool calc_fb_divider_checking_tolerance(
 	actual_calc_clk_100hz = (uint64_t)feedback_divider *
 					calc_pll_cs->fract_fb_divider_factor +
 							fract_feedback_divider;
-	actual_calc_clk_100hz *= calc_pll_cs->ref_freq_khz * 10;
+	actual_calc_clk_100hz *= (uint64_t)calc_pll_cs->ref_freq_khz * 10;
 	actual_calc_clk_100hz =
 		div_u64(actual_calc_clk_100hz,
 			ref_divider * post_divider *
@@ -680,7 +680,7 @@ static bool calculate_ss(
 	 * so have to divided by 100 * 100*/
 	ss_amount = dc_fixpt_mul(
 		fb_div, dc_fixpt_from_fraction(ss_data->percentage,
-					100 * ss_data->percentage_divider));
+					100 * (long long)ss_data->percentage_divider));
 	ds_data->feedback_amount = dc_fixpt_floor(ss_amount);
 
 	ss_nslip_amount = dc_fixpt_sub(ss_amount,
@@ -695,8 +695,8 @@ static bool calculate_ss(
 
 	/* compute SS_STEP_SIZE_DSFRAC */
 	modulation_time = dc_fixpt_from_fraction(
-		pll_settings->reference_freq * 1000,
-		pll_settings->reference_divider * ss_data->modulation_freq_hz);
+		pll_settings->reference_freq * (uint64_t)1000,
+		pll_settings->reference_divider * (uint64_t)ss_data->modulation_freq_hz);
 
 	if (ss_data->flags.CENTER_SPREAD)
 		modulation_time = dc_fixpt_div_int(modulation_time, 4);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index 5bca67407c5b..de31fb1b6819 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -218,7 +218,7 @@ static void dce_driver_set_backlight(struct panel_cntl *panel_cntl,
 	 * contain integer component, lower 16 bits contain fractional component
 	 * of active duty cycle e.g. 0x21BDC0 = 0xEFF0 * 0x24
 	 */
-	active_duty_cycle = backlight_pwm_u16_16 * masked_pwm_period;
+	active_duty_cycle = backlight_pwm_u16_16 * (uint64_t)masked_pwm_period;
 
 	/* 1.3 Calculate 16 bit active duty cycle from integer and fractional
 	 * components shift by bitCount then mask 16 bits and add rounding bit
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7abf8b88ca91..9d399c4ce957 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -997,7 +997,7 @@ static bool subvp_subvp_admissable(struct dc *dc,
 		if (pipe->plane_state && !pipe->top_pipe &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
 			refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
-				pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+				pipe->stream->timing.v_total * (uint64_t)pipe->stream->timing.h_total - (uint64_t)1);
 			refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
 			refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 4ef329a4d764..e06fc370267b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2208,7 +2208,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 					grouped_pipes[i]->stream->signal)) {
 				embedded = i;
 				master = i;
-				phase[i] = embedded_pix_clk_100hz*100;
+				phase[i] = embedded_pix_clk_100hz*(uint64_t)100;
 				modulo[i] = dp_ref_clk_100hz*100;
 			} else {
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 455b85adec28..bf820d2b4dc4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -763,7 +763,7 @@ bool edp_setup_psr(struct dc_link *link,
 
 	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
 	psr_context->vsync_rate_hz = div64_u64(div64_u64((stream->
-					timing.pix_clk_100hz * 100),
+					timing.pix_clk_100hz * (u64)100),
 					stream->timing.v_total),
 					stream->timing.h_total);
 
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index ac58991eebbc..e3e20cd86af6 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -110,21 +110,21 @@ static struct spl_rect calculate_plane_rec_in_timing_active(
 	struct fixed31_32 temp;
 
 
-	temp = dc_fixpt_from_fraction(rec_in->x * stream_dst->width,
+	temp = dc_fixpt_from_fraction(rec_in->x * (long long)stream_dst->width,
 			stream_src->width);
 	rec_out.x = stream_dst->x + dc_fixpt_round(temp);
 
 	temp = dc_fixpt_from_fraction(
-			(rec_in->x + rec_in->width) * stream_dst->width,
+			(rec_in->x + rec_in->width) * (long long)stream_dst->width,
 			stream_src->width);
 	rec_out.width = stream_dst->x + dc_fixpt_round(temp) - rec_out.x;
 
-	temp = dc_fixpt_from_fraction(rec_in->y * stream_dst->height,
+	temp = dc_fixpt_from_fraction(rec_in->y * (long long)stream_dst->height,
 			stream_src->height);
 	rec_out.y = stream_dst->y + dc_fixpt_round(temp);
 
 	temp = dc_fixpt_from_fraction(
-			(rec_in->y + rec_in->height) * stream_dst->height,
+			(rec_in->y + rec_in->height) * (long long)stream_dst->height,
 			stream_src->height);
 	rec_out.height = stream_dst->y + dc_fixpt_round(temp) - rec_out.y;
 
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index d09627c15b9c..a40e6590215a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1002,7 +1002,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 
 	if (stream->ctx->dc->caps.max_v_total != 0 && stream->timing.h_total != 0) {
 		min_hardware_refresh_in_uhz = div64_u64((stream->timing.pix_clk_100hz * 100000000ULL),
-			(stream->timing.h_total * stream->ctx->dc->caps.max_v_total));
+			(stream->timing.h_total * (long long)stream->ctx->dc->caps.max_v_total));
 	}
 	/* Limit minimum refresh rate to what can be supported by hardware */
 	min_refresh_in_uhz = min_hardware_refresh_in_uhz > in_config->min_refresh_in_uhz ?
-- 
2.34.1


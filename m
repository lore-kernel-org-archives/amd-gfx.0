Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D0BCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975BD10E845;
	Wed, 10 Sep 2025 05:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D/3tvYg2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4637B10E845
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4rH7FqgE/GQ2k4Q9gC7BLWmAv9mIzyo8tjwl69V7Bzvx3wYJxBojCFEF7Cc2Avdq2VPbfFdv4IKnh+s47LenPvCrbk15b+tC8NGwlrzecHTRcRsCrqqmZ8VcikRu1BKAouo6Jb6W9qcsF9TAswe8n0ja7lHzu3DATMSytP56uG+in5lBfEmNlTy3QMfQJXzKPjH5SYGEt0aoUKsmfgaIrNa1RvLaIGsKe/STKAVyOnSVBP+Reslmkhja3AZcg1omZF+yKAGI5EhnonWHe7x+3gUl0Z/duCjl6VIAoeCLqWpNCwDPtQ0fyIF4l1tv5JpfMC0cpmX9GIKZEZSxvxR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKDokhzUx/C9Gb5/tWWBrmPBPiw3b8mmh323dg5HhgM=;
 b=nwom7pvQ2MGpeca6Yv4DuBaprsWziEms7DdoVtsRtCKn3f4mXLGzB6aclmzSwDOKR2W8r8HnRW/HMuLBMtlp0yKkTo+j4O0AYLbvi5nGBjFJZ3Zmdbg9Dsj2y+uYMbPAvF52dUb73hrlgFLpRdyUA0yKfXTLqhI3HVs/wtuAsaSx82JD4swohGXXhxG4RozOk9Vg7H6s2Sj9vaZXFHVSocg2QAfyjw53abHQu4D6qWHD1sE8H+0Yfio9Ngzifyknsajh8kw3OhfV4OduKIi0XRLdr8AN/AjaqWfyMG0Cdewe9xI5GZi8vBvjVB4fFv0VzfBrhz9CNo71gJOr8Bc6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKDokhzUx/C9Gb5/tWWBrmPBPiw3b8mmh323dg5HhgM=;
 b=D/3tvYg2jZQhbXvbifNFKbmAlLC5ULSXS6g8xwOqmigdvCPaFw+fQbpnO4E560fwrxQNYdmDSyY8lZXiBr8hI6Pmq+CK8ruB9rZk5FlwdMKOCWlY6rJiI1Xup/pg8t8IkGDl8WfTxcXg7J4NIpuxIE1MkY2hzzKAATdWJTODcww=
Received: from BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::18)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:27:33 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::70) by BL1P222CA0013.outlook.office365.com
 (2603:10b6:208:2c7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 05:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:27:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:27:30 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:27:29 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:27:26 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Relja
 Vojvodic" <rvojvodi@amd.com>, Chris Park <chris.park@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/15] drm/amd/display: Add DSC padding for OVT Support
Date: Wed, 10 Sep 2025 13:22:15 +0800
Message-ID: <20250910052620.2884581-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052620.2884581-1-ray.wu@amd.com>
References: <20250910052620.2884581-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e1d465-cf69-4f9f-32e5-08ddf02abe73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jTW0a5ZmQo+Ax1YbMLc55CNlFfjMqkugn4nMDwm8G0BYAOMheDKhlnWffWvb?=
 =?us-ascii?Q?ntAqbCiO2l42pJXxVo2Dakwo76VEeO6rYTIx6jyLqyYLZYmQK79MgUlkJ7k/?=
 =?us-ascii?Q?NRU4ShBfLv3vrJnP6dSplASDb3gx4VfhF1/56A8J7B06tJsUqxbzvytWsOMP?=
 =?us-ascii?Q?1vNxKBmmWpixzk6PhSfouh11AXzKkpcet3YkwpfTsb2hsoxNjP2qxqguc/T2?=
 =?us-ascii?Q?2cKkgCKgTivwUF3tOdkJut3VMTqXufiJbhHOOUkMITDdc45Dm8nNSaOPvjSk?=
 =?us-ascii?Q?SBQ4+/x0yuShp6j3UfnAclOCGokwTK2arONSzl/0pcN4pyk8we4Vw1o30TUj?=
 =?us-ascii?Q?cADp8oo3ygY07s5fRbtfnfsK6VnJvv3Sb6GGnOkEmVyAzBjcDybF96DhQVFq?=
 =?us-ascii?Q?XeS6hcxSnEln+ljMBFMzXI9jKlvQ35hkzyh0/7HEG6wUt3kX7T3Q49tdjbrn?=
 =?us-ascii?Q?+QVpjWNZ8xh/lNqHzEoKhwtxvIg8RhrGMfpBoSlKJjY9xBte0Jsk8Wu8db2y?=
 =?us-ascii?Q?+HV+UwmrW7KKktgBEk65osXE1LCdipZNWb3Lzt+EMyQtNA2LRriIjQHjbbLL?=
 =?us-ascii?Q?lU91L3uOj5UVMOc7VCC8+/tWk0+pkouZc+FW+9OoN9ifbgjdZZrVYJEoY3pI?=
 =?us-ascii?Q?VVMfYwGjUp6vEP0rMB3sCJQSA0XWxjcNPLi8fd2ANyczlQ6UmeJ4049Z6ey6?=
 =?us-ascii?Q?wplZDFs25Wc7iWZOXDyZFAPHZ0ieFHTwbgmdow+BG24M1fRMamed+vFoGM0J?=
 =?us-ascii?Q?B2szXueyitPQojAYMc+2cLlac+riUWeT2YGdc97V058Ka7CRKw4H4bRqGVa/?=
 =?us-ascii?Q?B3H3n3ZBpvH3ToQZ3NuVBWMiT+BaJ+t+iPaT0B/WXeku5MHFvK6h4gNv5/8L?=
 =?us-ascii?Q?MATGslBziB2d5Tz+f4MZwGeRTLkX1gL28NH1j41FP7CbV2H4crEejI8VZgnv?=
 =?us-ascii?Q?JGkeYh88RsDACW5fp+YsgLjDPZlWLN6Zxg4tXqAoFsQQP6wpJ+/ySv7eOlmh?=
 =?us-ascii?Q?JV0UeOhFNz72/fe7Z96GvIF4+J23tBBHftFn+8fJPGN1/p3RPskWZdq/F5iE?=
 =?us-ascii?Q?Qzxx967lzhL0wFAckftv4RI2RhWrLw54e8Z1K05zxtfn09l/lfTqCuc4mBss?=
 =?us-ascii?Q?tg9O4//2wHXrzX1sIsXGnr3fwHKSETlF2OT+gaYP3dRuK3LFpCZknTN/e+jU?=
 =?us-ascii?Q?tcA45Mhc/LpjADphZsuQTY4CRrkGWXGyAVdGL5p1nCsv1davIlYshQv95Po2?=
 =?us-ascii?Q?7tkp8mVxAayRBNfG9K0/m98sEayYvQb4xQ0xbFuttoangUrOjJofV3g88P7q?=
 =?us-ascii?Q?Ni2FAuc+psBoEvOhsNcQtOYc2z8MSm9XWluqVvMZYfFS63Jhb7KalvHL8M+t?=
 =?us-ascii?Q?fBaSrTt5A5plpTvgSbrIYZS0l4dJav1Mwy6rIeKHOpkbNBPn92HWNnimay0X?=
 =?us-ascii?Q?r+M233Zx+gxCSNSUPbignWZ7k1uD5XXdh1dPIx099jUvmSUlJc1V4+r8367B?=
 =?us-ascii?Q?th0LIDv8dE5F8w0O2HHeTpWw/CBBdiH9lq1Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:27:33.0567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e1d465-cf69-4f9f-32e5-08ddf02abe73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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

From: Relja Vojvodic <rvojvodi@amd.com>

[Why]
-Certain OVT timings require DSC configurations which divide the
horizontal active unevenly across DSC slices
-DSC slices must be even, so padding needs to be added to the active
to make this possible
-The pixel clock of the HW now needs to be increased to accommodate
the extra padded pixels
-To keep the line time the same, the blank of the HW timing needs to
be increased as well

[How]
-Calculate h_active padding, h_total padding, and pixel clock based
off of the original OVT timing and DSC calculations
-Store these values in the pipe and program HW with these modifications
-Added general support for cases where DSC slice config does not evenly
split the horizontal active by fixing some slice width calculations
-Updated PPS calculations for these cases

Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 35 +++++++---------
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  | 41 ++++++++-----------
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |  3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  9 ++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 10 ++++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  3 ++
 10 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 89c805457ed8..cbca3c67f439 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -95,7 +95,6 @@
 #define DC_LOGGER \
 	dc->ctx->logger
 #define DC_LOGGER_INIT(logger)
-
 #include "dml2/dml2_wrapper.h"
 
 #define UNABLE_TO_SPLIT -1
@@ -2149,7 +2148,7 @@ int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
 	h_active = timing->h_addressable +
 			timing->h_border_left +
 			timing->h_border_right +
-			otg_master->hblank_borrow;
+			otg_master->dsc_padding_params.dsc_hactive_padding;
 	width = h_active / count;
 
 	if (otg_master->stream_res.tg)
@@ -4267,39 +4266,33 @@ enum dc_status dc_validate_with_context(struct dc *dc,
 	return res;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_FP)
+#endif /* CONFIG_DRM_AMD_DC_FP */
+
 /**
- * decide_hblank_borrow - Decides the horizontal blanking borrow value for a given pipe context.
+ * calculate_timing_params_for_dsc_with_padding - Calculates timing parameters for DSC with padding.
  * @pipe_ctx: Pointer to the pipe context structure.
  *
- * This function calculates the horizontal blanking borrow value for a given pipe context based on the
+ * This function calculates the timing parameters for a given pipe context based on the
  * display stream compression (DSC) configuration. If the horizontal active pixels (hactive) are less
- * than the total width of the DSC slices, it sets the hblank_borrow value to the difference. If the
- * total horizontal timing minus the hblank_borrow value is less than 32, it resets the hblank_borrow
+ * than the total width of the DSC slices, it sets the dsc_hactive_padding value to the difference. If the
+ * total horizontal timing minus the dsc_hactive_padding value is less than 32, it resets the dsc_hactive_padding
  * value to 0.
  */
-static void decide_hblank_borrow(struct pipe_ctx *pipe_ctx)
+static void calculate_timing_params_for_dsc_with_padding(struct pipe_ctx *pipe_ctx)
 {
-	uint32_t hactive;
-	uint32_t ceil_slice_width;
 	struct dc_stream_state *stream = NULL;
 
 	if (!pipe_ctx)
 		return;
 
 	stream = pipe_ctx->stream;
+	pipe_ctx->dsc_padding_params.dsc_hactive_padding = 0;
+	pipe_ctx->dsc_padding_params.dsc_htotal_padding = 0;
 
-	if (stream->timing.flags.DSC) {
-		hactive = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	if (stream)
+		pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
-		/* Assume if determined slices does not divide Hactive evenly, Hborrow is needed for padding*/
-		if (hactive % stream->timing.dsc_cfg.num_slices_h != 0) {
-			ceil_slice_width = (hactive / stream->timing.dsc_cfg.num_slices_h) + 1;
-			pipe_ctx->hblank_borrow = ceil_slice_width * stream->timing.dsc_cfg.num_slices_h - hactive;
-
-			if (stream->timing.h_total - hactive - pipe_ctx->hblank_borrow < 32)
-				pipe_ctx->hblank_borrow = 0;
-		}
-	}
 }
 
 /**
@@ -4342,7 +4335,7 @@ enum dc_status dc_validate_global_state(
 
 			/* Decide whether hblank borrow is needed and save it in pipe_ctx */
 			if (dc->debug.enable_hblank_borrow)
-				decide_hblank_borrow(pipe_ctx);
+				calculate_timing_params_for_dsc_with_padding(pipe_ctx);
 
 			if (dc->res_pool->funcs->patch_unknown_plane_state &&
 					pipe_ctx->plane_state &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 7f57661433eb..55704d4457ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -128,7 +128,7 @@ void translate_SPL_in_params_from_pipe_ctx(struct pipe_ctx *pipe_ctx, struct spl
 	spl_in->odm_slice_index = resource_get_odm_slice_index(pipe_ctx);
 	// Make spl input basic out info output_size width point to stream h active
 	spl_in->basic_out.output_size.width =
-		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->hblank_borrow;
+		stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 	// Make spl input basic out info output_size height point to v active
 	spl_in->basic_out.output_size.height =
 		stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index f6879e622271..bf5e7f4e0416 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -84,25 +84,29 @@ static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stre
 
 static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
 		struct dc_stream_state *stream,
+		struct pipe_ctx *pipe_ctx,
 		struct dml2_context *dml_ctx)
 {
 	unsigned int hblank_start, vblank_start, min_hardware_refresh_in_uhz;
+	uint32_t pix_clk_100hz;
 
-	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 	timing->v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
 	timing->h_front_porch = stream->timing.h_front_porch;
 	timing->v_front_porch = stream->timing.v_front_porch;
 	timing->pixel_clock_khz = stream->timing.pix_clk_100hz / 10;
+	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
+		timing->pixel_clock_khz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz / 10;
 	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 		timing->pixel_clock_khz *= 2;
-	timing->h_total = stream->timing.h_total;
+	timing->h_total = stream->timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
 	timing->v_total = stream->timing.v_total;
 	timing->h_sync_width = stream->timing.h_sync_width;
 	timing->interlaced = stream->timing.flags.INTERLACE;
 
 	hblank_start = stream->timing.h_total - stream->timing.h_front_porch;
 
-	timing->h_blank_end = hblank_start - stream->timing.h_addressable
+	timing->h_blank_end = hblank_start - stream->timing.h_addressable - pipe_ctx->dsc_padding_params.dsc_hactive_padding
 		- stream->timing.h_border_left - stream->timing.h_border_right;
 
 	if (hblank_start < stream->timing.h_addressable)
@@ -121,8 +125,13 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	/* limit min refresh rate to DC cap */
 	min_hardware_refresh_in_uhz = stream->timing.min_refresh_in_uhz;
 	if (stream->ctx->dc->caps.max_v_total != 0) {
-		min_hardware_refresh_in_uhz = div64_u64((stream->timing.pix_clk_100hz * 100000000ULL),
-				(stream->timing.h_total * (long long)calc_max_hardware_v_total(stream)));
+		if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0) {
+			pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+		} else {
+			pix_clk_100hz = stream->timing.pix_clk_100hz;
+		}
+		min_hardware_refresh_in_uhz = div64_u64((pix_clk_100hz * 100000000ULL),
+				(timing->h_total * (long long)calc_max_hardware_v_total(stream)));
 	}
 
 	timing->drr_config.min_refresh_uhz = max(stream->timing.min_refresh_in_uhz, min_hardware_refresh_in_uhz);
@@ -173,21 +182,6 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	timing->vblank_nom = timing->v_total - timing->v_active;
 }
 
-/**
- * adjust_dml21_hblank_timing_config_from_pipe_ctx - Adjusts the horizontal blanking timing configuration
- *                                                   based on the pipe context.
- * @timing: Pointer to the dml2_timing_cfg structure to be adjusted.
- * @pipe: Pointer to the pipe_ctx structure containing the horizontal blanking borrow value.
- *
- * This function modifies the horizontal active and blank end timings by adding and subtracting
- * the horizontal blanking borrow value from the pipe context, respectively.
- */
-static void adjust_dml21_hblank_timing_config_from_pipe_ctx(struct dml2_timing_cfg *timing, struct pipe_ctx *pipe)
-{
-	timing->h_active += pipe->hblank_borrow;
-	timing->h_blank_end -= pipe->hblank_borrow;
-}
-
 static void populate_dml21_output_config_from_stream_state(struct dml2_link_output_cfg *output,
 		struct dc_stream_state *stream, const struct pipe_ctx *pipe)
 {
@@ -487,7 +481,9 @@ static const struct scaler_data *get_scaler_data_for_plane(
 			temp_pipe->plane_state = pipe->plane_state;
 			temp_pipe->plane_res.scl_data.taps = pipe->plane_res.scl_data.taps;
 			temp_pipe->stream_res = pipe->stream_res;
-			temp_pipe->hblank_borrow = pipe->hblank_borrow;
+			temp_pipe->dsc_padding_params.dsc_hactive_padding = pipe->dsc_padding_params.dsc_hactive_padding;
+			temp_pipe->dsc_padding_params.dsc_htotal_padding = pipe->dsc_padding_params.dsc_htotal_padding;
+			temp_pipe->dsc_padding_params.dsc_pix_clk_100hz = pipe->dsc_padding_params.dsc_pix_clk_100hz;
 			dml_ctx->config.callbacks.build_scaling_params(temp_pipe);
 			break;
 		}
@@ -755,8 +751,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 			disp_cfg_stream_location = dml_dispcfg->num_streams++;
 
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
-		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], dml_ctx);
-		adjust_dml21_hblank_timing_config_from_pipe_ctx(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, &context->res_ctx.pipe_ctx[stream_index]);
+		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index], dml_ctx);
 		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
index bd1b9aef6d5c..89f0d999bf35 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c
@@ -406,9 +406,10 @@ bool dsc_prepare_config(const struct dsc_config *dsc_cfg, struct dsc_reg_values
 	dsc_reg_vals->alternate_ich_encoding_en = dsc_reg_vals->pps.dsc_version_minor == 1 ? 0 : 1;
 	dsc_reg_vals->ich_reset_at_eol = (dsc_cfg->is_odm || dsc_reg_vals->num_slices_h > 1) ? 0xF : 0;
 
+	// Need to find the ceiling value for the slice width
+	dsc_reg_vals->pps.slice_width = (dsc_cfg->pic_width + dsc_cfg->dc_dsc_cfg.num_slices_h - 1) / dsc_cfg->dc_dsc_cfg.num_slices_h;
 	// TODO: in addition to validating slice height (pic height must be divisible by slice height),
 	// see what happens when the same condition doesn't apply for slice_width/pic_width.
-	dsc_reg_vals->pps.slice_width = dsc_cfg->pic_width / dsc_cfg->dc_dsc_cfg.num_slices_h;
 	dsc_reg_vals->pps.slice_height = dsc_cfg->pic_height / dsc_cfg->dc_dsc_cfg.num_slices_v;
 
 	ASSERT(dsc_reg_vals->pps.slice_height * dsc_cfg->dc_dsc_cfg.num_slices_v == dsc_cfg->pic_height);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 3a6f946643ef..f39292952702 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1052,7 +1052,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		}
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
 				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 9956145e3d18..1b0b772fc5dd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -810,9 +810,12 @@ enum dc_status dcn401_enable_stream_timing(
 	if (dc->hwseq->funcs.PLAT_58856_wa && (!dc_is_dp_signal(stream->signal)))
 		dc->hwseq->funcs.PLAT_58856_wa(context, pipe_ctx);
 
-	/* if we are borrowing from hblank, h_addressable needs to be adjusted */
-	if (dc->debug.enable_hblank_borrow)
-		patched_crtc_timing.h_addressable = patched_crtc_timing.h_addressable + pipe_ctx->hblank_borrow;
+	/* if we are padding, h_addressable needs to be adjusted */
+	if (dc->debug.enable_hblank_borrow) {
+		patched_crtc_timing.h_addressable = patched_crtc_timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		patched_crtc_timing.h_total = patched_crtc_timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
+		patched_crtc_timing.pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+	}
 
 	pipe_ctx->stream_res.tg->funcs->program_timing(
 		pipe_ctx->stream_res.tg,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index d30f94c35f11..f49549147d99 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -437,6 +437,13 @@ enum p_state_switch_method {
 	P_STATE_V_BLANK_SUB_VP,
 };
 
+struct dsc_padding_params {
+	/* pixels borrowed from hblank to hactive */
+	uint8_t dsc_hactive_padding;
+	uint32_t dsc_htotal_padding;
+	uint32_t dsc_pix_clk_100hz;
+};
+
 struct pipe_ctx {
 	struct dc_plane_state *plane_state;
 	struct dc_stream_state *stream;
@@ -494,8 +501,7 @@ struct pipe_ctx {
 	/* subvp_index: only valid if the pipe is a SUBVP_MAIN*/
 	uint8_t subvp_index;
 	struct pixel_rate_divider pixel_rate_divider;
-	/* pixels borrowed from hblank to hactive */
-	uint8_t hblank_borrow;
+	struct dsc_padding_params dsc_padding_params;
 	/* next vupdate */
 	uint32_t next_vupdate;
 	uint32_t wait_frame_count;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 08ee8d2f777b..83419e1a9036 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -832,7 +832,7 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		enum optc_dsc_mode optc_dsc_mode;
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->hblank_borrow +
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
 				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
 		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
 		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index ed639437ae6b..3965a7f1b64b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2853,7 +2853,7 @@ struct pipe_ctx *dcn32_acquire_free_pipe_as_secondary_opp_head(
 		free_pipe->plane_res.xfm = pool->transforms[free_pipe_idx];
 		free_pipe->plane_res.dpp = pool->dpps[free_pipe_idx];
 		free_pipe->plane_res.mpcc_inst = pool->dpps[free_pipe_idx]->inst;
-		free_pipe->hblank_borrow = otg_master->hblank_borrow;
+		free_pipe->dsc_padding_params = otg_master->dsc_padding_params;
 		if (free_pipe->stream->timing.flags.DSC == 1) {
 			dcn20_acquire_dsc(free_pipe->stream->ctx->dc,
 					&new_ctx->res_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index d498c0983d74..1d18807e4749 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1699,6 +1699,9 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 
 	pixel_clk_params->requested_pix_clk_100hz = stream->timing.pix_clk_100hz;
 
+	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
+		pixel_clk_params->requested_pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+
 	if (!pipe_ctx->stream->ctx->dc->config.unify_link_enc_assignment)
 		link_enc = link_enc_cfg_get_link_enc(link);
 	if (link_enc)
-- 
2.43.0


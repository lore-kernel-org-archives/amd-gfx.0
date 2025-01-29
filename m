Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FA1C0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E852A10E33C;
	Wed, 29 Jan 2025 02:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pJ5EpfkH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D1410E33C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:45:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5Lqq31xf+j+8AFq4CK4S7EylwvoF+N7tNZjJcI2JN4w+DqFFPLxj5zGe1nLLIiRCkjcdFxOeGKZhbQUU2Fz1IXaL8IWAR4sYR5dopPW6z8piCZ8fXzYlBkuEqZkrPf/s2Bg7kBRBs0J9X7b/ScZC3X8zUYt02tMk+76+l2MX+EfijZEHf856f8JYo1ZGQMYQO9mqT0RwvrqyxeBH4FNbi3BOKQEi5nbezcf8f0bdCqTLt4hV4PUQXCar2bc333rHV8zS3lfXRmOLSJ4q5I5MZSGzpP+aF/TbXAR1RhBG1TUVnPLYhtySJoiiyK7GOskOiJODdZSQlclsy5dRzB5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfei51CNBTr2E6o5bKm1DInDaTzDMBb2KcZnyg+Hcio=;
 b=JUDeoFQjBFLA7BlHsSZ4+Ff9r5EaKzdQmtU/Jb4EcQz/cjj2miJxmaozd2+6vyAGf4QlUDu/0kq79qu+6KMkN6/P3lZ5/+Mq0p+XnLa0SsdkbS8oxRYeVKAWY/FwfRZfB/NNYUPP1Ut4OlVDg0NHRtw+bA5kbGWGWIWR02oCdg+Y+A/1cVy437fZ7o+DpcAzOmYPL18VDEX9FQakTsgnto+CEuKLdj9CVUYOsB3wF2ZYLl9nHCjYCsCVqhRoFF49A8u9t4gPXM9BjrQBmiHZi2h4Y6w6g2JsgOJNCJdRODZHcRsPlvJC+7pCtAwr1tiYp/g4udYNetSyz602tN6RNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfei51CNBTr2E6o5bKm1DInDaTzDMBb2KcZnyg+Hcio=;
 b=pJ5EpfkHJyM5uubDr0Np/jAajDpF1ex+lnK0WOB8CSOKTth4lSlTFeqmyIOXomWpb6rlhmxDBwxuUDNAci+1sqYa4HZXhZTvPYMPzdtCIBeAOXCBemByo80THPr8uUtMxIBiPg2AIbMt9YLFwS4HQ1/Vr/sSlnqVIiMP3o2Wjsk=
Received: from BN7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:20::21)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 02:45:15 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:20:cafe::8d) by BN7PR02CA0008.outlook.office365.com
 (2603:10b6:408:20::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 02:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:45:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:45:12 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, "Alex
 Hung" <alex.hung@amd.com>
Subject: [PATCH 01/10] drm/amd/display: Fixes for mcache programming in DML21
Date: Tue, 28 Jan 2025 19:41:37 -0700
Message-ID: <20250129024432.2107937-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129024432.2107937-1-alex.hung@amd.com>
References: <20250129024432.2107937-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e7afe3-d8ed-4da5-e03f-08dd400ef592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q4dTfD8PikE6D96ZWG0DAPQ50fswsg2CjWJhf5IghPaQq3wluERf6fte+VTN?=
 =?us-ascii?Q?Hz/NkVGslPu59x/txypZVophlDBIz8N2o7QH8QjsI6MUEyQwX4G0744a1Wg0?=
 =?us-ascii?Q?g/G/a9yhELrksdF0N8jCyEy7pVu6LxGLuAR73dJ4nRM/PIEOyfjlLVsiE0tQ?=
 =?us-ascii?Q?iMHMUsqXQi1k1jznU2ZZw0y4UPQV/o2QVWgHi9QtaTiMEC4FZEE4DkFCv3s+?=
 =?us-ascii?Q?ySjlfQNRhqJNXAwXfOPiiMDBF/gQzgtuqJlDLI4Bh5j0ItfLLIhzrWuLuhFf?=
 =?us-ascii?Q?JDxUX5F4l2yGSwacwl2KzGObujBWAdHy8zEr0b9Sbd0KYVVr1TPx4759iZ6i?=
 =?us-ascii?Q?WBdtQrn2SNMHnx3w+0O9JXPXHEBfXHLoNWQX0IZ1W0Dl1jS9FhxJ/TL2J5pX?=
 =?us-ascii?Q?op2SUIbqhuM29AaLmOjzPsIAEpOToEiIEAvCjighRUqlqKmGAJLdJOCszDje?=
 =?us-ascii?Q?WONIWF+ixdzt0ojyaTzAKaaqMUiMEKdVYoBuT9Yy51J57bni2hhI+NykihR4?=
 =?us-ascii?Q?TR/9xZPnqjqBkdMI5T9hvLC9WZFk5OwSi6TlVs0yN+8apJD42WOiqV3uqKw5?=
 =?us-ascii?Q?spYgCLWj3jv9ki68JLZVKwiP4lkNIbFaN8Qz2TPWgYkDo54XMXFSpe5G5/ui?=
 =?us-ascii?Q?Qi8xMmizjNmP3pvSwi8leedkBkyviaoUKXX4z1hnxlMzIVGSK5QYTBBrzxBS?=
 =?us-ascii?Q?pTziHz2/7WEwBx5FFn36TwDTrRsNNTf28+Vumn/3nelPC8tza1j6p+01jsA6?=
 =?us-ascii?Q?F0vtLaLdJ+lKYBa8th6/YZNoTi6BwhT/biuHX5O4z99EV3QLkH+Jh0nd1ZbG?=
 =?us-ascii?Q?mEkeT37FoLW0+BFakT6k1UctpE2SC+fP+uc1dPipC2ZC90SBsLHZUBT+RxJa?=
 =?us-ascii?Q?W2ekpHrBTwqF1twoogFh9VQnoCM6O8Zfkcjj8tvpi2EycEAyAe/kiNDpXQo7?=
 =?us-ascii?Q?4QH5vzOH2E8YSYV4UEA032aO64yK/OT+fEnwXIV/dQHUoFW3ZWL7URpRpxl2?=
 =?us-ascii?Q?dVFC/Yu3y+AoR7HCqNQNYj+p21SBmgjKMGn6k4GN7PDCezHDP8ejL2XBfYmW?=
 =?us-ascii?Q?sVwTzWCG1ze6MqorMgwEhJXG8BqYCs8Dobhwcv0/RPFCxQCMs/m/ZqLmJaFL?=
 =?us-ascii?Q?p78KKVvNzdzwh3v2djVjwMbCkEYEsqWNQ7955GRRtuI97jrC2S9/WPwL2aUA?=
 =?us-ascii?Q?ZUXK9xpPTQcjud7gZfO9bUm2/HQc0vMIdI32CXmN9jPBNvt+O6GAUxJLRpX/?=
 =?us-ascii?Q?CaCO9a+klXiZ4Nh0XbR+oVL4ENX2hLDSaZFLrGxBkmPQesc0a/K05HDwnu/B?=
 =?us-ascii?Q?2ChW6A+SrB4idT9cP8s2OA9Vkt0aqxMj0+EkhfqOF2VHeFz7VRMTd4co9sXz?=
 =?us-ascii?Q?8OxXrU60ztPJWrIsQZT2FBSC0hrT3dGFqyEwsLm11ef8yLgpaey9WeheY1M8?=
 =?us-ascii?Q?APzPBAK4vXoK0GxmwARyjgTE29W5sGjub10hdSuqe0MdeNpdTLk3ofxTholA?=
 =?us-ascii?Q?vaeykIhz7IAGdYk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:45:14.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e7afe3-d8ed-4da5-e03f-08dd400ef592
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY & HOW]
- Fix indexing phantom planes for mcache programming in the wrapper
- Fix phantom mcache allocations to align with HW guidance
- Fix mcache assignment for chroma plane for multi-planar formats

Reviewed-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  1 -
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c | 14 +++++++++
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  1 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c | 30 ++++++++++++++++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  3 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 21 +++++++++++++
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  |  8 -----
 7 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 1e56d995cd0e..930e86cdb88a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -232,7 +232,6 @@ void dml21_program_dc_pipe(struct dml2_context *dml_ctx, struct dc_state *contex
 		context->bw_ctx.bw.dcn.clk.dppclk_khz = pipe_ctx->plane_res.bw.dppclk_khz;
 
 	dml21_populate_mall_allocation_size(context, dml_ctx, pln_prog, pipe_ctx);
-	memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[pipe_ctx->pipe_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
 
 	bool sub_vp_enabled = is_sub_vp_enabled(pipe_ctx->stream->ctx->dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index fb80ba9287b6..be54f0e696ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -124,6 +124,7 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 	struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__] = {0};
 	int num_pipes;
+	unsigned int dml_phantom_prog_idx;
 
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 
@@ -137,6 +138,9 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 	context->bw_ctx.bw.dcn.mall_ss_psr_active_size_bytes = 0;
 	context->bw_ctx.bw.dcn.mall_subvp_size_bytes = 0;
 
+	/* phantom's start after main planes */
+	dml_phantom_prog_idx = in_ctx->v21.mode_programming.programming->display_config.num_planes;
+
 	for (dml_prog_idx = 0; dml_prog_idx < DML2_MAX_PLANES; dml_prog_idx++) {
 		pln_prog = &in_ctx->v21.mode_programming.programming->plane_programming[dml_prog_idx];
 
@@ -162,6 +166,16 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 				dml21_program_dc_pipe(in_ctx, context, dc_phantom_pipes[dc_pipe_index], pln_prog, stream_prog);
 			}
 		}
+
+		/* copy per plane mcache allocation */
+		memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_prog_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
+		if (pln_prog->phantom_plane.valid) {
+			memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[dml_phantom_prog_idx],
+					&pln_prog->phantom_plane.mcache_allocation,
+					sizeof(struct dml2_mcache_surface_allocation));
+
+			dml_phantom_prog_idx++;
+		}
 	}
 
 	/* assign global clocks */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index d2d053f2354d..0ab19cf4d242 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -245,6 +245,7 @@ struct dml2_per_plane_programming {
 	struct {
 		bool valid;
 		struct dml2_plane_parameters descriptor;
+		struct dml2_mcache_surface_allocation mcache_allocation;
 		struct dml2_dchub_per_pipe_register_set *pipe_regs[DML2_MAX_PLANES];
 	} phantom_plane;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index d68b4567e218..ec0beb139200 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -254,7 +254,8 @@ static void expand_implict_subvp(const struct display_configuation_with_meta *di
 static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_instance *core, const struct display_configuation_with_meta *display_cfg,
 	const struct dml2_display_cfg *svp_expanded_display_cfg, struct dml2_display_cfg_programming *programming, struct dml2_core_scratch *scratch)
 {
-	unsigned int stream_index, plane_index, pipe_offset, stream_already_populated_mask, main_plane_index;
+	unsigned int stream_index, plane_index, pipe_offset, stream_already_populated_mask, main_plane_index, mcache_index;
+	unsigned int total_main_mcaches_required = 0;
 	int total_pipe_regs_copied = 0;
 	int dml_internal_pipe_index = 0;
 	const struct dml2_plane_parameters *main_plane;
@@ -325,6 +326,13 @@ static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_in
 
 		dml2_core_calcs_get_mall_allocation(&core->clean_me_up.mode_lib, &programming->plane_programming[plane_index].surface_size_mall_bytes, dml_internal_pipe_index);
 
+		memcpy(&programming->plane_programming[plane_index].mcache_allocation,
+				&display_cfg->stage2.mcache_allocations[plane_index],
+				sizeof(struct dml2_mcache_surface_allocation));
+		total_main_mcaches_required += programming->plane_programming[plane_index].mcache_allocation.num_mcaches_plane0 +
+				programming->plane_programming[plane_index].mcache_allocation.num_mcaches_plane1 -
+				(programming->plane_programming[plane_index].mcache_allocation.last_slice_sharing.plane0_plane1 ? 1 : 0);
+
 		for (pipe_offset = 0; pipe_offset < programming->plane_programming[plane_index].num_dpps_required; pipe_offset++) {
 			// Assign storage for this pipe's register values
 			programming->plane_programming[plane_index].pipe_regs[pipe_offset] = &programming->pipe_regs[total_pipe_regs_copied];
@@ -363,6 +371,22 @@ static void pack_mode_programming_params_with_implicit_subvp(struct dml2_core_in
 		memcpy(&programming->plane_programming[main_plane_index].phantom_plane.descriptor, phantom_plane, sizeof(struct dml2_plane_parameters));
 
 		dml2_core_calcs_get_mall_allocation(&core->clean_me_up.mode_lib, &programming->plane_programming[main_plane_index].svp_size_mall_bytes, dml_internal_pipe_index);
+
+		/* generate mcache allocation, phantoms use identical mcache configuration, but in the MALL set and unique mcache ID's beginning after all main ID's */
+		memcpy(&programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation,
+				&programming->plane_programming[main_plane_index].mcache_allocation,
+				sizeof(struct dml2_mcache_surface_allocation));
+		for (mcache_index = 0; mcache_index < programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.num_mcaches_plane0; mcache_index++) {
+			programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.global_mcache_ids_plane0[mcache_index] += total_main_mcaches_required;
+			programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.global_mcache_ids_mall_plane0[mcache_index] =
+					programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.global_mcache_ids_plane0[mcache_index];
+		}
+		for (mcache_index = 0; mcache_index < programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.num_mcaches_plane1; mcache_index++) {
+			programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.global_mcache_ids_plane1[mcache_index] += total_main_mcaches_required;
+			programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.global_mcache_ids_mall_plane1[mcache_index] =
+					programming->plane_programming[main_plane_index].phantom_plane.mcache_allocation.global_mcache_ids_plane1[mcache_index];
+		}
+
 		for (pipe_offset = 0; pipe_offset < programming->plane_programming[main_plane_index].num_dpps_required; pipe_offset++) {
 			// Assign storage for this pipe's register values
 			programming->plane_programming[main_plane_index].phantom_plane.pipe_regs[pipe_offset] = &programming->pipe_regs[total_pipe_regs_copied];
@@ -572,6 +596,10 @@ bool core_dcn4_mode_programming(struct dml2_core_mode_programming_in_out *in_out
 
 				dml2_core_calcs_get_mall_allocation(&core->clean_me_up.mode_lib, &in_out->programming->plane_programming[plane_index].surface_size_mall_bytes, dml_internal_pipe_index);
 
+				memcpy(&in_out->programming->plane_programming[plane_index].mcache_allocation,
+						&in_out->display_cfg->stage2.mcache_allocations[plane_index],
+						sizeof(struct dml2_mcache_surface_allocation));
+
 				for (pipe_offset = 0; pipe_offset < in_out->programming->plane_programming[plane_index].num_dpps_required; pipe_offset++) {
 					in_out->programming->plane_programming[plane_index].plane_descriptor = &in_out->programming->display_config.plane_descriptors[plane_index];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index e96a13dc43d4..47872c6f657e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2637,6 +2637,9 @@ static void calculate_mcache_setting(
 	// Luma/Chroma combine in the last mcache
 	// In the case of Luma/Chroma combine-mCache (with lc_comb_mcache==1), all mCaches except the last segment are filled as much as possible, when stay aligned to mvmpg boundary
 	if (*p->lc_comb_mcache && l->is_dual_plane) {
+		/* if luma and chroma planes share an mcache, increase total chroma mcache count */
+		*p->num_mcaches_c = *p->num_mcaches_c + 1;
+
 		for (n = 0; n < *p->num_mcaches_l - 1; n++)
 			p->mcache_offsets_l[n] = (n + 1) * l->mvmpg_per_mcache_lb_l * l->mvmpg_access_width_l;
 		p->mcache_offsets_l[*p->num_mcaches_l - 1] = l->full_vp_access_width_l;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index a3324f7b9ba6..15c906c42ec4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1082,12 +1082,21 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 	const struct dml2_fams2_meta *stream_fams2_meta;
 	unsigned int microschedule_vlines;
 	unsigned int i;
+	unsigned int mcaches_per_plane;
+	unsigned int total_mcaches_required = 0;
 
 	unsigned int num_planes_per_stream[DML2_MAX_PLANES] = { 0 };
 
 	/* confirm timing it is not a centered timing */
 	for (i = 0; i < display_config->display_config.num_planes; i++) {
 		plane_descriptor = &display_config->display_config.plane_descriptors[i];
+		mcaches_per_plane = 0;
+
+		if (plane_descriptor->surface.dcc.enable) {
+			mcaches_per_plane += display_config->stage2.mcache_allocations[i].num_mcaches_plane0 +
+					display_config->stage2.mcache_allocations[i].num_mcaches_plane1 -
+					(display_config->stage2.mcache_allocations[i].last_slice_sharing.plane0_plane1 ? 1 : 0);
+		}
 
 		if (is_bit_set_in_bitfield(mask, (unsigned char)plane_descriptor->stream_index)) {
 			num_planes_per_stream[plane_descriptor->stream_index]++;
@@ -1098,7 +1107,19 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 					plane_descriptor->composition.rotation_angle != dml2_rotation_0) {
 				return false;
 			}
+
+			/* phantom requires same number of mcaches as main */
+			if (plane_descriptor->surface.dcc.enable) {
+				mcaches_per_plane *= 2;
+			}
 		}
+
+		total_mcaches_required += mcaches_per_plane;
+	}
+
+	if (total_mcaches_required > pmo->soc_bb->num_dcc_mcaches) {
+		/* too many mcaches required */
+		return false;
 	}
 
 	for (i = 0; i < DML2_MAX_PLANES; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
index a8f58f8448e4..dc2ce5e77f57 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
@@ -831,7 +831,6 @@ static bool dml2_top_soc15_build_mode_programming(struct dml2_build_mode_program
 	bool uclk_pstate_success = false;
 	bool vmin_success = false;
 	bool stutter_success = false;
-	unsigned int i;
 
 	memset(l, 0, sizeof(struct dml2_build_mode_programming_locals));
 	memset(in_out->programming, 0, sizeof(struct dml2_display_cfg_programming));
@@ -976,13 +975,6 @@ static bool dml2_top_soc15_build_mode_programming(struct dml2_build_mode_program
 		l->base_display_config_with_meta.stage5.success = true;
 	}
 
-	/*
-	* Populate mcache programming
-	*/
-	for (i = 0; i < in_out->display_config->num_planes; i++) {
-		in_out->programming->plane_programming[i].mcache_allocation = l->base_display_config_with_meta.stage2.mcache_allocations[i];
-	}
-
 	/*
 	* Call DPMM to map all requirements to minimum clock state
 	*/
-- 
2.43.0


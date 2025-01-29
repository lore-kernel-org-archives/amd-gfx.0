Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A2CC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E6B010E400;
	Wed, 29 Jan 2025 02:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FAKgfqVS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9863E10E400
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MctGtFoZp/95vSyl/sdnqpEJEyQi3y/BCYeojh7tTYrA71agaD2nL8x5XujwBD4WUzEtlM5FNpmIa4MxoQLtHkzDTP4BJyPFB3YXh+BMiWpjfJENB683yGfPwaT85IhyzPjBse3L5mNDT5LL6mkehiLyDUjyU/4VfQ0LSmLkpC8APT6roMqq8cyQU/6zJdunfyVmeWWLHHXq4YSJ9/fFEQiFm5QSR2msa7lz2IdS8pANgRa9tUFIPl0MqST8pU5piW4oFfPhtWOkdUdEUoun4RfW864ImFbuvMkQXuSFoaCvTXnaXkMKFu+sbhm7Jj+F/U1zCbgCymqzx6K6+ePEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfei51CNBTr2E6o5bKm1DInDaTzDMBb2KcZnyg+Hcio=;
 b=H2B6/ZLWK9G4ZmgloJLCtJHrc6attigHQQchaqLNXt2XDt18TPXpAKmBbAMNLgakJV7HAoQ6WWtfsSR+oL4xrzjNUzboo6wK+kZoQ+9429D8gT7DlziZP4MFF9AE50BVmfSNukcWc2tCDYl/vbShjG828oVSkRhWvmLVEJpVFnZDuTQLb+ZmJNPA2H4p+WRJMune7QVYqXKUwLaGILyB84MQwiGKcXyZ3igEoPL9RMJuD1QTOkaU00jrahJIBI0uu8wFrpv7ZeN7rCoH/ZvGUkMl9DXFlO+rvGh40fSQbFDHH8fQ8BzEVI27jgN+IYAZVfnIHixJ5GDuWywtYCKyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfei51CNBTr2E6o5bKm1DInDaTzDMBb2KcZnyg+Hcio=;
 b=FAKgfqVSFsfzpfJyKS8cQwmQJJUyWA8/y084XfuAixVL4Jy3cMYbw9qoGjYzWDkLIwSXPOnArdnc99u4H9ZpIahkEGAqCFOGw+8wy7WyrRjsyM6w8VH0C1CD2r07baga4/HMr6fkljNE0CtWom0za2VCM56j7+XqdJexnQmuyQk=
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 02:55:50 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::a7) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 02:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:55:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:55:44 -0600
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
Date: Tue, 28 Jan 2025 19:53:45 -0700
Message-ID: <20250129025458.2120268-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129025458.2120268-1-alex.hung@amd.com>
References: <20250129025458.2120268-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca05bb8-a019-48e0-c27f-08dd40107012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ckgFx/YT/2lt6BW3xzIaV7okm0GJXCmWTglAUcba+XfOTNsjvebsQ7XvICmQ?=
 =?us-ascii?Q?LyQcXC9h9xN6EK7W/3If1gkj2YkzkCrSnVzBVKmQipJnC/SbWNTlNJRK26eh?=
 =?us-ascii?Q?H2f4ksIk2zUX1uBJVAK4Zyn40/4+P0A0x9eG+VPZR7N0W2IXchMToLHy4xX2?=
 =?us-ascii?Q?VUK+0Uo+gCsjq5ey/UsVn31LmdQqUwugWaXuVwBwdUNmtMAH9BHMyh+7Cq9C?=
 =?us-ascii?Q?RHxP0Obyp7FN0pQ4uDIa8KldC+Usx8QN4ohXKt0KITBH61i4v8LI2YSwXC7v?=
 =?us-ascii?Q?R/WRkkITLQjppLGlmeVogDgLxqo9Zqn1SNuAzFDC/OR8RAw24zwLKd0AqrM5?=
 =?us-ascii?Q?efxCo8+KccfSQEmF/+mtcIBXMcafFdmHOlob8EUCj72bLJUIYAlh1OdKf7/n?=
 =?us-ascii?Q?ZF3Zuw7g+uNYV3T/EsM7kYNdd4Ejis+uCsPC/vHq78Gz03jNyciQSnI/A2x1?=
 =?us-ascii?Q?L4Cb0AJcdvO8nJg53ew79rzwb9aVoAEzgfFlGHiW58rVR8gaYR4T+05B1JCF?=
 =?us-ascii?Q?BD6PULEp8WZVQuuHsJy37K5TaQUdtbCZf0FGGKBi8uRk+WT55ZtC08JLXRsn?=
 =?us-ascii?Q?3HAWYijR+AiDB2w+kJGrtuiG1q8yPcGPBf2iPMzz59vjxDKFn+bIAFTocwJ9?=
 =?us-ascii?Q?xWK2T8WIDY7VDE/4pxXyrRPP2J3SHw5HG5HFzbbjluRBmkLPc8k3VxQUmydK?=
 =?us-ascii?Q?OWhuPVnBAdnl2sknysT35y/rMC3+8GDbZlBIqPXkH/y+6vZphzpzm4nSq1Wz?=
 =?us-ascii?Q?H1bUcpuJnhOXWOEU3Zgzx9Q3/3qAW1FKEs6oDyYicjO7gjUCGTXuz+YQz+3O?=
 =?us-ascii?Q?ZOUcNtul8JwYHQdg8db8BP62XuZ3VWQ447a9IQR56vtks//2vmp3KxPd5+C+?=
 =?us-ascii?Q?rq6EqETA/M7TxicVut0Vq+99WkfnnZ4qf6nC1p8Le0wewuTP7+7FQz2WW+J0?=
 =?us-ascii?Q?bBO4T43XBtlTvzVJN1QiCP68aZLHpeZGAtgoD5BVXDT0vW8w31uQjy1/f89N?=
 =?us-ascii?Q?TVra4VwEnk15iC4+GhxRmrtWuLrkZHBsDCvqAkuhY6Bl6iw59XpHL/S59iAM?=
 =?us-ascii?Q?lSo41+7sXmEZXnDyhICodulRuxDIrnnoY9+u3dWno3TCjg9kA5QbGXu8jEo9?=
 =?us-ascii?Q?oLALfI5R4b4PblUU8oBS2hehAbhsAlrQl5ShJSEwNVaZVklXEmTz9qjbuw7b?=
 =?us-ascii?Q?JKX6x+TOR9zT7f6KXbaYwtURHRI42OV6sdDtuyyELGDAZGMf/VzIZZxdlLV2?=
 =?us-ascii?Q?B7RCWBtb0JlLuLNAzdgyra3kkLuvhwFaeRWPbSZA4ibtfIeMbNk4i6lUqtXF?=
 =?us-ascii?Q?tSPZfmK1t/WOsJXpDJeAN93hV0M+PRdktLbUfINOBhefGrn6SR9A+Ce/xdaV?=
 =?us-ascii?Q?w8Zja5aL0OyktHc+xkaU5yV4K0L9KKgRKmMp7ov8K1o0LzY7YJv2Jw5mgXQS?=
 =?us-ascii?Q?WuUAopGGEY8snvOoRvhyZdt7ooUYC6DJCgiRBfztddgxbN3NaIQ/k0Ik9IFm?=
 =?us-ascii?Q?j1THgSLRcDo+yo0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:55:49.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca05bb8-a019-48e0-c27f-08dd40107012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820
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


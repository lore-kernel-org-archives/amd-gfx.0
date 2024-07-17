Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A793C3DA64
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC7D10E3AC;
	Wed, 17 Jul 2024 19:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W4UBjtiW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2EB410E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwLK0x0b+MSpjFrXnoUMFXfpr/6SgZ/LHo4+Gh35wH3Nw2knSZOwRDjNhCaK0MYO0yCkBsmA3IwvFwARErMaDYwjv6SVTNbjILVnMo2nkMFMEY5G95JG4wVX333XSB7SlfnH+1U2kB3ayvOsPTA+KgNYDLqHsyEcTTLlNlL2JRuQ/74gB57+uI2z8WPDzkFNd8w1JS3QpNlMLdTShEZgF2jtAYOXgnCwnwG3aTMQQtdBwBxLR3kL4j687z9B1bznrJIgRr/6Mj7aEjQf5Vs+pKZIuHo7hAWVQLlMghhFrxMMK55qFfEVZvdOQ3LqWqS7Msz+pzha/KD+N7fGFWqesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqPb8k1daSYvAYI4X+SeQiN8sMBoh1oBhMzoE+sGMpU=;
 b=j6uvGDT4/bcSDdA+cgPAIZaLoucl/5JC1SZ2GIsKNuZ48AC4HMX5k0aI1TI6RErM0X75Q2hy9lKR15nHAH4q5K6UPZi/YXtOo9NcNIVZnDaq9QM5Lr57QvVp7TgAl5+I4nvCnlriKYlLfqbn49ySJEjHk/gt/GGbdUH3mNhyPQJiMXvFt+ZFqt6nbAYPNS1IbQykY/2tZevlGItSXutFCVWZwm2HQ/kCfujswafYl/yrF/1j3Hdni3xl73aKfjdltic7z1otfTBDz51hu7lqPKj7riB5uBHDA4m41tPcgsV2VItdOYorl2vP/RYWLQkX3yIBPIND+DVggOMKo/eY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqPb8k1daSYvAYI4X+SeQiN8sMBoh1oBhMzoE+sGMpU=;
 b=W4UBjtiW9CSoY7AF1sKu3ir4CO/QD5f1IV8bfeTnTnthB/YZaNB+iRGMJ5MzOhRX/arUpPzxrnLr/LHAlryug/VPyggl99YCmuiZgmWmp3TJdlmHIbXQ/0Ft3LC0BMDy5C0Cbh8aWvCgncusPuNRJElZR9P5YL1DOAF4New+Fu8=
Received: from BYAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:a02:a8::46)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:39:56 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::69) by BYAPR03CA0033.outlook.office365.com
 (2603:10b6:a02:a8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Wed, 17 Jul 2024 19:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:39:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:39:53 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:39:47 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Ryan Seto <ryanseto@amd.com>,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 07/22] drm/amd/display: Fix visual confirm bug for SubVP
Date: Wed, 17 Jul 2024 19:38:46 +0000
Message-ID: <20240717193901.8821-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: a63e7bba-5391-4aa8-45af-08dca6983c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8SazaHvYX+gY99IR1gPMoz2vblKHqRVbUfjdeXyXLc5HjEj9bjDXreRwMsJO?=
 =?us-ascii?Q?nzVeTrq+QlP3isMnrzgCebN/dJ5xJFrHG9O+16Tr1xMxR+x7nTQuTTk4WXVX?=
 =?us-ascii?Q?YPqR38N2uX1JDFgm4xO+fdugF/617e925bkCb+zjqRIEjZJnDZG8/dQ8Mu/0?=
 =?us-ascii?Q?wWib4OtcHodiw21xlB1EylDzEP738iq0dHC2kVTX4y+18PUST7ePAStURrui?=
 =?us-ascii?Q?eDgn985VV4sZrvqSp5DQ3JbvonvQRzdd+GLUUx3WFAfdDScFrNQnOEqlMgtd?=
 =?us-ascii?Q?cjMW5tb/ksN6cWnpIz08i8u3yfQsuvzDuigA9c2pXt564WaP05QUNW6rjUSr?=
 =?us-ascii?Q?l/XrQIGJ78RIpxlnxuZF1JSSEx6sgnKGN/mKWcQFPVwdIK7QpM2OYwOLWZtw?=
 =?us-ascii?Q?yz8awOdBDnbnb0MTOBsEYFD00ODmKJc32qis+p0S9JxBMWtvz3nUc220DE6o?=
 =?us-ascii?Q?DK/0J3PXsC+93f2rpL/N51r8ib88qsVCQBQdWqqn97MuDCRcUui0sTJx8mGW?=
 =?us-ascii?Q?v07dYLsi1C9eW5T7oX/pjsr7HXlCa4TFtUEPo110qF8lbTItAkn1mAaot/bb?=
 =?us-ascii?Q?2EsURJ+IH2Yjz1Az2pDhm3gPQu+Nq7qg5LWxJJhhXuJxv7iG53DailfMthH6?=
 =?us-ascii?Q?otulH+RrkOnu5vLAd76hdaljeAheBN0P8/ggah0XSnJYVlljcjGJ4cDoL0xK?=
 =?us-ascii?Q?yL9/m0lSXMPNZTSSvascStKqR+ixB63R/wm4YelACcI2qJ9GJ0lWocfDZUNo?=
 =?us-ascii?Q?TmdHWEZ7M9x0BV/fRWBxFrawAMezBFwwuE9Vis4K1TcC8nh+zZgjupXzCiZR?=
 =?us-ascii?Q?ARua6SPC2HbbD12Vfdvj8QqSbANa795JjrMJQibu6sxqXcV83+8Mzrdh1geD?=
 =?us-ascii?Q?q0I4BuJzBJjXRdd9q2CTonvvJX6BboViu2I3SccME68yTu/fu3yFGGNJG+Hv?=
 =?us-ascii?Q?aVtKeZtef9+4xQZX+nue0ILTwnuFaNCd8Pby6ptTnUGTsnd9jfnxmn2U2HRd?=
 =?us-ascii?Q?CJKbo8XkEZrbCqYLJiR+cEl/Sj0331JHCxg0EFpcl819yxodgEfhhhCFfEsC?=
 =?us-ascii?Q?WKAkDgBP63Zf23Qho81mucZZcvwTugVEnETPE9+U0FoAlHptSaVhA6en94tn?=
 =?us-ascii?Q?6TmQlHIqnOG6H7R0u+Lqglu4UXsBQUflySk4B0PL7KKdVOnAkjLGNW7+NAz3?=
 =?us-ascii?Q?nOfKfT0OCu6YAMzfWzGMq2mGO0igQq0uAqJOlOSUwWmM5L/hzc/Y8GJZlH4N?=
 =?us-ascii?Q?/OyKbgO59aeKXsIw3hCNmS1dIQ5ZTJ++gmUYJNJKiMX74VHZO2rA3hTRi4Je?=
 =?us-ascii?Q?QlCIe6PnPzSIDFc4N5VqXhdCEq5ShcXN1BtVu10R4PKsEVG84HXfz7USVd95?=
 =?us-ascii?Q?28J7shNCI9kXqUk6UXtbqAGj1DROTHXbYcTiAu0aI0O6yKxjW25q2eFLXKnJ?=
 =?us-ascii?Q?sfc9BoujyvkMeZParcjBLV0IyUU59pGA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:39:55.8030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a63e7bba-5391-4aa8-45af-08dca6983c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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

From: Ryan Seto <ryanseto@amd.com>

[Why]
Visual confirm was incorrect on dual monitor SubVP setup

[How]
Adjusted p_state assignment for dual monitor SubVP setup

Signed-off-by: Ryan Seto <ryanseto@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dc/dml2/dml21/dml21_translation_helper.c  | 13 ++++++++---
 .../dc/dml2/dml21/dml21_translation_helper.h  |  2 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   | 22 +++++++++++++++++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 1fce61323201..9fdb209bcab2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1183,7 +1183,8 @@ void dml21_get_pipe_mcache_config(
 
 void dml21_set_dc_p_state_type(
 		struct pipe_ctx *pipe_ctx,
-		struct dml2_per_stream_programming *stream_programming)
+		struct dml2_per_stream_programming *stream_programming,
+		bool sub_vp_enabled)
 {
 	switch (stream_programming->uclk_pstate_method) {
 	case dml2_uclk_pstate_support_method_vactive:
@@ -1192,14 +1193,20 @@ void dml21_set_dc_p_state_type(
 		break;
 	case dml2_uclk_pstate_support_method_vblank:
 	case dml2_uclk_pstate_support_method_fw_vblank_drr:
-		pipe_ctx->p_state_type = P_STATE_V_BLANK;
+		if (sub_vp_enabled)
+			pipe_ctx->p_state_type = P_STATE_V_BLANK_SUB_VP;
+		else
+			pipe_ctx->p_state_type = P_STATE_V_BLANK;
 		break;
 	case dml2_uclk_pstate_support_method_fw_subvp_phantom:
 	case dml2_uclk_pstate_support_method_fw_subvp_phantom_drr:
 		pipe_ctx->p_state_type = P_STATE_SUB_VP;
 		break;
 	case dml2_uclk_pstate_support_method_fw_drr:
-		pipe_ctx->p_state_type = P_STATE_FPO;
+		if (sub_vp_enabled)
+			pipe_ctx->p_state_type = P_STATE_DRR_SUB_VP;
+		else
+			pipe_ctx->p_state_type = P_STATE_FPO;
 		break;
 	default:
 		pipe_ctx->p_state_type = P_STATE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
index 97a8f51b7780..476a7f6e4875 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.h
@@ -26,5 +26,5 @@ void dml21_extract_legacy_watermark_set(const struct dc *in_dc, struct dcn_water
 void dml21_extract_watermark_sets(const struct dc *in_dc, union dcn_watermark_set *watermarks, struct dml2_context *in_ctx);
 void dml21_map_hw_resources(struct dml2_context *dml_ctx);
 void dml21_get_pipe_mcache_config(struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog, struct dml2_pipe_configuration_descriptor *mcache_pipe_config);
-void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming);
+void dml21_set_dc_p_state_type(struct pipe_ctx *pipe_ctx, struct dml2_per_stream_programming *stream_programming, bool sub_vp_enabled);
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index e11246e525ac..ec4195336444 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -11,7 +11,6 @@
 
 #include "dml2_core_dcn4_calcs.h"
 
-
 int dml21_helper_find_dml_pipe_idx_by_stream_id(struct dml2_context *ctx, unsigned int stream_id)
 {
 	int i;
@@ -280,6 +279,23 @@ bool check_dp2p0_output_encoder(const struct pipe_ctx *pipe_ctx)
 		dc_is_dp_signal(pipe_ctx->stream->signal));
 }
 
+
+static bool is_sub_vp_enabled(struct dc *dc, struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream && dc_state_get_paired_subvp_stream(context, pipe_ctx->stream) &&
+							dc_state_get_pipe_subvp_type(context, pipe_ctx) == SUBVP_MAIN) {
+			return true;
+		}
+	}
+	return false;
+}
+
+
 void dml21_program_dc_pipe(struct dml2_context *dml_ctx, struct dc_state *context, struct pipe_ctx *pipe_ctx, struct dml2_per_plane_programming *pln_prog,
 		struct dml2_per_stream_programming *stream_prog)
 {
@@ -317,7 +333,9 @@ void dml21_program_dc_pipe(struct dml2_context *dml_ctx, struct dc_state *contex
 	dml21_populate_mall_allocation_size(context, dml_ctx, pln_prog, pipe_ctx);
 	memcpy(&context->bw_ctx.bw.dcn.mcache_allocations[pipe_ctx->pipe_idx], &pln_prog->mcache_allocation, sizeof(struct dml2_mcache_surface_allocation));
 
-	dml21_set_dc_p_state_type(pipe_ctx, stream_prog);
+	bool sub_vp_enabled = is_sub_vp_enabled(pipe_ctx->stream->ctx->dc, context);
+
+	dml21_set_dc_p_state_type(pipe_ctx, stream_prog, sub_vp_enabled);
 }
 
 static struct dc_stream_state *dml21_add_phantom_stream(struct dml2_context *dml_ctx,
-- 
2.39.2


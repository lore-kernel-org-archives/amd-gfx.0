Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BD0E936E8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEF710E3C0;
	Wed,  4 Oct 2023 21:21:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570EF10E3C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EydAGWI56HEx/lAacByvqjAjZBI73Mb5IAR+a4R37slPXmKes+WpLgUooVH0YdLN7smA3uHKD2JCCXaXj6sE2LymubvJf48YFD96fgoNrudoFOd+eya9PuBhkrKNta/sZ8s8RApDouEtj1ZRpPd45KVNTCm21dHYRgTVC2MhFqUtWFnzXfpqZYzVfoKY333ZHVtwAG60l+Yq09itrtXMxa7Uv91j/2p1ISVd4wnNF65NGd1kPRkPHK6H0Ids3O4O/+tet6hiZmQcwfA/1SExGTm/EHXhmUZYzctgV2+nP33qcHGnw/Ha2CA7oCu+nvTWOPaUXwfS0ACZlSOOMEW5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHzRojJ7eh2DMcMv+EX1wh3DEuNL1agQFa3xuORIR5Q=;
 b=es2wDMVCgQqYYE9ezbDuab521OBv2QCTLnZrTsWNfRFCNBPEkMxOv3UYDNa4mvtlwAKhvHMC8WqrC8D4sP532R6XvKie21/fI7G6+PL2BYXX/y8IRlxun8+Qw4UZwKZdXmCCdS+xQESk9RyrAKA9kQqV759d51Y0aTK98ZdqRbHcqepovkYFeUdjOZlf9vYzH1YeDDPhsUcYR/N+LEZ1Lyc7dzmx0zKqDzYW7LuFwf8gCFPsCb0iLFGjqDLM8FmCCw73yDyri8qHX79xYKS8bpJ0Tr42lii/1JVyayDpM3bUL7B6gD0j5MMVJdDg96bhx+asuyXtY2eacXloa26FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHzRojJ7eh2DMcMv+EX1wh3DEuNL1agQFa3xuORIR5Q=;
 b=b1Z1JyUXsR6wXa5ptT2AIU6NVoXVyJJ8X//S2TyrkGcW/w9HArESHexp15wDOdi37fp3R7ZegzOeo6aTm8yNHNzL5wOpox7KXv8PdibygVkWiDdc8qMrBBd7pnx+FplpzAa3HS/z80GOKkAhejEVvJLPHGSaJ7q4Exmofn+P6Wk=
Received: from MN2PR02CA0031.namprd02.prod.outlook.com (2603:10b6:208:fc::44)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Wed, 4 Oct
 2023 21:21:49 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::75) by MN2PR02CA0031.outlook.office365.com
 (2603:10b6:208:fc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 06/16] drm/amd/display: Add DCN35 DML2 support
Date: Wed, 4 Oct 2023 15:21:00 -0600
Message-ID: <20231004212110.3753955-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|BL1PR12MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2924ff57-3c7a-4e4e-0215-08dbc51febad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edRelDtEnHaOXxixEpDy9eqhCyg/szy5nutnHscexFseB3RW5JUFI93R4S8tzVUsxa4VJzForg/releBzLvBICaJ0uxzzhKeguJGNGnVpaTaX2SeDx0jLpcUHJMukP8k4PpoKB/9IrPa94XDPvdHTjntWIlbewV8FnzfIbjVjdfa8OEUz7a7oPbtiDCK28sUyYohjuGJQT7LAfBDTlVm0Wo3/A21CNJwNrQljbAwwISlqEVSTM0yWLYBvFWjZhHUUHwMGEdFIKUbvdD26cuID4KGNV19Yysyp3rS910gVwWlklmRFD0uLeREDw9EuuZ+QQLJNeyVwo2fjbhZ5q8Kum+xFDzbDf82dTFgUB3kbtqX3mJY96rgnmxrPptcRiJclbJSaQilyJXnyJsfpekStJp/0Y0Hc5sd02RlBf6J70IquStBrzuHxmkyF3zn27OwaYIiNl4WGc7t0hnIniaAvvGfrH65CrKbVmvtIqZCJ/87Ks/IWOIISeDEcenFOO1HNhXGIZO6X1pepE75Dr5N6inKvkc+oSqrs41NPb/T/biv598AxSLxCrHTToqkCyJ9agEEc2BFP75725Etp/sor4ygQr2h8DJLAJfUxCqF6OOo56m1CAMir9nF5qQ40J4rGFZcSlS7RQdgVnxn49g3PyUkvOXeZQxVU+SKTvOrYubI51VwMHC/tw5Am3n1eH900S3FskKomDzbOwkDrBQJEI0oVGjH5DT3MF4v8pcYplut8UzfrMcnk91MX/nByHMoItXjzAVCJM6MLkYZok7fyWT6ScGn7OFMmOGdeFdWCDs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(46966006)(36840700001)(41300700001)(40460700003)(2906002)(5660300002)(36756003)(86362001)(81166007)(40480700001)(4326008)(8936002)(82740400003)(8676002)(356005)(47076005)(6916009)(316002)(83380400001)(36860700001)(70586007)(70206006)(54906003)(426003)(336012)(2616005)(26005)(16526019)(1076003)(6666004)(478600001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:49.1230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2924ff57-3c7a-4e4e-0215-08dbc51febad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

Enable DML2 for DCN35.

Changes since V1:
- Remove hard coded values

Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_resource.c | 13 +--
 .../dc/dml2/display_mode_core_structs.h       |  2 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |  7 ++
 .../display/dc/dml2/dml2_translation_helper.c | 89 ++++++++++++++++++-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  6 ++
 5 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 693c7ba4b34d..2fa876d9e1f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -31,7 +31,7 @@
 #include "resource.h"
 #include "include/irq_service_interface.h"
 #include "dcn35_resource.h"
-/*#include "dml2/dml2_wrapper.h"*/
+#include "dml2/dml2_wrapper.h"
 
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
@@ -729,7 +729,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.seamless_boot_odm_combine = DML_FAIL_SOURCE_PIXEL_FORMAT,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	/* .using_dml2 = true, */
+	.using_dml2 = true,
 	.support_eDP1_5 = true,
 	.enable_hpo_pg_support = false,
 	.enable_legacy_fast_update = true,
@@ -1694,7 +1694,7 @@ static bool dcn35_validate_bandwidth(struct dc *dc,
 {
 	bool out = false;
 
-	/*out = dml2_validate(dc, context, fast_validate);*/
+	out = dml2_validate(dc, context, fast_validate);
 
 	return out;
 }
@@ -2067,18 +2067,19 @@ static bool dcn35_resource_construct(
 
 
 	dc->dcn_ip->max_num_dpp = pool->base.pipe_count;
-#if 0
+
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
 	dc->dml2_options.use_native_pstate_optimization = false;
 	dc->dml2_options.use_native_soc_bb_construction = true;
+	if (dc->config.EnableMinDispClkODM)
+		dc->dml2_options.minimize_dispclk_using_odm = true;
 
 	dc->dml2_options.callbacks.dc = dc;
 	dc->dml2_options.callbacks.build_scaling_params = &resource_build_scaling_params;
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch = &dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm;
+	dc->dml2_options.callbacks.acquire_secondary_pipe_for_mpc_odm = &dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy;
 	dc->dml2_options.max_segments_per_hubp = 18;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
-#endif
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
index d2e1510a504f..c2fa28ff57ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
@@ -32,6 +32,8 @@ enum dml_project_id {
 	dml_project_default = 1,
 	dml_project_dcn32 = dml_project_default,
 	dml_project_dcn321 = 2,
+	dml_project_dcn35 = 3,
+	dml_project_dcn351 = 4,
 };
 enum dml_prefetch_modes {
 	dml_prefetch_support_uclk_fclk_and_stutter_if_possible = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index 0c71a8aa5587..f8e9aa32ceab 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -298,4 +298,11 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	policy->SynchronizeDRRDisplaysForUCLKPStateChangeFinal = true;
 	policy->AssumeModeSupportAtMaxPwrStateEvenDRAMClockChangeNotSupported = true; // TOREVIEW: What does this mean?
 	policy->AssumeModeSupportAtMaxPwrStateEvenFClockChangeNotSupported = true; // TOREVIEW: What does this mean?
+	if (project == dml_project_dcn35 ||
+		project == dml_project_dcn351) {
+		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
+		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
+		policy->AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter_if_possible; /*new*/
+		policy->UseOnlyMaxPrefetchModes = 1;
+	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 353f22a6b7f8..de58c7b867e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -103,6 +103,76 @@ void dml2_init_ip_params(struct dml2_context *dml2, const struct dc *in_dc, stru
 		out->max_num_dp2p0_streams = 4;
 		break;
 
+	case dml_project_dcn35:
+	case dml_project_dcn351:
+		out->rob_buffer_size_kbytes = 64;
+		out->config_return_buffer_size_in_kbytes = 1792;
+		out->compressed_buffer_segment_size_in_kbytes = 64;
+		out->meta_fifo_size_in_kentries = 32;
+		out->zero_size_buffer_entries = 512;
+		out->pixel_chunk_size_kbytes = 8;
+		out->alpha_pixel_chunk_size_kbytes = 4;
+		out->min_pixel_chunk_size_bytes = 1024;
+		out->meta_chunk_size_kbytes = 2;
+		out->min_meta_chunk_size_bytes = 256;
+		out->writeback_chunk_size_kbytes = 8;
+		out->dpte_buffer_size_in_pte_reqs_luma = 68;
+		out->dpte_buffer_size_in_pte_reqs_chroma = 36;
+		out->dcc_meta_buffer_size_bytes = 6272;
+		out->gpuvm_enable = 1;
+		out->hostvm_enable = 1;
+		out->gpuvm_max_page_table_levels = 1;
+		out->hostvm_max_page_table_levels = 2;
+		out->num_dsc = 4;
+		out->maximum_dsc_bits_per_component = 12;
+		out->maximum_pixels_per_line_per_dsc_unit = 6016;
+		out->dsc422_native_support = 1;
+		out->line_buffer_size_bits = 986880;
+		out->dcc_supported = 1;
+		out->max_line_buffer_lines = 32;
+		out->writeback_interface_buffer_size_kbytes = 90;
+		out->max_num_dpp = 4;
+		out->max_num_otg = 4;
+		out->max_num_hdmi_frl_outputs = 1;
+		out->max_num_dp2p0_outputs = 2;
+		out->max_num_dp2p0_streams = 4;
+		out->max_num_wb = 1;
+
+		out->max_dchub_pscl_bw_pix_per_clk = 4;
+		out->max_pscl_lb_bw_pix_per_clk = 2;
+		out->max_lb_vscl_bw_pix_per_clk = 4;
+		out->max_vscl_hscl_bw_pix_per_clk = 4;
+		out->max_hscl_ratio = 6;
+		out->max_vscl_ratio = 6;
+		out->max_hscl_taps = 8;
+		out->max_vscl_taps = 8;
+		out->dispclk_ramp_margin_percent = 1.11;
+
+		out->dppclk_delay_subtotal = 47;
+		out->dppclk_delay_scl = 50;
+		out->dppclk_delay_scl_lb_only = 16;
+		out->dppclk_delay_cnvc_formatter = 28;
+		out->dppclk_delay_cnvc_cursor = 6;
+		out->dispclk_delay_subtotal = 125;
+
+		out->dynamic_metadata_vm_enabled = false;
+		out->max_inter_dcn_tile_repeaters = 8;
+		out->cursor_buffer_size = 16; // kBytes
+		out->cursor_chunk_size = 2; // kBytes
+
+		out->writeback_line_buffer_buffer_size = 0;
+		out->writeback_max_hscl_ratio = 1;
+		out->writeback_max_vscl_ratio = 1;
+		out->writeback_min_hscl_ratio = 1;
+		out->writeback_min_vscl_ratio = 1;
+		out->writeback_max_hscl_taps  = 1;
+		out->writeback_max_vscl_taps  = 1;
+		out->ptoi_supported	= 0;
+
+		out->vblank_nom_default_us = 668; /*not in dml, but in programming guide, hard coded in dml2_translate_ip_params*/
+		out->config_return_buffer_segment_size_in_kbytes = 64; /*required, but not exist,, hard coded in dml2_translate_ip_params*/
+		break;
+
 	}
 }
 
@@ -155,6 +225,17 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->smn_latency_us = 0;
 		break;
 
+	case dml_project_dcn35:
+		out->num_chans = 4;
+		out->round_trip_ping_latency_dcfclk_cycles = 106;
+		out->smn_latency_us = 2;
+		break;
+
+	case dml_project_dcn351:
+		out->num_chans = 16;
+		out->round_trip_ping_latency_dcfclk_cycles = 1100;
+		out->smn_latency_us = 2;
+		break;
 	}
 	/* ---Overrides if available--- */
 	if (dml2->config.bbox_overrides.dram_num_chan)
@@ -255,7 +336,6 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		p->in_states->state_array[1].dcfclk_mhz = 1434.0;
 		p->in_states->state_array[1].dram_speed_mts = 1000 * transactions_per_mem_clock;
 		break;
-
 	}
 
 	/* Override from passed values, mainly for debugging purposes, if available */
@@ -287,6 +367,13 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 		p->dcfclk_stas_mhz[2] = 906;
 		p->dcfclk_stas_mhz[3] = 1324;
 		p->dcfclk_stas_mhz[4] = p->in_states->state_array[1].dcfclk_mhz;
+	} else if (dml2->v20.dml_core_ctx.project != dml_project_dcn35 &&
+			dml2->v20.dml_core_ctx.project != dml_project_dcn351) {
+		p->dcfclk_stas_mhz[0] = 300;
+		p->dcfclk_stas_mhz[1] = 615;
+		p->dcfclk_stas_mhz[2] = 906;
+		p->dcfclk_stas_mhz[3] = 1324;
+		p->dcfclk_stas_mhz[4] = 1500;
 	}
 	/* Copy clocks tables entries, if available */
 	if (dml2->config.bbox_overrides.clks_table.num_states) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index aed3e4200254..e4f2f3eb9b32 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -694,6 +694,12 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	(*dml2)->config = *config;
 
 	switch (in_dc->ctx->dce_version) {
+	case DCN_VERSION_3_5:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn35;
+		break;
+	case DCN_VERSION_3_51:
+		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn351;
+		break;
 	case DCN_VERSION_3_2:
 		(*dml2)->v20.dml_core_ctx.project = dml_project_dcn32;
 		break;
-- 
2.40.1


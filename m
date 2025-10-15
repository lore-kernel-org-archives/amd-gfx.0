Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBB5CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F99510E6DD;
	Wed, 15 Oct 2025 02:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7Xkf9rA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E09210E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI7AkY4S90ReMDrHdjkshZ8ZvXrdGQCnbp9BBi7KTqTZO4TVH1uHzt7yd6aT4/jhY5gEWlRu6ngSq8jjzxA4sGcHD7ZWGL7PIYL1GsTlmlnKknB0To3qJ5eXj3/qSh2iv8POBzKOXg+0vKHoQ3pfhDh80zLKLgZOBM9HDvtvtpCY5Ah3Vc14cwalfp7dc1j/zDmpnUAEwwwFcpyX8CKEM8R1tMcvMEj4FKn+wO7Os43/IsTgQDaJpKUPg2yzbvLOl2R5tm3pY5RFaPwt3Y6GHTtj/3/1ZGwB9CLhUhAa9jREJrPHvY1LwtxlthlrhfSra+gkxMipS/t6RbPoq7JH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPV5grXYEH3O9tsYlKML97QBf1Tk43YCE3J4tV8GstY=;
 b=sPZElhwT+lh3WlZ8EM9Ln3Hg2t9V3j+Lq2xwYMV4LXM9MvKg+NcKpkERQ810bjwBIn1o5n3/Z2x4r2+YyBJpydrqPKRNWBfKxybl2ejidTX8cj/H/s4cR4kkt8L5PROmjuFE6Hr7O0WFtXSgsssZZrlKc3n1wYU4J7/8NEgLQkybyIfrujD2HzSPofxESh6EjmkV+sa8Laqub1of+KUvh6M7rZciv90KExoBhreDax8YbQ3xaBHvsBzdfMbJ+FJlgYSLnzUpMnvn32LWRNDjWQnEr0yBcgW9LlPIYTGott0EUR7FRgJ04KHlPqz2hA1vO0MVDa/QHCcdk2JXcl9A2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPV5grXYEH3O9tsYlKML97QBf1Tk43YCE3J4tV8GstY=;
 b=s7Xkf9rA2NEkyge6kdn2FVbqjjmSfK27ClQsjTDVYLjtyjarohanDmY47/WTGakw6xVB1s5kpbYfmigTK5NZTCSKTF9l8xa7vcTmBlZlcpv6AqqStabOlymF+380WvGFtk7ktKn4fRfOY7L6JqL52EJ0RrqECmIRyw2Y3JNwY2o=
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 02:58:56 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::9f) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 02:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:58:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:56 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:55 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:52 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Subject: [PATCH 5/8] drm/amd/display: Fix misc. checkpatch issues
Date: Wed, 15 Oct 2025 10:57:06 +0800
Message-ID: <20251015025816.1542507-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: d54e0855-c87d-4298-3463-08de0b96c865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+UjR8RAi4Dv4fRTVOgPeRT8RrE37fyLpodpYgpoJS42Rxet2zRmwjaGHuxH?=
 =?us-ascii?Q?yU2GLnq6D01etBnuNhIJPANQ0MCiD99QvelP00JVQQltBDAUx9qFQrqVld2j?=
 =?us-ascii?Q?yLcglDfWqiIohWkUq1vLdB5Bka9xWLo9YT18ZNZswtAfJS/abh1oMWQdepPv?=
 =?us-ascii?Q?T4x6EtSjc4XQTdAWDcLhWjDjTdOmmAoyQrSM3FC0V5vZKORpNfcVnd937/8f?=
 =?us-ascii?Q?ZcypPsq+zdawqtQA5zixwFW/cYzvyKUfOY1UoKMW8MwzP93YAVGUVhnowuqu?=
 =?us-ascii?Q?mhNh8Yh6KIL37dxKomEyXRbAKyOD+LQ9CaOsFgDZy8nX2QvIaywb/EeJ2ZJN?=
 =?us-ascii?Q?Y1xQkMFMNFWAYKaqI/WjaM3OZIgBdJbyh0IdH2MiTJYjJ40Bs2YweS8gGTVT?=
 =?us-ascii?Q?yS+dLiM9/7sxk+FhEopPwUulHBDiG4HrQlUELcWkYhj7Bjz/amiI7GOSWFXQ?=
 =?us-ascii?Q?DnJYZxTI8UVd4s9xe9M5ukO+lNxsb/wIJWOMZfcC1pbHrLwxw0Bs5/BE2a07?=
 =?us-ascii?Q?VZrU4TVPBVv3pcffwPNEVowzOCj42TPkN9fYFt5y2g+0PG1xEpg3ejkiOikM?=
 =?us-ascii?Q?lm77OxWw6mRPtdH3iWZTvPlMMhfjqtH6OeRP42E02050/cUbeJWda5rF2Dal?=
 =?us-ascii?Q?X3vahcBBLEhqt5V3Bx0Jo4sfm6faUaWguTJ6gDrrlo56m2/ay7KJu5bCZcyg?=
 =?us-ascii?Q?wnpiViQVv3kvy22gcOR1Fsup/u2pfFXKuZLXBFlAUKoKIosoq4aiuFw9zCVH?=
 =?us-ascii?Q?AGtn/z1u/tEkfU3IBf/WpA+tjNTdIM6gSPyyXP2XBJX+W8GYBX9J5ySxeME8?=
 =?us-ascii?Q?YErnJMVhh7NYn81I2NGCEDDlTgelIAHVviLv/VToHocKSgI6glDWIn0V8IjJ?=
 =?us-ascii?Q?ClVIXBlnGiw1Sr3IJioqPrhyG8fb/8xcUGy0qcntng0/zjGZfiTj8Nrm6w+9?=
 =?us-ascii?Q?wFLKzvKOpWZMUKXkDGr9xFIg0fo9n3zPM0dQzFH5k5CXgmzEgId0oY385DZM?=
 =?us-ascii?Q?qICresn5NRvuBRstRtxIU5shsGmoMAOLm5PxeoUMRsP/q6aEGC4C3x72CZyg?=
 =?us-ascii?Q?cATnJjaYsMqHE58PDw3xktHh8BpZD57vJY3BAkmnNmH3Td+q6nS7yuwtnIME?=
 =?us-ascii?Q?SZTIKr566hZDyUH5B1rGr+Ua/M90zkyLndyLbQXiTlJMZ5FVFsbkckGn1Txj?=
 =?us-ascii?Q?+6pp/D6cpBrg10z9sXbTk2E9V2Bp0l/YdG7LLdXqnL9vHv1/OVPnlNesNRn1?=
 =?us-ascii?Q?+0XbKKr93PSbZ8aB3zVWsNmZ78nZ74L4CoSjWedoMf2jxtiFJuZ0g4Ofhg7T?=
 =?us-ascii?Q?Zb9ZwvZU/V2w+TXoGF7+3NF8pTG7KfikeGEjcGdnco/k2xRPmRBfMHif8jtn?=
 =?us-ascii?Q?N50+1lA9XLLP3riLwwXft4u/2P6xIyHExfPdDxDmYgNdvwvG/y5cy7K0Z7jQ?=
 =?us-ascii?Q?FXRgKbrBdC3Af6zX10VFpselG3I7fo+OVX4Y9W6NGI2ls56hOo8/tSmt9F2D?=
 =?us-ascii?Q?Hh8SRzc2F4Sd3O9iYFDDZ5b9YhQVCTFlTtymvCYbFzCBcWqaLsLY6LaBcIHn?=
 =?us-ascii?Q?ZQF+Bz/MyoaQ5qqPkhM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:58:56.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54e0855-c87d-4298-3463-08de0b96c865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Addresses various checkpatch issues related to the HWSS block sequence
function change.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  57 +++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 160 ++++++++----------
 2 files changed, 86 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 16d916986fed..f95cb0cf4b8a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1962,9 +1962,8 @@ void hwss_program_bias_and_scale(union block_sequence_params *params)
 	struct dc_bias_and_scale bns_params = plane_state->bias_and_scale;
 
 	//TODO :for CNVC set scale and bias registers if necessary
-	if (dpp->funcs->dpp_program_bias_and_scale) {
+	if (dpp->funcs->dpp_program_bias_and_scale)
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
-	}
 }
 
 void hwss_power_on_mpc_mem_pwr(union block_sequence_params *params)
@@ -2121,6 +2120,7 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *c
 void hwss_wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		int count = 0;
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -2277,6 +2277,7 @@ void hwss_tg_set_dsc_config(union block_sequence_params *params)
 
 	if (params->tg_set_dsc_config_params.enable) {
 		struct dsc_optc_config *dsc_optc_cfg = params->tg_set_dsc_config_params.dsc_optc_cfg;
+
 		if (dsc_optc_cfg) {
 			bytes_per_pixel = dsc_optc_cfg->bytes_per_pixel;
 			slice_width = dsc_optc_cfg->slice_width;
@@ -2370,9 +2371,8 @@ void hwss_tg_wait_for_state(union block_sequence_params *params)
 	struct timing_generator *tg = params->tg_wait_for_state_params.tg;
 	enum crtc_state state = params->tg_wait_for_state_params.state;
 
-	if (tg->funcs->wait_for_state) {
+	if (tg->funcs->wait_for_state)
 		tg->funcs->wait_for_state(tg, state);
-	}
 }
 
 void hwss_tg_set_vtg_params(union block_sequence_params *params)
@@ -2381,9 +2381,8 @@ void hwss_tg_set_vtg_params(union block_sequence_params *params)
 	struct dc_crtc_timing *timing = params->tg_set_vtg_params_params.timing;
 	bool program_fp2 = params->tg_set_vtg_params_params.program_fp2;
 
-	if (tg->funcs->set_vtg_params) {
+	if (tg->funcs->set_vtg_params)
 		tg->funcs->set_vtg_params(tg, timing, program_fp2);
-	}
 }
 
 void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params)
@@ -2391,9 +2390,8 @@ void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params)
 	struct timing_generator *tg = params->tg_setup_vertical_interrupt2_params.tg;
 	int start_line = params->tg_setup_vertical_interrupt2_params.start_line;
 
-	if (tg->funcs->setup_vertical_interrupt2) {
+	if (tg->funcs->setup_vertical_interrupt2)
 		tg->funcs->setup_vertical_interrupt2(tg, start_line);
-	}
 }
 
 void hwss_dpp_set_hdr_multiplier(union block_sequence_params *params)
@@ -2401,9 +2399,8 @@ void hwss_dpp_set_hdr_multiplier(union block_sequence_params *params)
 	struct dpp *dpp = params->dpp_set_hdr_multiplier_params.dpp;
 	uint32_t hw_mult = params->dpp_set_hdr_multiplier_params.hw_mult;
 
-	if (dpp->funcs->dpp_set_hdr_multiplier) {
+	if (dpp->funcs->dpp_set_hdr_multiplier)
 		dpp->funcs->dpp_set_hdr_multiplier(dpp, hw_mult);
-	}
 }
 
 void hwss_program_det_size(union block_sequence_params *params)
@@ -2412,9 +2409,8 @@ void hwss_program_det_size(union block_sequence_params *params)
 	unsigned int hubp_inst = params->program_det_size_params.hubp_inst;
 	unsigned int det_buffer_size_kb = params->program_det_size_params.det_buffer_size_kb;
 
-	if (hubbub->funcs->program_det_size) {
+	if (hubbub->funcs->program_det_size)
 		hubbub->funcs->program_det_size(hubbub, hubp_inst, det_buffer_size_kb);
-	}
 }
 
 void hwss_program_det_segments(union block_sequence_params *params)
@@ -2423,9 +2419,8 @@ void hwss_program_det_segments(union block_sequence_params *params)
 	unsigned int hubp_inst = params->program_det_segments_params.hubp_inst;
 	unsigned int det_size = params->program_det_segments_params.det_size;
 
-	if (hubbub->funcs->program_det_segments) {
+	if (hubbub->funcs->program_det_segments)
 		hubbub->funcs->program_det_segments(hubbub, hubp_inst, det_size);
-	}
 }
 
 void hwss_opp_set_dyn_expansion(union block_sequence_params *params)
@@ -2435,9 +2430,8 @@ void hwss_opp_set_dyn_expansion(union block_sequence_params *params)
 	enum dc_color_depth color_depth = params->opp_set_dyn_expansion_params.color_depth;
 	enum signal_type signal = params->opp_set_dyn_expansion_params.signal;
 
-	if (opp->funcs->opp_set_dyn_expansion) {
+	if (opp->funcs->opp_set_dyn_expansion)
 		opp->funcs->opp_set_dyn_expansion(opp, color_space, color_depth, signal);
-	}
 }
 
 void hwss_opp_program_fmt(union block_sequence_params *params)
@@ -2446,9 +2440,8 @@ void hwss_opp_program_fmt(union block_sequence_params *params)
 	struct bit_depth_reduction_params *fmt_bit_depth = params->opp_program_fmt_params.fmt_bit_depth;
 	struct clamping_and_pixel_encoding_params *clamping = params->opp_program_fmt_params.clamping;
 
-	if (opp->funcs->opp_program_fmt) {
+	if (opp->funcs->opp_program_fmt)
 		opp->funcs->opp_program_fmt(opp, fmt_bit_depth, clamping);
-	}
 }
 
 void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params)
@@ -2458,15 +2451,13 @@ void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params)
 	struct pipe_ctx *pipe_ctx = params->opp_program_bit_depth_reduction_params.pipe_ctx;
 	struct bit_depth_reduction_params bit_depth_params;
 
-	if (use_default_params) {
+	if (use_default_params)
 		memset(&bit_depth_params, 0, sizeof(bit_depth_params));
-	} else {
+	else
 		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &bit_depth_params);
-	}
 
-	if (opp->funcs->opp_program_bit_depth_reduction) {
+	if (opp->funcs->opp_program_bit_depth_reduction)
 		opp->funcs->opp_program_bit_depth_reduction(opp, &bit_depth_params);
-	}
 }
 
 void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params)
@@ -2500,9 +2491,8 @@ void hwss_set_abm_level(union block_sequence_params *params)
 	struct abm *abm = params->set_abm_level_params.abm;
 	unsigned int abm_level = params->set_abm_level_params.abm_level;
 
-	if (abm->funcs->set_abm_level) {
+	if (abm->funcs->set_abm_level)
 		abm->funcs->set_abm_level(abm, abm_level);
-	}
 }
 
 void hwss_set_abm_immediate_disable(union block_sequence_params *params)
@@ -2510,9 +2500,8 @@ void hwss_set_abm_immediate_disable(union block_sequence_params *params)
 	struct dc *dc = params->set_abm_immediate_disable_params.dc;
 	struct pipe_ctx *pipe_ctx = params->set_abm_immediate_disable_params.pipe_ctx;
 
-	if (dc && dc->hwss.set_abm_immediate_disable) {
+	if (dc && dc->hwss.set_abm_immediate_disable)
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
-	}
 }
 
 void hwss_mpc_remove_mpcc(union block_sequence_params *params)
@@ -2793,34 +2782,29 @@ void hwss_hubp_init(union block_sequence_params *params)
 {
 	struct hubp *hubp = params->hubp_init_params.hubp;
 
-	if (hubp && hubp->funcs->hubp_init) {
+	if (hubp && hubp->funcs->hubp_init)
 		hubp->funcs->hubp_init(hubp);
-	}
 }
 
 void hwss_hubp_set_vm_system_aperture_settings(union block_sequence_params *params)
 {
 	struct hubp *hubp = params->hubp_set_vm_system_aperture_settings_params.hubp;
-	//struct vm_system_aperture_param *apt = &params->hubp_set_vm_system_aperture_settings_params.apt;
 	struct vm_system_aperture_param apt;
 
 	apt.sys_default = params->hubp_set_vm_system_aperture_settings_params.sys_default;
 	apt.sys_high = params->hubp_set_vm_system_aperture_settings_params.sys_high;
 	apt.sys_low = params->hubp_set_vm_system_aperture_settings_params.sys_low;
 
-	if (hubp && hubp->funcs->hubp_set_vm_system_aperture_settings) {
-		//hubp->funcs->hubp_set_vm_system_aperture_settings(hubp, apt);
+	if (hubp && hubp->funcs->hubp_set_vm_system_aperture_settings)
 		hubp->funcs->hubp_set_vm_system_aperture_settings(hubp, &apt);
-	}
 }
 
 void hwss_hubp_set_flip_int(union block_sequence_params *params)
 {
 	struct hubp *hubp = params->hubp_set_flip_int_params.hubp;
 
-	if (hubp && hubp->funcs->hubp_set_flip_int) {
+	if (hubp && hubp->funcs->hubp_set_flip_int)
 		hubp->funcs->hubp_set_flip_int(hubp);
-	}
 }
 
 void hwss_dpp_dppclk_control(union block_sequence_params *params)
@@ -3049,13 +3033,10 @@ void hwss_mpc_update_blending(union block_sequence_params *params)
 void hwss_mpc_assert_idle_mpcc(union block_sequence_params *params)
 {
 	struct mpc *mpc = params->mpc_assert_idle_mpcc_params.mpc;
-	//struct pipe_ctx *pipe_ctx = params->mpc_assert_idle_mpcc_params.pipe_ctx;
 	int mpcc_id = params->mpc_assert_idle_mpcc_params.mpcc_id;
 
 	if (mpc && mpc->funcs->wait_for_idle)
 		mpc->funcs->wait_for_idle(mpc, mpcc_id);
-
-	//pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_id] = false;
 }
 
 void hwss_mpc_insert_plane(union block_sequence_params *params)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index e6d3ff8598f5..23ecab4bcbba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2271,17 +2271,15 @@ void dcn401_program_pipe_sequence(
 			(unsigned int)pipe_ctx->global_sync.dcn4x.pstate_keepout_start_lines);
 
 		/* Step 2: Wait for VACTIVE state (if not phantom pipe) */
-		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+		if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM)
 			hwss_add_tg_wait_for_state(seq_state, pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-		}
 
 		/* Step 3: Set VTG params */
 		hwss_add_tg_set_vtg_params(seq_state, pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing, true);
 
 		/* Step 4: Setup vupdate interrupt (if available) */
-		if (hws->funcs.setup_vupdate_interrupt) {
+		if (hws->funcs.setup_vupdate_interrupt)
 			dcn401_setup_vupdate_interrupt_sequence(dc, pipe_ctx, seq_state);
-		}
 	}
 
 	if (pipe_ctx->update_flags.bits.odm) {
@@ -2347,9 +2345,11 @@ void dcn401_program_pipe_sequence(
 	if (pipe_ctx->update_flags.bits.enable
 		|| pipe_ctx->update_flags.bits.opp_changed) {
 
-		hwss_add_opp_set_dyn_expansion(seq_state, pipe_ctx->stream_res.opp, COLOR_SPACE_YCBCR601, pipe_ctx->stream->timing.display_color_depth, pipe_ctx->stream->signal);
+		hwss_add_opp_set_dyn_expansion(seq_state, pipe_ctx->stream_res.opp, COLOR_SPACE_YCBCR601,
+			pipe_ctx->stream->timing.display_color_depth, pipe_ctx->stream->signal);
 
-		hwss_add_opp_program_fmt(seq_state, pipe_ctx->stream_res.opp, &pipe_ctx->stream->bit_depth_params, &pipe_ctx->stream->clamping);
+		hwss_add_opp_program_fmt(seq_state, pipe_ctx->stream_res.opp,
+			&pipe_ctx->stream->bit_depth_params, &pipe_ctx->stream->clamping);
 	}
 
 	/* Set ABM pipe after other pipe configurations done */
@@ -2366,7 +2366,16 @@ void dcn401_program_pipe_sequence(
 
 		hwss_add_opp_program_bit_depth_reduction(seq_state, odm_opp, true, pipe_ctx);
 
-		hwss_add_opp_set_disp_pattern_generator(seq_state, odm_opp, pipe_ctx->stream_res.test_pattern_params.test_pattern, pipe_ctx->stream_res.test_pattern_params.color_space, pipe_ctx->stream_res.test_pattern_params.color_depth, (struct tg_color){0}, false, pipe_ctx->stream_res.test_pattern_params.width, pipe_ctx->stream_res.test_pattern_params.height, pipe_ctx->stream_res.test_pattern_params.offset);
+		hwss_add_opp_set_disp_pattern_generator(seq_state,
+			odm_opp,
+			pipe_ctx->stream_res.test_pattern_params.test_pattern,
+			pipe_ctx->stream_res.test_pattern_params.color_space,
+			pipe_ctx->stream_res.test_pattern_params.color_depth,
+			(struct tg_color){0},
+			false,
+			pipe_ctx->stream_res.test_pattern_params.width,
+			pipe_ctx->stream_res.test_pattern_params.height,
+			pipe_ctx->stream_res.test_pattern_params.offset);
 	}
 
 }
@@ -3025,9 +3034,8 @@ void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
 	/* Check and set DC_IP_REQUEST_CNTL if needed */
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
-		if (org_ip_request_cntl == 0) {
+		if (org_ip_request_cntl == 0)
 			hwss_add_dc_ip_request_cntl(seq_state, dc, true);
-		}
 	}
 
 	/* DPP power gating control */
@@ -3043,9 +3051,8 @@ void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
 	hwss_add_dpp_reset(seq_state, dpp);
 
 	/* Restore DC_IP_REQUEST_CNTL if it was originally 0 */
-	if (org_ip_request_cntl == 0 && REG(DC_IP_REQUEST_CNTL)) {
+	if (org_ip_request_cntl == 0 && REG(DC_IP_REQUEST_CNTL))
 		hwss_add_dc_ip_request_cntl(seq_state, dc, false);
-	}
 
 	DC_LOG_DEBUG("Power gated front end %d\n", hubp->inst);
 
@@ -3087,14 +3094,12 @@ void dcn401_plane_atomic_disconnect_sequence(struct dc *dc,
 	hwss_add_dc_set_optimized_required(seq_state, dc, true);
 
 	/* Step 4: Disconnect HUBP if function exists */
-	if (hubp->funcs->hubp_disconnect) {
+	if (hubp->funcs->hubp_disconnect)
 		hwss_add_hubp_disconnect(seq_state, hubp);
-	}
 
 	/* Step 5: Verify pstate change high if debug sanity checks are enabled */
-	if (dc->debug.sanity_checks) {
+	if (dc->debug.sanity_checks)
 		dc->hwseq->funcs.verify_allow_pstate_change_high_sequence(dc, seq_state);
-	}
 }
 
 void dcn401_blank_pixel_data_sequence(
@@ -3418,14 +3423,12 @@ void dcn401_disable_plane_sequence(
 	/* In flip immediate with pipe splitting case GSL is used for synchronization
 	 * so we must disable it when the plane is disabled.
 	 */
-	if (pipe_ctx->stream_res.gsl_group != 0) {
+	if (pipe_ctx->stream_res.gsl_group != 0)
 		dcn401_setup_gsl_group_as_lock_sequence(dc, pipe_ctx, false, seq_state);
-	}
 
 	/* Update HUBP mall sel */
-	if (pipe_ctx->plane_res.hubp && pipe_ctx->plane_res.hubp->funcs->hubp_update_mall_sel) {
+	if (pipe_ctx->plane_res.hubp && pipe_ctx->plane_res.hubp->funcs->hubp_update_mall_sel)
 		hwss_add_hubp_update_mall_sel(seq_state, pipe_ctx->plane_res.hubp, 0, false);
-	}
 
 	/* Set flip control GSL */
 	hwss_add_hubp_set_flip_control_gsl(seq_state, pipe_ctx->plane_res.hubp, false);
@@ -3451,9 +3454,8 @@ void dcn401_disable_plane_sequence(
 	pipe_ctx->plane_state = NULL;
 
 	/* Turn back off the phantom OTG after the phantom plane is fully disabled */
-	if (is_phantom && tg && tg->funcs->disable_phantom_crtc) {
+	if (is_phantom && tg && tg->funcs->disable_phantom_crtc)
 		hwss_add_disable_phantom_crtc(seq_state, tg);
-	}
 }
 
 void dcn401_post_unlock_reset_opp_sequence(
@@ -3473,15 +3475,14 @@ void dcn401_post_unlock_reset_opp_sequence(
 	if (dsc) {
 		bool *is_ungated = NULL;
 		/* Check DSC power gate status */
-		if (dc->hwseq && dc->hwseq->funcs.dsc_pg_status) {
+		if (dc->hwseq && dc->hwseq->funcs.dsc_pg_status)
 			hwss_add_dsc_pg_status(seq_state, dc->hwseq, dsc->inst, false);
-		}
 
 		/* Seamless update specific where we will postpone non
-			* double buffered DSCCLK disable logic in post unlock
-			* sequence after DSC is disconnected from OPP but not
-			* yet power gated.
-			*/
+		 * double buffered DSCCLK disable logic in post unlock
+		 * sequence after DSC is disconnected from OPP but not
+		 * yet power gated.
+		 */
 
 		/* DSC wait disconnect pending clear */
 		hwss_add_dsc_wait_disconnect_pending_clear(seq_state, dsc, is_ungated);
@@ -3490,9 +3491,8 @@ void dcn401_post_unlock_reset_opp_sequence(
 		hwss_add_dsc_disable(seq_state, dsc, is_ungated);
 
 		/* Set reference DSCCLK */
-		if (dccg && dccg->funcs->set_ref_dscclk) {
+		if (dccg && dccg->funcs->set_ref_dscclk)
 			hwss_add_dccg_set_ref_dscclk(seq_state, dccg, dsc->inst, 0);
-		}
 	}
 }
 
@@ -3500,9 +3500,8 @@ void dcn401_dc_ip_request_cntl(struct dc *dc, bool enable)
 {
 	struct dce_hwseq *hws = dc->hwseq;
 
-	if (REG(DC_IP_REQUEST_CNTL)) {
+	if (REG(DC_IP_REQUEST_CNTL))
 		REG_SET(DC_IP_REQUEST_CNTL, 0, IP_REQUEST_EN, enable ? 1 : 0);
-	}
 }
 
 void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
@@ -3512,52 +3511,43 @@ void dcn401_enable_plane_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	struct dce_hwseq *hws = dc->hwseq;
 	uint32_t org_ip_request_cntl = 0;
 
-	if (!pipe_ctx->plane_res.dpp || !pipe_ctx->plane_res.hubp || !pipe_ctx->stream_res.opp) {
+	if (!pipe_ctx->plane_res.dpp || !pipe_ctx->plane_res.hubp || !pipe_ctx->stream_res.opp)
 		return;
-	}
 
 	if (REG(DC_IP_REQUEST_CNTL))
 		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 
 	/* Step 1: DPP root clock control - enable clock */
-	if (hws->funcs.dpp_root_clock_control) {
+	if (hws->funcs.dpp_root_clock_control)
 		hwss_add_dpp_root_clock_control(seq_state, hws, pipe_ctx->plane_res.dpp->inst, true);
-	}
 
 	/* Step 2: Enable DC IP request (if needed) */
-	if (hws->funcs.dc_ip_request_cntl) {
+	if (hws->funcs.dc_ip_request_cntl)
 		hwss_add_dc_ip_request_cntl(seq_state, dc, true);
-	}
 
 	/* Step 3: DPP power gating control - power on */
-	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.dpp_pg_control) {
+	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.dpp_pg_control)
 		hwss_add_dpp_pg_control(seq_state, hws, pipe_ctx->plane_res.dpp->inst, true);
-	}
 
 	/* Step 4: HUBP power gating control - power on */
-	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.hubp_pg_control) {
+	if (REG(DC_IP_REQUEST_CNTL) && hws->funcs.hubp_pg_control)
 		hwss_add_hubp_pg_control(seq_state, hws, pipe_ctx->plane_res.hubp->inst, true);
-	}
 
 	/* Step 5: Disable DC IP request (restore state) */
-	if (org_ip_request_cntl == 0 && hws->funcs.dc_ip_request_cntl) {
+	if (org_ip_request_cntl == 0 && hws->funcs.dc_ip_request_cntl)
 		hwss_add_dc_ip_request_cntl(seq_state, dc, false);
-	}
 
 	/* Step 6: HUBP clock control - enable DCFCLK */
-	if (pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl) {
+	if (pipe_ctx->plane_res.hubp->funcs->hubp_clk_cntl)
 		hwss_add_hubp_clk_cntl(seq_state, pipe_ctx->plane_res.hubp, true);
-	}
 
 	/* Step 7: HUBP initialization */
-	if (pipe_ctx->plane_res.hubp->funcs->hubp_init) {
+	if (pipe_ctx->plane_res.hubp->funcs->hubp_init)
 		hwss_add_hubp_init(seq_state, pipe_ctx->plane_res.hubp);
-	}
 
 	/* Step 8: OPP pipe clock control - enable */
-	if (pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control) {
+	if (pipe_ctx->stream_res.opp->funcs->opp_pipe_clock_control)
 		hwss_add_opp_pipe_clock_control(seq_state, pipe_ctx->stream_res.opp, true);
-	}
 
 	/* Step 9: VM system aperture settings */
 	if (dc->vm_pa_config.valid && pipe_ctx->plane_res.hubp->funcs->hubp_set_vm_system_aperture_settings) {
@@ -3587,19 +3577,16 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 	bool viewport_changed = false;
 	enum mall_stream_type pipe_mall_type = dc_state_get_pipe_subvp_type(context, pipe_ctx);
 
-	if (!hubp || !dpp || !plane_state) {
+	if (!hubp || !dpp || !plane_state)
 		return;
-	}
 
 	/* Step 1: DPP DPPCLK control */
-	if (pipe_ctx->update_flags.bits.dppclk) {
+	if (pipe_ctx->update_flags.bits.dppclk)
 		hwss_add_dpp_dppclk_control(seq_state, dpp, false, true);
-	}
 
 	/* Step 2: DCCG update DPP DTO */
-	if (pipe_ctx->update_flags.bits.enable) {
+	if (pipe_ctx->update_flags.bits.enable)
 		hwss_add_dccg_update_dpp_dto(seq_state, dccg, dpp->inst, pipe_ctx->plane_res.bw.dppclk_khz);
-	}
 
 	/* Step 3: HUBP VTG selection */
 	if (pipe_ctx->update_flags.bits.hubp_rq_dlg_ttu) {
@@ -3616,17 +3603,15 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 	}
 
 	/* Step 5: Set unbounded requesting */
-	if (pipe_ctx->update_flags.bits.unbounded_req && hubp->funcs->set_unbounded_requesting) {
+	if (pipe_ctx->update_flags.bits.unbounded_req && hubp->funcs->set_unbounded_requesting)
 		hwss_add_hubp_set_unbounded_requesting(seq_state, hubp, pipe_ctx->unbounded_req);
-	}
 
 	/* Step 6: HUBP interdependent setup */
 	if (pipe_ctx->update_flags.bits.hubp_interdependent) {
-		if (hubp->funcs->hubp_setup_interdependent2) {
+		if (hubp->funcs->hubp_setup_interdependent2)
 			hwss_add_hubp_setup_interdependent2(seq_state, hubp, &pipe_ctx->hubp_regs);
-		} else if (hubp->funcs->hubp_setup_interdependent) {
+		else if (hubp->funcs->hubp_setup_interdependent)
 			hwss_add_hubp_setup_interdependent(seq_state, hubp, &pipe_ctx->dlg_regs, &pipe_ctx->ttu_regs);
-		}
 	}
 
 	/* Step 7: DPP setup - input CSC and format setup */
@@ -3645,9 +3630,8 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 		}
 
 		/* Step 9: DPP program bias and scale */
-		if (dpp->funcs->dpp_program_bias_and_scale) {
+		if (dpp->funcs->dpp_program_bias_and_scale)
 			hwss_add_dpp_program_bias_and_scale(seq_state, pipe_ctx);
-		}
 	}
 
 	/* Step 10: MPCC updates */
@@ -3683,9 +3667,8 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 	}
 
 	/* Step 13: HUBP program mcache if available */
-	if (hubp->funcs->hubp_program_mcache_id_and_split_coordinate) {
+	if (hubp->funcs->hubp_program_mcache_id_and_split_coordinate)
 		hwss_add_hubp_program_mcache_id(seq_state, hubp, &pipe_ctx->mcache_regs);
-	}
 
 	/* Step 14: Cursor attribute setup */
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
@@ -3698,9 +3681,8 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 		hwss_add_set_cursor_position(seq_state, dc, pipe_ctx);
 
 		/* Step 16: Cursor SDR white level */
-		if (dc->hwss.set_cursor_sdr_white_level) {
+		if (dc->hwss.set_cursor_sdr_white_level)
 			hwss_add_set_cursor_sdr_white_level(seq_state, dc, pipe_ctx);
-		}
 	}
 
 	/* Step 17: Gamut remap and output CSC */
@@ -3747,7 +3729,8 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 
 		/* SubVP save surface address if needed */
 		if (resource_is_pipe_type(pipe_ctx, OTG_MASTER) && pipe_mall_type == SUBVP_MAIN) {
-			hwss_add_dmub_subvp_save_surf_addr(seq_state, dc->ctx->dmub_srv, &pipe_ctx->plane_state->address, pipe_ctx->subvp_index);
+			hwss_add_dmub_subvp_save_surf_addr(seq_state, dc->ctx->dmub_srv,
+				&pipe_ctx->plane_state->address, pipe_ctx->subvp_index);
 		}
 
 		/* Update plane address */
@@ -3755,14 +3738,12 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 	}
 
 	/* Step 20: HUBP set blank - enable plane */
-	if (pipe_ctx->update_flags.bits.enable) {
+	if (pipe_ctx->update_flags.bits.enable)
 		hwss_add_hubp_set_blank(seq_state, hubp, false);
-	}
 
 	/* Step 21: Phantom HUBP post enable */
-	if (pipe_mall_type == SUBVP_PHANTOM && hubp->funcs->phantom_hubp_post_enable) {
+	if (pipe_mall_type == SUBVP_PHANTOM && hubp->funcs->phantom_hubp_post_enable)
 		hwss_add_phantom_hubp_post_enable(seq_state, hubp);
-	}
 }
 
 void dcn401_update_mpcc_sequence(struct dc *dc,
@@ -3777,9 +3758,8 @@ void dcn401_update_mpcc_sequence(struct dc *dc,
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
-	if (!hubp || !pipe_ctx->plane_state) {
+	if (!hubp || !pipe_ctx->plane_state)
 		return;
-	}
 
 	per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha;
 
@@ -3837,9 +3817,8 @@ void dcn401_update_mpcc_sequence(struct dc *dc,
 		hwss_add_mpc_remove_mpcc(seq_state, mpc, mpc_tree_params, new_mpcc);
 	} else {
 		/* Step 4: Assert MPCC idle (debug only) */
-		if (dc->debug.sanity_checks) {
+		if (dc->debug.sanity_checks)
 			hwss_add_mpc_assert_idle_mpcc(seq_state, mpc, mpcc_id);
-		}
 	}
 
 	/* Step 5: Insert new plane into MPC tree */
@@ -3873,9 +3852,8 @@ void dcn401_wait_for_mpcc_disconnect_sequence(
 {
 	int mpcc_inst;
 
-	if (dc->debug.sanity_checks) {
+	if (dc->debug.sanity_checks)
 		dc->hwseq->funcs.verify_allow_pstate_change_high_sequence(dc, seq_state);
-	}
 
 	if (!pipe_ctx->stream_res.opp)
 		return;
@@ -3889,15 +3867,13 @@ void dcn401_wait_for_mpcc_disconnect_sequence(
 				hwss_add_mpc_assert_idle_mpcc(seq_state, res_pool->mpc, mpcc_inst);
 			}
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
-			if (hubp) {
+			if (hubp)
 				hwss_add_hubp_set_blank(seq_state, hubp, true);
-			}
 		}
 	}
 
-	if (dc->debug.sanity_checks) {
+	if (dc->debug.sanity_checks)
 		dc->hwseq->funcs.verify_allow_pstate_change_high_sequence(dc, seq_state);
-	}
 }
 
 void dcn401_setup_vupdate_interrupt_sequence(struct dc *dc, struct pipe_ctx *pipe_ctx,
@@ -3909,9 +3885,8 @@ void dcn401_setup_vupdate_interrupt_sequence(struct dc *dc, struct pipe_ctx *pip
 	if (start_line < 0)
 		start_line = 0;
 
-	if (tg->funcs->setup_vertical_interrupt2) {
+	if (tg->funcs->setup_vertical_interrupt2)
 		hwss_add_tg_setup_vertical_interrupt2(seq_state, tg, start_line);
-	}
 }
 
 void dcn401_set_hdr_multiplier_sequence(struct pipe_ctx *pipe_ctx,
@@ -3987,9 +3962,8 @@ void dcn401_program_mall_pipe_config_sequence(struct dc *dc, struct dc_state *co
 		struct hubp *hubp = pipe->plane_res.hubp;
 
 		if (pipe->stream && hubp && hubp->funcs->hubp_prepare_subvp_buffering) {
-			if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN) {
+			if (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN)
 				hwss_add_hubp_prepare_subvp_buffering(seq_state, hubp, true);
-			}
 		}
 	}
 }
@@ -4020,11 +3994,11 @@ bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
 	/* Step 1: Set HUBP_BLANK_EN=1 for all active pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
 		if (pipe_ctx != NULL) {
 			hubp = pipe_ctx->plane_res.hubp;
-			if (hubp != NULL && hubp->funcs->set_hubp_blank_en) {
+			if (hubp != NULL && hubp->funcs->set_hubp_blank_en)
 				hwss_add_hubp_set_blank_en(seq_state, hubp, true);
-			}
 		}
 	}
 
@@ -4034,22 +4008,22 @@ bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
 	/* Step 3: Set HUBP_DISABLE=1 for all active pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
 		if (pipe_ctx != NULL) {
 			hubp = pipe_ctx->plane_res.hubp;
-			if (hubp != NULL && hubp->funcs->hubp_disable_control) {
+			if (hubp != NULL && hubp->funcs->hubp_disable_control)
 				hwss_add_hubp_disable_control(seq_state, hubp, true);
-			}
 		}
 	}
 
 	/* Step 4: Set HUBP_DISABLE=0 for all active pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
 		if (pipe_ctx != NULL) {
 			hubp = pipe_ctx->plane_res.hubp;
-			if (hubp != NULL && hubp->funcs->hubp_disable_control) {
+			if (hubp != NULL && hubp->funcs->hubp_disable_control)
 				hwss_add_hubp_disable_control(seq_state, hubp, false);
-			}
 		}
 	}
 
@@ -4059,11 +4033,11 @@ bool dcn401_hw_wa_force_recovery_sequence(struct dc *dc,
 	/* Step 6: Set HUBP_BLANK_EN=0 for all active pipes */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
 		if (pipe_ctx != NULL) {
 			hubp = pipe_ctx->plane_res.hubp;
-			if (hubp != NULL && hubp->funcs->set_hubp_blank_en) {
+			if (hubp != NULL && hubp->funcs->set_hubp_blank_en)
 				hwss_add_hubp_set_blank_en(seq_state, hubp, false);
-			}
 		}
 	}
 
-- 
2.43.0


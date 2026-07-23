Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF21FC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEA710F1F0;
	Thu, 23 Jul 2026 20:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="He9R7Qf2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012059.outbound.protection.outlook.com
 [40.93.195.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF40910F1EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCfjpSPBpKCDgdpBTAaO9Cs6DaGHYNZu95ZYHhBhfUeW9QZK8PzBedCkXwpozpIQIfQB2QIOmV8qTedNMBq2gPoGJK1M7/GiAkkoRsHtD176lgQLvs7FnJRcBymbhdZBaKxv04rVWDCg1I+3KuVWo7/arVcm/ijnnHzuODtvakwLl88wt1jhVq8wGJEC1p+uBP86rCtrQpAIfZwhDJ1hHrG6qaVIfWAnYzYhNq8i6a1FJAccQeQUcSuhFqZ1G/27RVSqiGshFJ3X08GD1XpZC8CBRZr/m1cmMkIgucWVNzf9Vn9V7iDUXArEULYXAWZTHNSLdjZgqcifp4kidaPjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEXv4s6Ic8CQ1j+DBac6L8Sk0jfMZ/UmqB1Dx8AkvMo=;
 b=mRuitIirgA1WHSGOtkXEDtVrO/EvDi4bIsE+Zia6UZLJ41jvNV7deptfF0SZ0LQ00DTwY0bPqqL/RQM5NHrLMQjQImaV7RUSIHeBzBYtIohJnGb6gGq4meq4d1ubxLhdt2O3MvV850bgwNbJsOy3vrDH4NQ9LMB3j8X2oD88Sfw6cwInkT7OaNfXnnMZLJwdBo2awR4l5sTVwnPL14KbnrrDNTIOwFRNeGW/CRulAF4aIk80omN/rZXdiPiEGmCw/1UbBsT6QL7J2HVoYG3YToBFisaXIc7Mq8B9OZV4kmDM8Q03oskSYxilQopljoPcDXSY1kUOARjbZaTLJjUUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEXv4s6Ic8CQ1j+DBac6L8Sk0jfMZ/UmqB1Dx8AkvMo=;
 b=He9R7Qf2+NrMahiVVLkJjEjcu8SisDK4lM9wC430T4obstIHQvrEzRgb57RZt1dSfwMiPFtROoLUyNVw80T9f/A34su6KkUsrXF8gAvXyo4xeR9ayqs0d6NBPTh1u8WuOxG3z47uki2m47vbYj4sEH1c5j4R5boQCIFPjHhw0ZA=
Received: from BL1PR13CA0373.namprd13.prod.outlook.com (2603:10b6:208:2c0::18)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:52 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5c) by BL1PR13CA0373.outlook.office365.com
 (2603:10b6:208:2c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 20:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:50 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:20 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alexander Chechik <alexander.chechik@amd.com>,
 "Dillon Varone" <dillon.varone@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 43/49] drm/amd/display: enforce UCLK pstate support in
 mode_support
Date: Thu, 23 Jul 2026 16:13:51 -0400
Message-ID: <20260723201908.373300-44-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b203fb4-e1e5-44a2-cb82-08dee8f7bfa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: S8em1ntj349BC6CDUYqqaCHtkgIRVm0sA2W8dk8wGKcHmWolsECxKlTOtP0NVRNGCHbbeiHjjiAqUaRIaV+7XXi8qfdBZKt/KWg9vtyly/Qesf447va9stxyd7i1oQBgU3a7rPoreg1NPOZ4zcuWog8FPGO9FwRr0t2vrBMHlqdMu7zRqYQK7+LN1jjnFfKb7tynAJCktz7ifN1dJYYlJfb5RRAbyE9Ytne/8B+DvF6ewgdjJOa3r5jCpZRoftS1b/d1MP+TrVvMcfp1sXINzt4GeFjwOnQi6fesKOmWxGj7rXx4LfXtqSWZ7mAuGWk0x3NCq9aWxqgSCzT2Kdo7t2HmZxmAkJzv6xsIVY57hQwZev399JAE1iOTUWkiRS7F3sItESIkV+ihu3MwKJfAino3yN8ttT/FLfXwV8dv5lQ24wOdCAgFY81X0pGFk06XnizGIZDk3DbUyVzMfbE9UG2ob1LhkFjfRQkX6NpUpjTp3TCVA7hv23iw7vMLF+sjMdmztVd5/EO+h53hNT3t5AMf+WCqw7lET7K75PbJHukl7+wbW+ZGL7tv4eMtnLm1jJHQadzoD8m6xTWerAL7vuxuzJE76INdkwLXJQVupLUCsW8b4+cIyyp1pWjDBFp4omLHM0yBQp13aSC6W7eU1PoZEnDCevHYFEuhj4gqkqLNWvhK9uABRjqszf4j0zdueRIjnGzKtZkKBDkNaz8KNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AYgdlKG7HOm5FLTz1G9WnvOF2CoKplx8d0gpr4h7C065Mtsun3LvPWKXtoaYNa8yysPT7mTNb0+JUa+dg2/zSwQRBJ7stbDe7I7Z8qM1inzVliJ9s+o5/VrY7iI5JWrkPLZXkRIdfkwIF7mia7O+0/KEnCN7LWGYlV7fRuvN87r8itkSaw2SgMftEoedMGL4CGqN4BtLyGuy4Lf7rAcUc7qS/1rYJwAsiEdObQ/El8OiL2eQfWox96Qm+glxedLK8XEX91Qn3JpHmXIDmXwfvEdkTKocJeN2r5mYolcUGkVZtyoFoCPDwFqxZ3DFN9DaCcfS6lyGuwNZLO6tS694rV6cRIhCRGcgyvYlxDqO+EyMNj2Qt43Yod+mG1NomQCfDbKgUbm1B2pX1LwRUezWh9jkHXsTh7HzP4Gh/X/UNodJlMJvqECgnJuG5NgaVN/O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:50.2498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b203fb4-e1e5-44a2-cb82-08dee8f7bfa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
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

From: Alexander Chechik <alexander.chechik@amd.com>

[Why]
mode_support does not require UCLK pstate today, so later PMO optimization
stages can push a plane's VActive latency-hiding margin below zero without
rechecking that the config still supports UCLK pstate. This can blank the
display on high-bandwidth configs.

[How]
Plumb the PMO-selected per-plane pstate method into mode_support and fail
the config only when UCLK pstate is required (method != na) but not
supported. For planes committed to a vactive method, require a non-negative
VActive latency-hiding margin, and skip the check when all streams are
blanked. No-op the PMO DCN42 pstate test (returning false only on the
initial candidate so the optimize/FAMS2 stage-3 setup still runs), since
reserved time is guaranteed by the override and the vactive margin is now
enforced in core mode_support.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alexander Chechik <alexander.chechik@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |  8 +++++
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 18 +++++++++++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       | 32 ++++++-------------
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 727b01ca18bf..45f1bf5e14bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -554,6 +554,14 @@ bool core_dcn4_mode_support(struct dml2_core_mode_support_in_out *in_out)
 	l->mode_support_ex_params.min_clk_index = in_out->min_clk_index;
 	l->mode_support_ex_params.out_evaluation_info = &in_out->mode_support_result.cfg_support_info.clean_me_up.support_info;
 
+	for (i = 0; i < l->svp_expanded_display_cfg.num_planes; i++) {
+		if (i < in_out->display_cfg->display_config.num_planes)
+			core->clean_me_up.mode_lib.ms.uclk_pstate_switch_modes[i] =
+				in_out->display_cfg->stage3.pstate_switch_modes[i];
+		else
+			core->clean_me_up.mode_lib.ms.uclk_pstate_switch_modes[i] = dml2_pstate_method_na;
+	}
+
 	result = dml2_core_calcs_mode_support_ex(&l->mode_support_ex_params);
 
 	in_out->mode_support_result.cfg_support_info.is_supported = result;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 110ab26a6a39..da9a1c4e2bdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -9637,6 +9637,22 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	DML_LOG_VERBOSE("DML::%s: ROBSupport = %u\n", __func__, mode_lib->ms.support.ROBSupport);
 #endif
 
+	mode_lib->ms.support.global_dram_clock_change_support_required = false;
+
+	if (!display_cfg->overrides.all_streams_blanked) {
+		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+			if (mode_lib->ms.uclk_pstate_switch_modes[k] == dml2_pstate_method_na)
+				continue;
+
+			mode_lib->ms.support.global_dram_clock_change_support_required = true;
+
+			if ((mode_lib->ms.uclk_pstate_switch_modes[k] == dml2_pstate_method_vactive ||
+					mode_lib->ms.uclk_pstate_switch_modes[k] == dml2_pstate_method_fw_vactive_drr) &&
+					mode_lib->ms.VActiveLatencyHidingMargin[k] < 0)
+				mode_lib->ms.support.global_dram_clock_change_supported = false;
+		}
+	}
+
 	/*Mode Support, Voltage State and SOC Configuration*/
 	{
 		if (mode_lib->ms.support.ScaleRatioAndTapsSupport
@@ -9683,6 +9699,8 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			&& mode_lib->ms.support.DCCMetaBufferSizeNotExceeded
 			&& !mode_lib->ms.support.ExceededMALLSize
 			&& mode_lib->ms.support.g6_temp_read_support
+			&& (mode_lib->ms.support.global_dram_clock_change_supported
+				|| !mode_lib->ms.support.global_dram_clock_change_support_required)
 			&& ((!display_cfg->hostvm_enable && !s->ImmediateFlipRequired) || mode_lib->ms.support.ImmediateFlipSupport)) {
 			DML_LOG_VERBOSE("DML::%s: mode is supported\n", __func__);
 			mode_lib->ms.support.ModeSupport = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
index 790aef95caa6..57a6a7d5b740 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
@@ -13,8 +13,6 @@
  * configurations, ensuring p-state watermark support in the blank period only.
  */
 
-static const double MIN_VACTIVE_MARGIN_PCT = 0.25; // We need more than non-zero margin because DET buffer granularity can alter vactive latency hiding
-
 static const struct dml2_pmo_pstate_strategy dcn42_strategy_list_1_display[] = {
 	// VBlank only
 	{
@@ -179,7 +177,7 @@ bool pmo_dcn42_init_for_pstate_support(struct dml2_pmo_init_for_pstate_support_i
 
 	// Figure out which streams can do vactive, and also build up implicit SVP and FAMS2 meta
 	for (stream_index = 0; stream_index < display_config->display_config.num_streams; stream_index++) {
-		if (dcn4_get_vactive_pstate_margin(display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) >= (int)(MIN_VACTIVE_MARGIN_PCT * pmo->soc_bb->power_management_parameters.dram_clk_change_blackout_us))
+		if (dcn4_get_vactive_pstate_margin(display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) >= 0)
 			dcn42_set_bit_in_bitfield(&s->pmo_dcn4.stream_vactive_capability_mask, stream_index);
 	}
 
@@ -259,27 +257,17 @@ bool pmo_dcn42_fams2_optimize_for_pstate_support(struct dml2_pmo_optimize_for_ps
 
 bool pmo_dcn42_test_for_pstate_support(struct dml2_pmo_test_for_pstate_support_in_out *in_out)
 {
-	const struct dml2_pmo_scratch *s = &in_out->instance->scratch;
-	bool p_state_supported = true;
-	unsigned int stream_index;
-
-	if (s->pmo_dcn4.cur_pstate_candidate < 0)
+	/* Return false on the initial candidate (cur_pstate_candidate == -1) so the
+	 * optimization phase runs at least one optimize iteration; otherwise the
+	 * FAMS2/stage-3 setup in the optimize callback is skipped.
+	 */
+	if (in_out->instance->scratch.pmo_dcn4.cur_pstate_candidate < 0)
 		return false;
 
-	for (stream_index = 0; stream_index < in_out->base_display_config->display_config.num_streams; stream_index++) {
-		if (s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.cur_pstate_candidate].per_stream_pstate_method[stream_index] == dml2_pstate_method_vactive) {
-			if (dcn4_get_minimum_reserved_time_us_for_planes(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < (int)in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us ||
-			    dcn4_get_vactive_pstate_margin(in_out->base_display_config, s->pmo_dcn4.stream_plane_mask[stream_index]) < (int)(MIN_VACTIVE_MARGIN_PCT * in_out->instance->soc_bb->power_management_parameters.dram_clk_change_blackout_us)) {
-				p_state_supported = false;
-				break;
-			}
-		} else {
-			p_state_supported = false;
-			break;
-		}
-	}
-
-	return p_state_supported;
+	/* No-op: reserved time is guaranteed by the override and vactive p-state
+	 * margin is now enforced in core mode support.
+	 */
+	return true;
 }
 
 bool pmo_dcn42_initialize(struct dml2_pmo_initialize_in_out *in_out)
-- 
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78BC55822
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8816B10ED02;
	Wed,  5 Aug 2026 06:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgoOm+qn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E0A10ED03
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZRUG470h1VHjbGCprI6y2fm6jA8cEfcGuKHqlnVbxMfWvSk1rX8RNySRr0D6Hb5/HV3tyawYnWwzpxgkd0hQXSfQIy+6knPtUFKmRUBkFdgy3fcq0M0C0Wwsa4lc5y6V6YCnK1AVADGPLCOw4NHKoopyj4j1nm7XqNszK9RxODHWHmblFPA0qO02ePEVAb28iWRwy5cL1IhyELvyvu8p45NqfLvwT2sWFmMat0sClWSQ/2AkgnXGdrQtoaPk1GR3TQM5I0lx/gLx6HSF7AawYsuLIen3XjSEAILERqEaTBPElalXaGqwIDsfsgLiGfNv2cl14DnbfdsQM/YF7vOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7yFJLE0t52Wkk6f8MvoTvA1WmDlWB/5Cs2L3RmVUYI=;
 b=OVNMXxSc9QIoDKKqb65p24TPvNNWjoh6Ltyav7tPdrDbibV4kJu8KLr5fJ2d2bbyHOc4dd5lt0WAmjgxoNbRBv5l9YGZV0BD2e18XhcNdZTU/g7SX0bug4KtQHcJog91Q8EJPHUo4WKYN9qo4IqhQAG0F8RSu2JDQUEvJbdbgxXFblMMrSATHMaEkDtngPzduiErViwjMlbDjTzOG0H087zpxZnqj3yX2C7OLWrpxc7DCCtRr18Lszy0tI97or3VZb5KGi4H17ccXZNxXp5pzfeSY9J2jzsIajvBkXMkfcK19yp0Ef/yvEKLSMAlCOQm1xu0f9oubePx0kZ0U2uojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7yFJLE0t52Wkk6f8MvoTvA1WmDlWB/5Cs2L3RmVUYI=;
 b=xgoOm+qnuvbQS+llSZw1P4uouCwY20ulb7YcXyfh3djWz+W/LaEx1+8I79g5y5npaI+Qx6V2Wog6bQK24GdHwpZyXJ5b7lrlKCcztillkPL+tpkZXkwLlp9SUY99sn4ilDNfx7Ohz0ncWTOgUYSgYl6QXMqgfn8x9aTpvZ9LZZk=
Received: from MN0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:208:530::20)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 06:40:54 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:530:cafe::a4) by MN0PR02CA0030.outlook.office365.com
 (2603:10b6:208:530::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 06:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:53 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:50 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 16/34] drm/amd/display: Decide zstate_support based off Z8
 global support
Date: Wed, 5 Aug 2026 14:36:28 +0800
Message-ID: <20260805063937.2145774-17-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e31d0d-eb79-432a-07fa-08def2bc7fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|3023799007|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: GGLOULpSpP5TBYXVVifOjsnnyPWxttFaaceCg6vCoowqgRBNYnlb5o6OZSERYB03WCAEcjnRiKQ7aTTeY4YA8FXOqUGd1D969ciFwA8wAy+9i27r/+0yblht02lcze8YWOWCqi+keXgyCngnj9MryQwTqiPhS63DCLO/EVrW1E1rlSn+cn/wJizkMuOkppISD457IJ+zx+5wF/rS/Gcdn6VL6I1FNyowdMhwAHoo0/UemHTP9nXPamY//7RdfCplgUYRSikRrwgrSreofygSWiyFIkA8+RmG+fEbF+9xaL+3ZpkXLCB14L5pIt9VWQnfZwh8sYyhRrW9os5Rre5JOEJyuJVvINnGF6cYy/W44NBlBnFYCmpYtDiej2o/9crryhN2Z5B+uYNcS6+xruonK5odmJ0p6ePQxyAL8Xz09yUACGqLwVECtQktO3HSNu0PxrwaoPFz1KAxbglv/gIv+GIvjg297MpEC1MDsNVJBqKgDji+jA3wFYX+I+nAIlUzzlVn0mUZam/dXyUUVwCQE5ZmDutYFo9tG/wWu3samf7z9J/Bu/LrzJRorCMY8CNCkLwXUQHGEbYQ1zQJdqU/27zfVHJM7SHFPNDysNSp/f7ANLN8yjTHxigvuA7qQMLe0RY5eogUhSOlj1BpQEHGdavERF0QCxGsEwSdGY/PzbGogxK4JkdS0SFsRMvAVobFwwTMtkdsqlHdYJQUAtAozA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eOC19J7QaOBBB5P+UnfAKyfIitxIn1mC7LBFAjt0Vt3A+WPvmW3AQ24FvzcOYZ11QM+8iPH8DsYu88kX01Vh/spKB2VVEhPi4hslCQFh7aIxpwyKh7UV0pkNe+oxvEHPoTfijiJtrDip1Pgp0bMFtwgNB4YESlXOfuFoozxaV5dhdep5n1GExi/i4TlT7ZWLoFt9WNBuhYhjDUztPkvWI0d0ef4CGFlsYV/grgKeecl0ikV7f73nb6On35WhdxD6mizZP+H79lGz4OCjRrsE5AxoK5dITCoSc56mBq88rEdSJcYNHcM3X5X4pw4BrMn3CV1CjYKYBdXA+9r1WOocLSpAS7h2MEoxTWi5L1RSh8b6oy/wuhAXhndz/fX6EYqIz73bIpn8suOsH5T20K9r43wMOm6aVkTmgPpPGN6c4G1ILJ3tPJVg1rdomQYUZY7W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:54.5118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e31d0d-eb79-432a-07fa-08def2bc7fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
DC incorrectly reports ZStates NOT supported for eDP panels without
support for PSR or Replay. This is because the zstate_support flag is
populated with supported_in_blank, which is not the correct
interpretation.

Z8 can be entered for a plane when its Z8 stutter enter plus exit time
is covered either during vblank (reserved vblank time is greater than
SREnterPlusExitZ8Time) or during vactive (active clock change latency
hiding minus the Z8StutterEnterPlusExitWatermark is positive). Compute
this per plane in CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(),
and report Z8 as supported only when every non-phantom plane satisfies
at least one of these two cases. Populate z8_stutter.global_support in
mode programming and use it to populate zstate_support.

Assisted-by: Claude:claude-Opus-4.8
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/dml2_0/dml21/dml21_translation_helper.c    |  2 +-
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h   |  1 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c   |  4 ++++
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c    | 15 +++++++++++++++
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.h    |  1 +
 .../dml21/src/dml2_core/dml2_core_shared_types.h  |  2 ++
 6 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index 1b0d55e2d7b0..f4f848d73820 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -999,7 +999,7 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_efficiency = (uint8_t)in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_efficiency;
 	context->bw_ctx.bw.dcn.clk.stutter_efficiency.z8_stutter_period = (int)in_ctx->v21.mode_programming.programming->informative.power_management.z8.stutter_period;
-	context->bw_ctx.bw.dcn.clk.zstate_support = in_ctx->v21.mode_programming.programming->z8_stutter.supported_in_blank; /*ignore meets_eco since it is not used*/
+	context->bw_ctx.bw.dcn.clk.zstate_support = in_ctx->v21.mode_programming.programming->z8_stutter.global_support;
 }
 
 static struct dml2_dchub_watermark_regs *wm_set_index_to_dc_wm_set(union dcn_watermark_set *watermarks, const enum dml2_dchub_watermark_reg_set_index wm_index)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index bf71f4e1a451..c04a4af1f3ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -480,6 +480,7 @@ struct dml2_display_cfg_programming {
 	struct {
 		bool meets_eco; // Stutter cycles will meet Z8 ECO criteria
 		bool supported_in_blank; // Changing to configurations where this is false requires Z8 to be disabled during the transition
+		bool global_support; // Z8 supported in vblank or vactive
 	} z8_stutter;
 
 	struct dml2_dchub_global_register_set global_regs;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index 6ea36aedcf20..a040c3f47337 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -701,6 +701,10 @@ bool core_dcn4_mode_programming(struct dml2_core_mode_programming_in_out *in_out
 	result = dml2_core_calcs_mode_programming_ex(&l->mode_programming_ex_params);
 
 	if (result) {
+		// Populate the global Z8 stutter support (common to all packing paths)
+		dml2_core_calcs_get_z8_stutter_support(&core->clean_me_up.mode_lib,
+			&in_out->programming->z8_stutter.global_support);
+
 		// If the input display configuration contains implict SVP, we need to use a special packer
 		if (in_out->display_cfg->display_config.overrides.enable_subvp_implicit_pmo) {
 			pack_mode_programming_params_with_implicit_subvp(core, in_out->display_cfg, &l->svp_expanded_display_cfg, in_out->programming, &core->scratch);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 72acf12e9251..d943cc8bf60e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -6876,6 +6876,8 @@ static void CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 
 	*p->global_fclk_change_supported = true;
 	*p->global_dram_clock_change_supported = true;
+	if (p->global_z8_stutter_supported)
+		*p->global_z8_stutter_supported = true;
 
 	for (unsigned int k = 0; k < p->NumberOfActiveSurfaces; ++k) {
 		double h_total = (double)p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[k].stream_index].timing.h_total;
@@ -6990,6 +6992,12 @@ static void CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
 		if (p->DRAMClockChangeSupport[k] == dml2_pstate_change_unsupported)
 			*p->global_dram_clock_change_supported = false;
 
+		if (p->global_z8_stutter_supported &&
+		    !dml_is_phantom_pipe(&p->display_cfg->plane_descriptors[k]) &&
+		    !(reserved_vblank_time_us > p->mmSOCParameters.SREnterPlusExitZ8Time) &&
+		    !((s->ActiveClockChangeLatencyHiding - p->Watermark->Z8StutterEnterPlusExitWatermark) > 0))
+			*p->global_z8_stutter_supported = false;
+
 		s->dst_y_pstate = (unsigned int)(math_ceil2((p->mmSOCParameters.DRAMClockChangeLatency + p->mmSOCParameters.UrgentLatency) / (h_total / pixel_clock_mhz), 1));
 		s->src_y_pstate_l = (unsigned int)(math_ceil2(s->dst_y_pstate * v_ratio, p->SwathHeightY[k]));
 		s->src_y_ahead_l = (unsigned int)(math_floor2(p->DETBufferSizeY[k] / p->BytePerPixelDETY[k] / p->SwathWidthY[k], p->SwathHeightY[k]) + s->LBLatencyHidingSourceLinesY[k]);
@@ -8027,6 +8035,7 @@ static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_inter
 	CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &s->dummy_single[0]; // double *MaxActiveFCLKChangeLatencySupported
 	CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport;
 	CalculateWatermarks_params->g6_temp_read_support = &mode_lib->ms.support.g6_temp_read_support;
+	CalculateWatermarks_params->global_z8_stutter_supported = NULL; // only consumed by mode programming
 	CalculateWatermarks_params->VActiveLatencyHidingMargin = mode_lib->ms.VActiveLatencyHidingMargin;
 	CalculateWatermarks_params->VActiveLatencyHidingUs = mode_lib->ms.VActiveLatencyHidingUs;
 
@@ -11883,6 +11892,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &mode_lib->mp.MaxActiveFCLKChangeLatencySupported;
 		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->mp.USRRetrainingSupport;
 		CalculateWatermarks_params->g6_temp_read_support = &mode_lib->mp.g6_temp_read_support;
+		CalculateWatermarks_params->global_z8_stutter_supported = &mode_lib->mp.global_z8_stutter_supported;
 		CalculateWatermarks_params->VActiveLatencyHidingMargin = 0;
 		CalculateWatermarks_params->VActiveLatencyHidingUs = 0;
 
@@ -12909,6 +12919,11 @@ void dml2_core_calcs_get_mcif_arb_params(const struct dml2_core_internal_display
 	out->wm_regs[0].temp_read_or_ppt = (unsigned int)(mode_lib->mp.Watermark.writeback_temp_read_or_ppt_watermark_us * 1000.0);
 }
 
+void dml2_core_calcs_get_z8_stutter_support(const struct dml2_core_internal_display_mode_lib *mode_lib, bool *out)
+{
+	*out = mode_lib->mp.global_z8_stutter_supported;
+}
+
 void dml2_core_calcs_get_pipe_regs(const struct dml2_display_cfg *display_cfg,
 	struct dml2_core_internal_display_mode_lib *mode_lib,
 	struct dml2_dchub_per_pipe_register_set *out, int pipe_index)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
index 3249f6bcf7bc..e0e397b14bb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.h
@@ -20,6 +20,7 @@ unsigned int dml2_core_calcs_mode_support_ex(struct dml2_core_calcs_mode_support
 bool dml2_core_calcs_mode_programming_ex(struct dml2_core_calcs_mode_programming_ex *in_out_params);
 void dml2_core_calcs_get_watermarks(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_dchub_watermark_regs *out);
 void dml2_core_calcs_get_mcif_arb_params(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_mcif_global_register_set *out);
+void dml2_core_calcs_get_z8_stutter_support(const struct dml2_core_internal_display_mode_lib *mode_lib, bool *out);
 void dml2_core_calcs_get_arb_params(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_display_arb_regs *out);
 void dml2_core_calcs_get_pipe_regs(const struct dml2_display_cfg *dml2_display_cfg, struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_dchub_per_pipe_register_set *out, int pipe_index);
 void dml2_core_calcs_get_stream_programming(const struct dml2_core_internal_display_mode_lib *mode_lib, struct dml2_per_stream_programming *out, int pipe_index);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 8a371bd1a7a5..0f1f58471cff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1039,6 +1039,7 @@ struct dml2_core_internal_mode_program {
 	double MaxActiveFCLKChangeLatencySupported;
 	bool USRRetrainingSupport;
 	bool g6_temp_read_support;
+	bool global_z8_stutter_supported;
 	enum dml2_pstate_change_support FCLKChangeSupport[DML2_MAX_PLANES];
 	enum dml2_pstate_change_support DRAMClockChangeSupport[DML2_MAX_PLANES];
 	enum dml2_pstate_change_support temp_read_or_ppt_support[DML2_MAX_PLANES];
@@ -1841,6 +1842,7 @@ struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_param
 	bool *g6_temp_read_support;
 	enum dml2_pstate_change_support *temp_read_or_ppt_support;
 	bool *global_temp_read_or_ppt_supported;
+	bool *global_z8_stutter_supported;
 };
 
 struct dml2_core_calcs_CalculateSwathAndDETConfiguration_params {
-- 
2.43.0


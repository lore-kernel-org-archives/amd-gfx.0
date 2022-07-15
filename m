Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF66C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7383A10FB78;
	Sat, 16 Jul 2022 14:36:06 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF1C10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAi0otaJtYV9pwxtnR6UfL5A/AUu1RmmZnBWmRozN1TQNGYHWTwzDMWI2Y/mN/DzjhGqrtWRFR44KFeJc5g4gEg49AwDGkxZdSpk4OjACW/ioaSRqcALcy5AJrZ3t6NfIn0p4EJkMaubEXJJeI2mSjVN46DnSku8sh4l2iIC2jI8x6qXf5mCduLhRZCud34Fk4w+GQuBor6yVPUbC80JyAficPIJYW1FVK5NZtbziSg15RnlTSba6rK2MZsV8qoBAMgYy/m8EsKUiANvIpuyqcwOTAZw3FsDUtct0IzN6Vz2K9RL0Q1W4jIrKDVqgiBznzu5bInFWt7A2Gyz3VurGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qj+ZuB1asxic7ZaGndVB4s26C+XvY9l1WcmiQAVykQ=;
 b=DlzlSk6r9OWf2TFpH3FOkkyUbPpnzbekyISqd3WQLm35S/EUDmoAPT1u81ItBPq/tz/l0gxuC3mzehCqc3ihqgbYtOaZ9LDPt13xjIThKM61gX88vaM9BaEr0yc7y4FXrNzClmcG57QGW3gPoWg2SOK4X4CIsBiwk90zb45Yj7GpYCKMG0IlT/drtrgfw35jk8oZrQXqsp6Rq4NANPkExipdRkg1mxnIr3ORjvcDtQVk8xUauUwPDszTYZrDJYddBw4fcfr0FEBnUAdAAotdVhmjWG097XF/q4soUCPNLo+CuIxfYMtN/lzEWhlRb1yfN/WgtZ0z/sQISt5KQtUosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qj+ZuB1asxic7ZaGndVB4s26C+XvY9l1WcmiQAVykQ=;
 b=1fzb9+24QspVb7iqvJSAETFDPo4RXyajnzxBV0WaepQ8Avcj1x2htuIj9iv6BaoIoD2UsZchspuNANlsNYwg/lJe4co/hKTRDXcFPwNaBeP0lchYX6rFuQ78e9mxhI7bz61OUSD9MiecvBvxqniQOzAYokALC/TuCyRp6Jcq8Vo=
Received: from DM6PR07CA0068.namprd07.prod.outlook.com (2603:10b6:5:74::45) by
 BN6PR12MB1346.namprd12.prod.outlook.com (2603:10b6:404:1e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Fri, 15 Jul 2022 18:17:54 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::dc) by DM6PR07CA0068.outlook.office365.com
 (2603:10b6:5:74::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:52 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/31] drm/amd/display: Move wm and dlg calculation to FPU code
Date: Fri, 15 Jul 2022 14:16:58 -0400
Message-ID: <20220715181705.1030401-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9999bdd6-05c6-4c10-3a4f-08da668e55fe
X-MS-TrafficTypeDiagnostic: BN6PR12MB1346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OveCqi9QJBHurwzHeJ2xAa95vyWCaIjYGcRPG/zK7q1z+C0Flf3uB5Umit+BmBxRVPjX4jQ7qH97vLPrx/g/o8eLDypCBHfyuiWIdsf44B3Y2lR0c9e8Y9zP5FJo7VnndpU17a8Wy0sJyaH3GJeDx8OwsFlEV65j8HItSTCjtkTJlDOTwQC/bAOZM1U2wh8/Z3Zrdc9kj5XVDu7OTs903KSakW2T+VEmejpVrr4e6pEdMCVWuO/Ex4YEfDuoCmmGsqIAoZOwRGtD/tiGETEFcQl7QDDNZnEk+o9ZmlBveRdnfLtWqBIhuOIjOJSP25w098gGLxNvWJyimps+nO3fSIm69J95JE8peCHGU8MfgKpL0yMWeWu6Xen8mPJ1rA3INtSSNAYcqjov2fTNqRN2dBGgepu8ET6ONyC1aVoRlyE4rlXeo6x1s9blKcy8/DqoVuG+z4LFsl87EhYbLzhvo58qUEdzJ/F1y2qPa0HKv4F+6CGxlqhU1JZqUEj62Qst1/C5b8C2TFwHoEjWKiECMV6F3vxQZCjNDkvz4TYaNDByqNOBnIXKBfsc+9Vut/M9o/lDgq5aKm02Sx3tPacw36/FkVOko20rg6NBw40aLVyOxkJSbLXjWzPQ8r5mzH7NHmYsixCfF1eHAdafgvk36XvIOHu1YKrbrFBtHRi1TEeM16v7273rS50XpasDyJA1xFUfWyU+8rC0apZWzg2FR6bDhJdVVWgHwoNKJNBVn/pAsyMBPg9qr0UWSz9GbF0tByif2lkwHua4vkEJkZUAT/CdD64zEjBKy09OmpvjfOexQUObJTIfp6ETocKGtebW69gbMspB/JtH6kGmQ4edn4ct804knvta0BzoUsKfmY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(30864003)(478600001)(2616005)(426003)(336012)(47076005)(356005)(2906002)(54906003)(6916009)(316002)(40480700001)(186003)(82740400003)(40460700003)(1076003)(41300700001)(4326008)(8676002)(83380400001)(8936002)(70586007)(70206006)(82310400005)(36756003)(26005)(5660300002)(81166007)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:53.9366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9999bdd6-05c6-4c10-3a4f-08da668e55fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1346
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move dcn32_calculate_wm_and_dlg from dcn32 resources to the FPU code.
Additionally, this commit adds an interface to it.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 196 +-----------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 185 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   5 +
 3 files changed, 195 insertions(+), 191 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index d508909ff7a9..45768eff9315 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2281,187 +2281,6 @@ int dcn32_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-void dcn32_calculate_wm_and_dlg_fp(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
-{
-	int i, pipe_idx, vlevel_temp = 0;
-	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
-	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
-	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
-			dm_dram_clock_change_unsupported;
-
-	// Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK
-	if (!pstate_en && dcn32_subvp_in_use(dc, context)) {
-		context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
-		pstate_en = true;
-	}
-
-	/* Set B:
-	 * For Set B calculations use clocks from clock_limits[2] when available i.e. when SMU is present,
-	 * otherwise use arbitrary low value from spreadsheet for DCFCLK as lower is safer for watermark
-	 * calculations to cover bootup clocks.
-	 * DCFCLK: soc.clock_limits[2] when available
-	 * UCLK: soc.clock_limits[2] when available
-	 */
-	if (dcn3_2_soc.num_states > 2) {
-		vlevel_temp = 2;
-		dcfclk = dcn3_2_soc.clock_limits[2].dcfclk_mhz;
-	} else
-		dcfclk = 615; //DCFCLK Vmin_lv
-
-	pipes[0].clks_cfg.voltage = vlevel_temp;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
-	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel_temp].socclk_mhz;
-
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.fclk_change_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.b.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	/* Set D:
-	 * All clocks min.
-	 * DCFCLK: Min, as reported by PM FW when available
-	 * UCLK  : Min, as reported by PM FW when available
-	 * sr_enter_exit/sr_exit should be lower than used for DRAM (TBD after bringup or later, use as decided in Clk Mgr)
-	 */
-
-	if (dcn3_2_soc.num_states > 2) {
-		vlevel_temp = 0;
-		dcfclk = dc->clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
-	} else
-		dcfclk = 615; //DCFCLK Vmin_lv
-
-	pipes[0].clks_cfg.voltage = vlevel_temp;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
-	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel_temp].socclk_mhz;
-
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.fclk_change_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.d.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	/* Set C, for Dummy P-State:
-	 * All clocks min.
-	 * DCFCLK: Min, as reported by PM FW, when available
-	 * UCLK  : Min,  as reported by PM FW, when available
-	 * pstate latency as per UCLK state dummy pstate latency
-	 */
-	// For Set A and Set C use values from validation
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk_from_validation;
-	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
-
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		unsigned int min_dram_speed_mts_margin = 160;
-
-		if ((!pstate_en))
-			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
-
-		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
-		for (i = 3; i > 0; i--)
-			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
-				break;
-
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
-		context->bw_ctx.dml.soc.dummy_pstate_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
-		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	if ((!pstate_en) && (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid)) {
-		/* The only difference between A and C is p-state latency, if p-state is not supported
-		 * with full p-state latency we want to calculate DLG based on dummy p-state latency,
-		 * Set A p-state watermark set to 0 on DCN32, when p-state unsupported, for now keep as DCN32.
-		 */
-		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
-	} else {
-		/* Set A:
-		 * All clocks min.
-		 * DCFCLK: Min, as reported by PM FW, when available
-		 * UCLK: Min, as reported by PM FW, when available
-		 */
-		dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
-		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-		context->bw_ctx.bw.dcn.watermarks.a.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	}
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
-		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-		if (dc->config.forced_clocks) {
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
-		}
-		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
-		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
-
-		pipe_idx++;
-	}
-
-	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
-
-	dcn32_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-
-	if (!pstate_en)
-		/* Restore full p-state latency */
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
-				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
-}
-
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -2489,18 +2308,13 @@ static void dcn32_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
 		(dcn3_2_soc.return_bus_width_bytes * (dcn3_2_soc.max_avg_sdp_bw_use_normal_percent / 100));
 }
 
-void dcn32_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
+void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int pipe_cnt,
+				int vlevel)
 {
     DC_FP_START();
-    dcn32_calculate_wm_and_dlg_fp(
-		dc, context,
-		pipes,
-		pipe_cnt,
-		vlevel);
+    dcn32_calculate_wm_and_dlg_fpu(dc, context, pipes, pipe_cnt, vlevel);
     DC_FP_END();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 82d801933aec..353d3a74e40b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1058,3 +1058,188 @@ void dcn32_full_validate_bw_helper(struct dc *dc,
 	}
 }
 
+void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int pipe_cnt,
+				int vlevel)
+{
+	int i, pipe_idx, vlevel_temp = 0;
+	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
+	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
+			dm_dram_clock_change_unsupported;
+
+	dc_assert_fp_enabled();
+
+	// Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK
+	if (!pstate_en && dcn32_subvp_in_use(dc, context)) {
+		context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
+		pstate_en = true;
+	}
+
+	/* Set B:
+	 * For Set B calculations use clocks from clock_limits[2] when available i.e. when SMU is present,
+	 * otherwise use arbitrary low value from spreadsheet for DCFCLK as lower is safer for watermark
+	 * calculations to cover bootup clocks.
+	 * DCFCLK: soc.clock_limits[2] when available
+	 * UCLK: soc.clock_limits[2] when available
+	 */
+	if (dcn3_2_soc.num_states > 2) {
+		vlevel_temp = 2;
+		dcfclk = dcn3_2_soc.clock_limits[2].dcfclk_mhz;
+	} else
+		dcfclk = 615; //DCFCLK Vmin_lv
+
+	pipes[0].clks_cfg.voltage = vlevel_temp;
+	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
+	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel_temp].socclk_mhz;
+
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us;
+		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.fclk_change_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us;
+	}
+	context->bw_ctx.bw.dcn.watermarks.b.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.b.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	/* Set D:
+	 * All clocks min.
+	 * DCFCLK: Min, as reported by PM FW when available
+	 * UCLK  : Min, as reported by PM FW when available
+	 * sr_enter_exit/sr_exit should be lower than used for DRAM (TBD after bringup or later, use as decided in Clk Mgr)
+	 */
+
+	if (dcn3_2_soc.num_states > 2) {
+		vlevel_temp = 0;
+		dcfclk = dc->clk_mgr->bw_params->clk_table.entries[0].dcfclk_mhz;
+	} else
+		dcfclk = 615; //DCFCLK Vmin_lv
+
+	pipes[0].clks_cfg.voltage = vlevel_temp;
+	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
+	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel_temp].socclk_mhz;
+
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us;
+		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.fclk_change_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us;
+	}
+	context->bw_ctx.bw.dcn.watermarks.d.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.d.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	/* Set C, for Dummy P-State:
+	 * All clocks min.
+	 * DCFCLK: Min, as reported by PM FW, when available
+	 * UCLK  : Min,  as reported by PM FW, when available
+	 * pstate latency as per UCLK state dummy pstate latency
+	 */
+
+	// For Set A and Set C use values from validation
+	pipes[0].clks_cfg.voltage = vlevel;
+	pipes[0].clks_cfg.dcfclk_mhz = dcfclk_from_validation;
+	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
+
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
+		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		unsigned int min_dram_speed_mts_margin = 160;
+
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] ==
+				dm_dram_clock_change_unsupported)
+			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
+
+		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
+		for (i = 3; i > 0; i--)
+			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
+				break;
+
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
+		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
+	}
+
+	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	if ((!pstate_en) && (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid)) {
+		/* The only difference between A and C is p-state latency, if p-state is not supported
+		 * with full p-state latency we want to calculate DLG based on dummy p-state latency,
+		 * Set A p-state watermark set to 0 on DCN30, when p-state unsupported, for now keep as DCN30.
+		 */
+		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0;
+	} else {
+		/* Set A:
+		 * All clocks min.
+		 * DCFCLK: Min, as reported by PM FW, when available
+		 * UCLK: Min, as reported by PM FW, when available
+		 */
+		dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
+		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.fclk_pstate_change_ns = get_fclk_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.usr_retraining_ns = get_usr_retraining_watermark(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	}
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
+		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
+		if (dc->config.forced_clocks) {
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
+		}
+		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
+		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
+
+		pipe_idx++;
+	}
+
+	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
+
+	dcn32_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+
+	if (!pstate_en)
+		/* Restore full p-state latency */
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 29fb6b1bc17f..c7602f084be2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -65,4 +65,9 @@ void dcn32_full_validate_bw_helper(struct dc *dc,
 				   bool *merge,
 				   int *pipe_cnt);
 
+void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int pipe_cnt,
+				int vlevel);
+
 #endif
-- 
2.37.0


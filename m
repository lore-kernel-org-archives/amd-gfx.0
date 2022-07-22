Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E317CC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825288F844;
	Fri, 22 Jul 2022 20:43:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F938F844
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7pnqRy1DTz45jHAAkpgbZOVpSyc+SY3s6IwGWV6TY+Hi0Tp6keRA6oIiopH8ZDeqL5Y8vykpi3T2fXuFkHnftNugi4b1Iv7iLCanEKhf86o7qoWX1zKKDHbHpp4nDBmuBsI2VZSyn2xt2XrTXwLSF1xC9UD9u1oGh9/JJvMPihP4JwYFfgZtK/fbTKHTyAsHNMJztsS5dKeoN8peUADgcQfEkdldy+jFQKkEcMI6b2QXZPDp2l11pf4yNtGXK04ORymmZ6r30uJhsjxMhWR6Cecn+DueEpWyUb8/rgeOJjXuSsQ0TBzbVj64BTlJ0yVfsI2XmQ0nioLxnUwqRzqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sCOPj0VCBLb/DuSbTeq0r2NhfUtLbpNCQ9pPxghBPo=;
 b=extatO47msZPZ6IaPp0eCquZoAVxSR6PsL4f3HIz6OhlxuSqiQkJ3lu6uOxOIMr8DQ+tTgzuxv+qu1+5VealXuUivi4IKxdL5ePeEcHP22a9k92CNiHRYw/kdXX6ROP8lU4Oqjirs4eCxBIMugiE32DNsc8WwOIkz9yudq/B3IEC1Mj79g+g16fThuagYzsretw5O4Ez0OdBN9+n5zO9UysnHFAH0qpgobf4qfPxUHA2Bf4IQJoC7iFoj5mKvJAuJbaC9Nfp+JTFwrd+cUO4jaylzXQ/4mdqMOoYL3b09E83D2JmDLg0WcoHmp2MmE3yDqBIjGLZ/8AR/edfK1NvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sCOPj0VCBLb/DuSbTeq0r2NhfUtLbpNCQ9pPxghBPo=;
 b=PZT11DVLekfpUSOfoSDFRBK5+v9HokxNLnI7oT59fNVtK6izEq1ingp7NXW6nhGE9JH5cZNOE2AC/MhRK20IyVHPNfbiTFiZ4EgSDp5CToeovj9w7bnJSyFwnlzN8KWwjLprdhX3tj4u5Y8tG608vfZ6RlzxW9vXlBYFnAdRfw0=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by DM6PR12MB2923.namprd12.prod.outlook.com (2603:10b6:5:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 20:43:03 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::f4) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Fri, 22 Jul 2022 20:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:43:03 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:43:01 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/31] drm/amd/display: Add reinstate dram in the FPO logic
Date: Fri, 22 Jul 2022 14:31:31 -0600
Message-ID: <20220722203137.4043516-26-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05fcc0a4-c7ca-42ad-6e6e-08da6c22c63a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nq+K+RRTSMrYs3Bi7Og12iKRv/ojpetoAuXZS8mcej4qQ+sS5UluMOxrA4/jxbixC0gf+jd67F9+g7TvtmrJcJ7WHf+TNC9oz17E1GzvqY48jM5UI0BkhfWGCIGLUOtHIP1ZvJ6JWZ4VR3+CSnoAZacDKXylEx/ykV2Ut+UHyLdUynMT0hsVl/4OsnRj5A3XKz8VPkd9c6G2UdGfScFtKpILmDICSF1H6v62ngB46jKEOZH2RtGOX/j1oM/kl1pDoQbEFxflJO6UNTtC/V2g0pJfGk/eZk4Sux0xvVTSUMiUls5p6riT0CeTPmroo3mbUSu+e3bRB5bnL9GfS3f08F6+Z8KlMz8tDSeAM8+759OxuMBzSA/mkkgog6H++vC3IO9O7ZU+Lo1XMN0AZNVeiQH/JqRhTiF3Fmz3HHtAYAPG8IJmeBhown9Luq72UdNaq+RU/Nsyk9CNKagm1ADhbwXpasgL+3we+WCp/PzIvP1Po2lDYRtglE467QFAYYTK7P/rYRKk3z8QA2NCm7isjxVx19CCkuXjrJSqn1pgo7VR+DgfPWkBzDh9UJ47dYQnpdSdzchaeC0rM0F9N4Nf93cvt/aTLP3Dl3kRoM9rdvmDC06DZ0WWG1EMhTNouPH4uuJLE0sEelveOUsG7wEo6tWziNYySekrssf32H5xOQjm+8L/y+DFaRK3G+0JthE/UpfDVDIbgW/A0oGwfpYXpaH1MVWwBxreEgLH5iaNlNyPRBlIQDx+xuwQVyfxIAKydCPcJFNst3ikK1N4wg17eWdUuOnvZetCFFTQI16k9j6vwvB91datIuQNvdNcwHkWo22T3fPZwaeIzAPWtOOJ0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(2906002)(478600001)(7696005)(26005)(41300700001)(6666004)(44832011)(36756003)(82310400005)(81166007)(40480700001)(356005)(70206006)(83380400001)(8676002)(86362001)(2616005)(1076003)(426003)(40460700003)(36860700001)(336012)(82740400003)(8936002)(5660300002)(4326008)(16526019)(70586007)(186003)(54906003)(6916009)(47076005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:43:03.5658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fcc0a4-c7ca-42ad-6e6e-08da6c22c63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2923
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

In order to handle FPO correctly, we need to reinstate the dram values.
This function adds the required code to handle the vblank stretch and
the dram calculation.

Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 67 ++++++++++++++++---
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 3330a1026fa5..7d063c7d6a4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -99,6 +99,9 @@ enum dc_status dcn30_add_stream_to_ctx(
 
 void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
+bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
 void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
+int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel);
 
 #endif /* _DCN30_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9175fe1f9be3..01e272f0bb05 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -30,6 +30,7 @@
 #include "display_mode_vba_util_32.h"
 // We need this includes for WATERMARKS_* defines
 #include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
+#include "dcn30/dcn30_resource.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1597,6 +1598,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
 			dm_dram_clock_change_unsupported;
+	unsigned int dummy_latency_index = 0;
+	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
+	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+	unsigned int min_dram_speed_mts_margin;
 
 	dc_assert_fp_enabled();
 
@@ -1606,6 +1611,32 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		pstate_en = true;
 	}
 
+	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+
+	if (!pstate_en) {
+		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
+		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
+			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
+
+		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+			dummy_latency_index = dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
+				context, pipes, pipe_cnt, vlevel);
+
+			/* After calling dcn30_find_dummy_latency_index_for_fw_based_mclk_switch
+			 * we reinstate the original dram_clock_change_latency_us on the context
+			 * and all variables that may have changed up to this point, except the
+			 * newly found dummy_latency_index
+			 */
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+					dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
+			dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+			pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] !=
+					dm_dram_clock_change_unsupported;
+		}
+	}
+
 	/* Set B:
 	 * For Set B calculations use clocks from clock_limits[2] when available i.e. when SMU is present,
 	 * otherwise use arbitrary low value from spreadsheet for DCFCLK as lower is safer for watermark
@@ -1687,19 +1718,33 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-		unsigned int min_dram_speed_mts_margin = 160;
+		min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		min_dram_speed_mts_margin = 160;
 
-		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] ==
-				dm_dram_clock_change_unsupported)
-			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+			dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
 
-		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
-		for (i = 3; i > 0; i--)
-			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
-				break;
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] ==
+			dm_dram_clock_change_unsupported) {
+			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries - 1;
+
+			min_dram_speed_mts =
+				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
+		}
+
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+			/* find largest table entry that is lower than dram speed,
+			 * but lower than DPM0 still uses DPM0
+			 */
+			for (dummy_latency_index = 3; dummy_latency_index > 0; dummy_latency_index--)
+				if (min_dram_speed_mts + min_dram_speed_mts_margin >
+					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dram_speed_mts)
+					break;
+		}
+
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+			dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
 		context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
@@ -1770,6 +1815,8 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+		dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(dc, context);
 }
 
 static void dcn32_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-- 
2.37.1


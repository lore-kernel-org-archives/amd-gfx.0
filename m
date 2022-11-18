Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC05C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDF910E78B;
	Fri, 18 Nov 2022 16:59:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D55710E78B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGcSwQxE8e/SpltpdGVpBwdkw6G25h0rxStvrROJugf98U1CsynCgS/DrzIzcfL8LPvl87QAUgFGmAkMfp7d8KunVjnpxr3yf3D6b729kItCqt01GAor2ZhS8OMtQWxJmrWYPm227p0cwRA0FE+pqiKg3c4O/8ipt67WY1XT1r/dptSZdmxILUcCDMUMucVXfj2clqMSsSgc+OpXgmbNfc3FUbGlkfFVySKTzMA4fY8PYYmSpnLws7wWTr8rS+nJZIn0XX9JLofrG7C9ZbIb01KbKf7tEPa49eI+cbSJrQNcvE4IIJkEONzZzUOF0E2HVCm1TzcoMxtp68aQX8cgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzu+MnmrlFc13rK2nc5u6UY+KKfiQzBXaLc0d9m+OdI=;
 b=fkjjgmV/AUH38brMwIfqXr3k5RZyFjUVWk4JoRkz5Z9DamlVHin+wAlsmqZW1d4NMjL/ht1uda59Bttf/wNne7gl2fLzLePIuIVRe7kNH17I1f9g8fLCQnU1nVQqTayrJP0TKK0XN6kicaqe4TBENz6OPlRVf/QHRPXe3S1r+G2+1hhbAVs2S2jG3GLuxXhcsdrpCZU3+fDsTGG1zyy89CsQT05ChxI//PL89cnv5dzAz8fowtLOdW/340mctHRBLi9zO5YOZ91Bl1ioib4df2edEtVKs0i7cEGpXwDeB9KANhjxYrgBHl72tTgGGzo2yAWlnkOIMmvhakVCjuOl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzu+MnmrlFc13rK2nc5u6UY+KKfiQzBXaLc0d9m+OdI=;
 b=aciJfWe9/Dh09Oan+5tJ+Aui1vBdXhbiH+0kSdFsBvJrpPmXgckhfRT3zm5GNRsFOQbIGDnqLwnqSE6Wyx4XacU/Cgmv3PqcJn1G6nsrvv4BAJDvNGlCnd0ksWeQnvgMm05u5mupccNEq/0B6qg855JMCCbsASg/52y/hPJe8W0=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 18 Nov
 2022 16:59:52 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::96) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:52 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 08:59:51 -0800
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:48
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/22] drm/amd/display: Use dummy pstate latency for subvp
 when needed on dcn32
Date: Fri, 18 Nov 2022 20:59:21 +0800
Message-ID: <20221118125935.4013669-9-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: d88c22bb-b5e2-4b1a-8eb1-08dac9864fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kl1uTL5p8vubKk0ObaUGoACv20D4zXZLPYLyYd2GQ/CXh3CMUaWj+uJRIgAsbr2s55rWsGX1UGqgaAIF8xDvqM0AW4Ul+JHbxUpM+1WZOCMPOZTu9wrb80wyTDEWWHhSKn2/Tja0FO6Hgoa1nlg1cpcXB4sIU3PfRzkkdedn1DhoLek5OUCYs3TuNIF+L9kr70ULoxNdsRJZ1JIJoBHa/2KuqX87s+Pyl875Jqve/vwpLZxrgjQ7xHwN2IPeglKgvQLHwmXss2VfdKcplchmRXizSVPt8T4adGvI6FpomkgdqotRNRJbqcoGE7EsAqj3AUnPVo3yt1ZzpiqhD8hfpIK3Pwqx02k0YJn1uDuUZqfnSdJt9uVdy+Lwf3obYG+Qwe7defdW6Kcp9PIBqUFwhyOdlFGYnw9Xcam/99Mp/n+aYSSeMGH8S1Mkebp9oNZdcNdh1DbwcEXrrhRSOu4y8lYteVkwIBj8fo3JanYCP/ynR60Seu1Xv4p19+DJXwsLJg4VNCv+HRGUZWxDKXkYpxo4n/7PqtRXj1Oi/7mziObNJ4jGTrSglygFhuz7s2Pw9eZOh6KkCmzjYVDj7YFreGg+SYkaqoJTJ1/ZdRmpe7v3I+4zHbyH7ZXJQcCX/tcifD9eKUXNvVyWuM+C/cc3SgxgWdrjc06wU3/emjk7wvnkuT3bD6bQQVajofXPfWLYS44G+BvPM5X/STl1Wu6yP5JM3HmxQYzMWnqOxLG5ajY+g2vJyOXIA5zSo0HK9B10F2RwFDJ0PO0LvWwDbvTf1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(478600001)(186003)(26005)(8936002)(8676002)(5660300002)(4326008)(70206006)(47076005)(36756003)(41300700001)(426003)(40480700001)(70586007)(2616005)(336012)(316002)(86362001)(82740400003)(36860700001)(2906002)(356005)(81166007)(40460700003)(82310400005)(1076003)(83380400001)(6666004)(54906003)(7696005)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:52.5992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88c22bb-b5e2-4b1a-8eb1-08dac9864fba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
Prefetch is not budgetting time for dummy pstate when using subvp and low uclk.

[HOW?]
Override fclk change latency to use dummy pstate latency when calculating
prefetch schedule for subvp configs with low uclk.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 61 +++++++++++++++----
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 61dbfa95eaa4..c881c523c37a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -256,16 +256,24 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 							    int vlevel)
 {
 	const int max_latency_table_entries = 4;
-	const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	int dummy_latency_index = 0;
+	enum clock_change_support temp_clock_change_support = vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
 
 	while (dummy_latency_index < max_latency_table_entries) {
+		if (temp_clock_change_support != dm_dram_clock_change_unsupported)
+			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 		dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
 
+		/* for subvp + DRR case, if subvp pipes are still present we support pstate */
+		if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported &&
+				dcn32_subvp_in_use(dc, context))
+			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
+
 		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
 				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported)
 			break;
@@ -1141,7 +1149,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 				context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final ==
 					dm_prefetch_support_uclk_fclk_and_stutter) {
 				context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
-								dm_prefetch_support_stutter;
+								dm_prefetch_support_fclk_and_stutter;
 				/* There are params (such as FabricClock) that need to be recalculated
 				 * after validation fails (otherwise it will be 0). Calculation for
 				 * phantom vactive requires call into DML, so we must ensure all the
@@ -1816,14 +1824,38 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	unsigned int dummy_latency_index = 0;
 	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+	bool subvp_in_use = dcn32_subvp_in_use(dc, context);
 	unsigned int min_dram_speed_mts_margin;
+	bool need_fclk_lat_as_dummy = false;
+	bool is_subvp_p_drr = true;
 
 	dc_assert_fp_enabled();
 
-	// Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK
-	if (!pstate_en && dcn32_subvp_in_use(dc, context)) {
-		context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
-		pstate_en = true;
+	/* need to find dummy latency index for subvp */
+	if (subvp_in_use) {
+		/* Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK */
+		if (!pstate_en) {
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
+			pstate_en = true;
+			is_subvp_p_drr = true;
+		}
+		dummy_latency_index = dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
+						context, pipes, pipe_cnt, vlevel);
+
+		/* For DCN32/321 need to validate with fclk pstate change latency equal to dummy so prefetch is
+		 * scheduled correctly to account for dummy pstate.
+		 */
+		if (context->bw_ctx.dml.soc.fclk_change_latency_us < dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us) {
+			need_fclk_lat_as_dummy = true;
+			context->bw_ctx.dml.soc.fclk_change_latency_us =
+					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
+		}
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+							dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+		if (is_subvp_p_drr) {
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
+		}
 	}
 
 	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
@@ -1847,9 +1879,11 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 			/* For DCN32/321 need to validate with fclk pstate change latency equal to dummy so
 			 * prefetch is scheduled correctly to account for dummy pstate.
 			 */
-			if (dummy_latency_index == 0)
+			if (context->bw_ctx.dml.soc.fclk_change_latency_us < dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us) {
+				need_fclk_lat_as_dummy = true;
 				context->bw_ctx.dml.soc.fclk_change_latency_us =
 						dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
+			}
 			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
 			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 			dcfclk_from_fw_based_mclk_switching = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
@@ -1957,7 +1991,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
 		}
 
-		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_in_use) {
 			/* find largest table entry that is lower than dram speed,
 			 * but lower than DPM0 still uses DPM0
 			 */
@@ -2037,7 +2071,8 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && dummy_latency_index == 0)
+	/* for proper prefetch calculations, if dummy lat > fclk lat, use fclk lat = dummy lat */
+	if (need_fclk_lat_as_dummy)
 		context->bw_ctx.dml.soc.fclk_change_latency_us =
 				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 
@@ -2050,10 +2085,12 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
 		dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(dc, context);
-		if (dummy_latency_index == 0)
-			context->bw_ctx.dml.soc.fclk_change_latency_us =
-					dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us;
 	}
+
+	/* revert fclk lat changes if required */
+	if (need_fclk_lat_as_dummy)
+		context->bw_ctx.dml.soc.fclk_change_latency_us =
+				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us;
 }
 
 static void dcn32_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-- 
2.25.1


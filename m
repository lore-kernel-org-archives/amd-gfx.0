Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE88EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DA610E641;
	Wed,  6 Sep 2023 12:50:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE9810E63A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7vjHgQVuNcro0uKUKtuXFjYu1ThC3zdJTYXtE7pMddnTtlJ8KOObOrAzGoHSpgNX1kTxxZ+5shOb70f4nSdhpIwoVrY9B4cISy2ye08Be0pEZu7Mx0ctX9IAMBgvIZGwAyQMTSIVo/InZWCH1HpBuGMsmltpn99soOrrE01vhTGFAgkd6NcwzWGseZacsgDYBY83bBbn0x4c3+Hig7hpDWCDVnzTauwVEMKEiCQmmDbMRflep7QQSVG8xX05UAQD8Ue7oUJSzTzuIgFAll0u3Q1j3vBxVdzRIW8mrXv7rohf+iO4hoeGrE5Nvl/PzTBvtljR9vvCjZWYTbfal9oZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFSv/WV9eeMcyPuS/HzSaMCoIQ3uWItlJnjg34dpYPM=;
 b=Ym9JEklt9mQxGsTX3snKlRY56KhhzNZFZcnvxmM32d04BXKyHeDg8jp2RGO7gBHdM1f7E7ujKTlSIvC2e/fi4T4Wy5OY6rUvcGyubFIQw8mr0/gKF6rTjI8l40yRSZAiXY8Ygzsx2Du6u5P66c5PJZi3hHMzrsC9FDhprRfpDrwgPH06YSB/XoqPCsvNuJWHQTGIKe8ytjvC65O1qwJAJMioxzLF9rBlPFuzZGl94KbI654LMCHAfwyh0qXDJNKbbVB4HTvdej5pKLhwK6BqOzEm14ktPN1niKZw7qEUD4ltO+hqNcdskueadQrr5uw+iRNO6WuY26PnpojFRSyV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFSv/WV9eeMcyPuS/HzSaMCoIQ3uWItlJnjg34dpYPM=;
 b=T8WbqOrPROC3vFYVoB2/bum8LZK0lnhcsSC8bF8CP6G5Mskb94IE1uE6eNf7kY28IMj8g0vEi5kB5xq7eBfnVD6OUc8cM6/KXLRD/UCRRBEpZxIfgFvU6Ox8ZvENFogtrq/yp01u+l3DA9RewXD58ihnulCohVTdJHwPg9oumtI=
Received: from CY8PR12CA0064.namprd12.prod.outlook.com (2603:10b6:930:4c::10)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:50:26 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::91) by CY8PR12CA0064.outlook.office365.com
 (2603:10b6:930:4c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:58 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:54 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/28] drm/amd/display: remove a function that does complex
 calculation in every frame but not used
Date: Wed, 6 Sep 2023 20:28:19 +0800
Message-ID: <20230906124915.586250-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8447d16d-0a5b-4ee5-d3be-08dbaed7d79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhKacKq76RNyB6IFoXOM7NLSnlo3VB4t0TrrYj7JfCQE8hc8FI740x1HYymDd8MUxEEddjjnO0B13gWWRJOXdyFvUbPWOTgcAfDa82wAW/LRIVUSO7X44GDAZRvg+kf4TKU4zkU94RLMiRks6zVWeG1OaO4kCIGeBkpSi2kc+kDsDw29KowHJPo15v2+HPzcApR4Vge49Ql9EpliGcdBEJ0kbxCdbdySPGpi5wN+gnXlm0XTzxF/QxFRf8554ZMrznWefPgO+uMm8FCzwxLfgxd9rO8elLDvTL1WhdD99+7b9dPHTpB7iR2UTuEAvwSbkpKQYp19DgGmnWFsrdw7BIN/tImT5CFvWVy5X8S8sUV1Qa9szAiHzPWPQ58aC1NXAdZQWxHxtXnTNq6mgPDRVlT1qsGEeDI0FGRHVbz7ko1niWBH2bjuyZCEDuIftDEB7PP2ZYtV5P40N3NP2BA4vo3GMB7d7YNZ1Aoguhc2+Nx/1l62G/cdWNRQpOqupJ6p9S6JicvarOYPAced5tlkxoY959XSVQ4tgvcp8qTYOgGoZoiKjHrwoPzPp9eU1hE+iK82b6hvYO7IkaXLJymz2c66x/A1daJ04b3VEsAEwho1Ue1XtcHsEUMS8nPH1PT64xjvIo1PvsgX1PdSgQgDeQjINx+TcuUtoEA6V0P5Vwz9ijIvGEHqJhGuV71YelQtqykR/C+oqUs31js5VNKrDzFSr3+weecUbAWP60gStQTX0KOpBy4DzoB7K/s5GqeqElYP6tWxKP8tnpu030GKfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(8936002)(8676002)(4326008)(478600001)(70206006)(70586007)(44832011)(5660300002)(40480700001)(83380400001)(2906002)(41300700001)(6666004)(316002)(86362001)(54906003)(6916009)(7696005)(40460700003)(82740400003)(2616005)(1076003)(356005)(81166007)(26005)(16526019)(336012)(426003)(47076005)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:58.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8447d16d-0a5b-4ee5-d3be-08dbaed7d79b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
The result of predict_pipe_split calculation is no longer used but the
function is not removed. This will cause unnecessary calculation
of pipe split prediction in every frame update.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  3 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 84 -------------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  3 -
 3 files changed, 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index fd12791995a7..8cb6b94e83d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2031,9 +2031,6 @@ int dcn32_populate_dml_pipes_from_context(
 			}
 		}
 
-		DC_FP_START();
-		dcn32_predict_pipe_split(context, &pipes[pipe_cnt]);
-		DC_FP_END();
 
 		pipe_cnt++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 0c68cd97a461..496f0f58fa7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -348,90 +348,6 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 	}
 }
 
-/**
- * dcn32_predict_pipe_split - Predict if pipe split will occur for a given DML pipe
- * @context: [in] New DC state to be programmed
- * @pipe_e2e: [in] DML pipe end to end context
- *
- * This function takes in a DML pipe (pipe_e2e) and predicts if pipe split is required (both
- * ODM and MPC). For pipe split, ODM combine is determined by the ODM mode, and MPC combine is
- * determined by DPPClk requirements
- *
- * This function follows the same policy as DML:
- * - Check for ODM combine requirements / policy first
- * - MPC combine is only chosen if there is no ODM combine requirements / policy in place, and
- *   MPC is required
- *
- * Return: Number of splits expected (1 for 2:1 split, 3 for 4:1 split, 0 for no splits).
- */
-uint8_t dcn32_predict_pipe_split(struct dc_state *context,
-				  display_e2e_pipe_params_st *pipe_e2e)
-{
-	double pscl_throughput;
-	double pscl_throughput_chroma;
-	double dpp_clk_single_dpp, clock;
-	double clk_frequency = 0.0;
-	double vco_speed = context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz;
-	bool total_available_pipes_support = false;
-	uint32_t number_of_dpp = 0;
-	enum odm_combine_mode odm_mode = dm_odm_combine_mode_disabled;
-	double req_dispclk_per_surface = 0;
-	uint8_t num_splits = 0;
-
-	dc_assert_fp_enabled();
-
-	dml32_CalculateODMMode(context->bw_ctx.dml.ip.maximum_pixels_per_line_per_dsc_unit,
-			pipe_e2e->pipe.dest.hactive,
-			pipe_e2e->dout.output_format,
-			pipe_e2e->dout.output_type,
-			pipe_e2e->pipe.dest.odm_combine_policy,
-			context->bw_ctx.dml.soc.clock_limits[context->bw_ctx.dml.soc.num_states - 1].dispclk_mhz,
-			context->bw_ctx.dml.soc.clock_limits[context->bw_ctx.dml.soc.num_states - 1].dispclk_mhz,
-			pipe_e2e->dout.dsc_enable != 0,
-			0, /* TotalNumberOfActiveDPP can be 0 since we're predicting pipe split requirement */
-			context->bw_ctx.dml.ip.max_num_dpp,
-			pipe_e2e->pipe.dest.pixel_rate_mhz,
-			context->bw_ctx.dml.soc.dcn_downspread_percent,
-			context->bw_ctx.dml.ip.dispclk_ramp_margin_percent,
-			context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz,
-			pipe_e2e->dout.dsc_slices,
-			/* Output */
-			&total_available_pipes_support,
-			&number_of_dpp,
-			&odm_mode,
-			&req_dispclk_per_surface);
-
-	dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(pipe_e2e->pipe.scale_ratio_depth.hscl_ratio,
-			pipe_e2e->pipe.scale_ratio_depth.hscl_ratio_c,
-			pipe_e2e->pipe.scale_ratio_depth.vscl_ratio,
-			pipe_e2e->pipe.scale_ratio_depth.vscl_ratio_c,
-			context->bw_ctx.dml.ip.max_dchub_pscl_bw_pix_per_clk,
-			context->bw_ctx.dml.ip.max_pscl_lb_bw_pix_per_clk,
-			pipe_e2e->pipe.dest.pixel_rate_mhz,
-			pipe_e2e->pipe.src.source_format,
-			pipe_e2e->pipe.scale_taps.htaps,
-			pipe_e2e->pipe.scale_taps.htaps_c,
-			pipe_e2e->pipe.scale_taps.vtaps,
-			pipe_e2e->pipe.scale_taps.vtaps_c,
-			/* Output */
-			&pscl_throughput, &pscl_throughput_chroma,
-			&dpp_clk_single_dpp);
-
-	clock = dpp_clk_single_dpp * (1 + context->bw_ctx.dml.soc.dcn_downspread_percent / 100);
-
-	if (clock > 0)
-		clk_frequency = vco_speed * 4.0 / ((int)(vco_speed * 4.0) / clock);
-
-	if (odm_mode == dm_odm_combine_mode_2to1)
-		num_splits = 1;
-	else if (odm_mode == dm_odm_combine_mode_4to1)
-		num_splits = 3;
-	else if (clk_frequency > context->bw_ctx.dml.soc.clock_limits[context->bw_ctx.dml.soc.num_states - 1].dppclk_mhz)
-		num_splits = 1;
-
-	return num_splits;
-}
-
 static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *entry)
 {
 	float memory_bw_kbytes_sec;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index defbee866be6..d25c3f730a59 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -36,9 +36,6 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 					      display_e2e_pipe_params_st *pipes,
 					      int pipe_cnt);
 
-uint8_t dcn32_predict_pipe_split(struct dc_state *context,
-				  display_e2e_pipe_params_st *pipe_e2e);
-
 void dcn32_set_phantom_stream_timing(struct dc *dc,
 				     struct dc_state *context,
 				     struct pipe_ctx *ref_pipe,
-- 
2.42.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714F1CAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148D310E56C;
	Tue, 16 Sep 2025 19:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Hjr6BWc";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FB210E7FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+wAIV+YNzG9sZqyfzOQ2D0SUicQUwj0Z7lOU2Nk0YDidmuWbdTzHHRw5rjuLZ0KBkqlFl9yp0dhcdJ5cTDT+jVBqgiAtp28c2BcXLeB9L32N2vbvDCJyuNO2Cfk9bMyuxQNyTmpIJqrOSMONLBNhwq23gc+VdKMmZI8Zr7ggOBIs89GeOJVIofMkBr9T7Nbq8s+qhSWvN4VSeULMYH4QNKIye7F+clL3pbrc3pVOHDGpVjWV9QPXuuzfsrqAA0QqaHVyhSnRCMMpou/RRPlCt80SlRWXzZT/QukTHD3K342jRuvmTdFmn9xBjb40b9bTiM60ANcr3hqxvNHOUQKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlDNLANvir/BlS3VFg4wxzMNLriQs/hRR2jtUA5KaQ8=;
 b=g93uyNFjHBZ7jSLsIuSk3mb6orCSdZr0kTov3/4R7GEqNFIsr8vsUEppEDCUF30TCgtcDwH1hmdWH5imYG+R9Yk1looEXFfnpJNGBnnB+KyXmmxhr4QsnKoimF1XOCeF6fiGsP1i3wPUuTK/Ez0B0bpjViz2VZ36CHuBbZkh0LRE6xbCCPQXoA2bcoE+NPh0vvW1q9AH+sfWqcYQTPIB9le2M++ymxnANRZYxEdHZp0mItrV5mf+DfeCxB5wvty6jJ/T5Bb65CfLN7i3XC/hUOYljdcfHGdL2V4bSdKMd0OGc919K3ZtY+l2v+cgO+sBG9gtnaBLeA2JU7pjaSCoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlDNLANvir/BlS3VFg4wxzMNLriQs/hRR2jtUA5KaQ8=;
 b=2Hjr6BWcB8jJ3jCCHvYb2sJht277SQiwsHZCCUGCmK6i2ebfoSwzQf3sxvAMl+X1m352GHr2n0byd2rp21/8ZAHG4VLNBloNWo8kOikUDXwyqESkolV8tsewQdLJjM89k1Xy5F7/Hi++ZGt6vFdAzqRlbCoYi8EKN9axE6+esu4=
Received: from DSZP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::17) by
 DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Tue, 16 Sep 2025 19:12:29 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::f4) by DSZP220CA0011.outlook.office365.com
 (2603:10b6:5:280::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:17 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:16 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 17/20] drm/amd/display: Revert "correct sw cache timing to
 ensure dispclk ramping"
Date: Tue, 16 Sep 2025 15:09:37 -0400
Message-ID: <20250916191142.3504643-18-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fc9e3c-4c5c-48ff-a1f7-08ddf554fb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F3+ujrJ0bWfqVHx+MSM64emdYiO52H0aUTquZ05Z3Omp9X4H7cqP3tl8BooZ?=
 =?us-ascii?Q?oZ+LfHAaEM8l5QaOBRgzxdEhegtcOeOkRTKE62acS1kVmI0K/zeKdBR5j3ph?=
 =?us-ascii?Q?wo+PZbPTOl2YXY/oGtrJBrm8cGV/Rph69JXwCdomh/MyEfKtAp4lqlqrIs/o?=
 =?us-ascii?Q?vjcSCH8QY48MO9katzx/F7dSd+g25S7gqnj7eannj+TlKN+dlyvvQX+3b5C5?=
 =?us-ascii?Q?FN4cGn8mtJJwjr6aVPVdlmmkKNTteAb9d8XoW9M6JKC/8xo58gx8/5w5rmEr?=
 =?us-ascii?Q?tndP4TG8H3cfCpzwtgwOT+8Otq0kNgR1RyrhvoPaIv7fT7o367BIKj287arP?=
 =?us-ascii?Q?gFQhVH4QMXtz/hOZEo+LQt5MRTcqlBa+rzisb81EqsIq7Op/CmlaOhNg/vtJ?=
 =?us-ascii?Q?rg/1AJtmoFKx/67Q4YaNEDX57zjB4hG1MzI5H/9xG0UwMfBluHRAHLOJhM+Q?=
 =?us-ascii?Q?PSRiCJQOSzwOfrEo3dzfvN8OU4ktFCMvF4XxBhWTsX8uXsnmwp/zCTC4lXB1?=
 =?us-ascii?Q?P96nXuwghP5inZja0vXoHASBbjS8I0U40z/98JveNOBlZJuV5C2DMU69pFg+?=
 =?us-ascii?Q?aPOFqRDtZhgoYZX50c/V8aNEOf/g+G/ZbGq+aWJyNSvhmLmeyu0/WA00PI5G?=
 =?us-ascii?Q?VfG+9j/357Y/+TLubi5PcvVJpLsYGOXGhtjPL20DrQ5nKr3BpSwLGBScQ73B?=
 =?us-ascii?Q?MGLbINu/bXpIQDnOgRqJ2SQ7iOzssElfuU+0HRprSRPZtLt8Ik0I8tQ9d0kf?=
 =?us-ascii?Q?ZRaO13VntXSkG6mpAOIVFQ/3ZZTrNcviJNOloDO0wuEDiHo34EvXcfB0KIkw?=
 =?us-ascii?Q?SSbasOQ8bkzxYjOfbcmMCblzw4XoYWV2CRA9CWRhWc2NLzYHa6tJXiuMm5b0?=
 =?us-ascii?Q?kaVuU+FfBR+3ljhQjIq1fFAYuEiEkhdQTbmzXHHtgm8g46fXjHLYpS4Pfi78?=
 =?us-ascii?Q?IPntSYwhZ8uZ/ntqPXF8c0FbLaf1iOIUE20EFPWX24aj3TbcE4UJ5TLooNGy?=
 =?us-ascii?Q?ysgZiadjFMhm/CV9Hvk9ZKvW0XhQB9L0jOKz/JaerWlKkyjGeGzmzv3PTrXI?=
 =?us-ascii?Q?Lv9pzaSfL4KX1McZoPEVQL6AxT75f2WqOSUzS64WTn0KNFOGwQp+6Y8R9wCc?=
 =?us-ascii?Q?zxBYt+Gtm2h42dE/Y2FLZzrD2xyMZRXhKdHZ8VdXCBAy+6x2H1xVChQyG2lV?=
 =?us-ascii?Q?3mZT3k0KdeUla5p/oz1hf7fWgKVIaY7wHfwxDppO8CWslT/GMoyV1WOCOmsZ?=
 =?us-ascii?Q?9d/KJgOqkAyiJJ6IvsiSy+jODyws4XeuTyFd/LWecJI59GIF/VHfa9c/0emu?=
 =?us-ascii?Q?A1GWDoGLIfmk9WIgeBL+JxJlRgVSynX/nLoNFam9f3ccFwsO3nZYmcctc9wN?=
 =?us-ascii?Q?a4CZby5O2Df6UJGnXgkdZUqAsNgn5nYfa87EJFoztB1skjRLqPVwgstbzHjd?=
 =?us-ascii?Q?QpJrNK5B8U6nen2Y154nNitW6g+sUwmDGFFhblVVX+8cVL11DLO25e/NyxdV?=
 =?us-ascii?Q?0I6+rQpCn3zQFWizeWMK5iGPujwMGDxWSZsX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:29.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fc9e3c-4c5c-48ff-a1f7-08ddf554fb10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
Need consider SSC enabled case

This reverts commit b0552a6de4727ffe9604b662d90bcdbc866af16f.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 30 ++++++-------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 6fc8a7491684..86edf11b8c5a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -387,7 +387,6 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
 	int all_active_disps = 0;
-	int actual_dppclk = 0;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -473,13 +472,14 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
 		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
 			dpp_clock_lowered = true;
+		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
 		update_dppclk = true;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
 	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
 		int requested_dispclk_khz = new_clocks->dispclk_khz;
-		int actual_dispclk;
+
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		/* Clamp the requested clock to PMFW based on their limit. */
@@ -487,11 +487,7 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
 
 		dcn35_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
-		actual_dispclk = REG_READ(CLK1_CLK0_CURRENT_CNT);
-
-		/*pmfw might set bypass clock which is higher than hardmin*/
-		if (actual_dispclk >= new_clocks->dispclk_khz)
-			clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
+		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
 		dcn35_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
@@ -509,20 +505,13 @@ void dcn35_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (dpp_clock_lowered) {
 		// increase per DPP DTO before lowering global dppclk
 		dcn35_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
-		dcn35_smu_set_dppclk(clk_mgr, new_clocks->dppclk_khz);
+		dcn35_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 	} else {
 		// increase global DPPCLK before lowering per DPP DTO
 		if (update_dppclk || update_dispclk)
-			dcn35_smu_set_dppclk(clk_mgr, new_clocks->dppclk_khz);
+			dcn35_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 		dcn35_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
-	if (update_dppclk) {
-		actual_dppclk = REG_READ(CLK1_CLK1_CURRENT_CNT);
-
-		/*pmfw might set bypass clock which is higher than hardmin*/
-		if (actual_dppclk >= new_clocks->dppclk_khz)
-			clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
-	}
 
 	// notify PMFW of bandwidth per DPIA tunnel
 	if (dc->debug.notify_dpia_hr_bw)
@@ -562,7 +551,7 @@ static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 	 * since fractional part is only 16 bit in register definition but is 32 bit
 	 * in our fix point definiton, need to shift left by 16 to obtain correct value
 	 */
-	pll_req.value |= (long long) fbmult_frac_val << 16;
+	pll_req.value |= fbmult_frac_val << 16;
 
 	/* multiply by REFCLK period */
 	pll_req = dc_fixpt_mul_int(pll_req, clk_mgr->dfs_ref_freq_khz);
@@ -789,8 +778,7 @@ static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct
 			table->WatermarkRow[WM_DCFCLK][num_valid_sets].MaxClock = 0xFFFF;
 
 			/* Modify previous watermark range to cover up to max */
-			if (num_valid_sets > 0)
-				table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxClock = 0xFFFF;
+			table->WatermarkRow[WM_DCFCLK][num_valid_sets - 1].MaxClock = 0xFFFF;
 		}
 		num_valid_sets++;
 	}
@@ -951,8 +939,8 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	       is_valid_clock_value(min_dram_speed_mts));
 
 	/* dispclk and dppclk can be max at any voltage, same number of levels for both */
-	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS) {
-		/*numDispclk is the same as numDPPclk*/
+	if (clock_table->NumDispClkLevelsEnabled <= NUM_DISPCLK_DPM_LEVELS &&
+	    clock_table->NumDispClkLevelsEnabled <= NUM_DPPCLK_DPM_LEVELS) {
 		max_dispclk = find_max_clk_value(clock_table->DispClocks,
 			clock_table->NumDispClkLevelsEnabled);
 		max_dppclk = find_max_clk_value(clock_table->DppClocks,
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA49C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B268910EFD4;
	Wed,  2 Sep 2026 05:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KtiNsR/6";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF2F10EFD4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/CMOWojZrKZpwq9vudtKHr/xkrLfexKxEE+ZhNtdl7WLOWxEW9GIS9ugqTinNCJH00hpyZhDvG0LEdhj/glXveq4YlPMhlH1QntJa70VRxcj1/HSAr47TjqOSoObRcMNhXViuosSj7qq/lXLjYk6TQqlhjDCl69cFlfUbqTxdO4YzRtVbwYvkmwY5zuHYdem1Oe/pJBPCEsdpw3qx8pa2NxbTZwAEpP6SKkJLcVEtx7p4/K5hqxuTEqDp/bS3h2LEbphKZbbWFRKquf2mTSEt23IYJ58uuKdzRNTzi5+QgH8/iKOIxHQaf4MYNwZU1CJgmS/VshDU/5NO5GP6VqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yal9BP3yPUMG04IlCMFCOOVxdg5fajAqIYtf3+v2JXw=;
 b=ga1r0uZ1TFGTuQKfEfTq8ceayz+WQZVCOT30WSmdccwQf1+bAsxb5Y/r6jy8T4PXXqoB+TjNV7vvuDtTN6jEJoq/J5Z25yqlBi9lBUHe9XM4xfvvwmSS5TASLMh+WEg40J5ZqNuRgteBJckDXP5eFT8bY/W59eMvfPLnBFNdHjpAw+Mu1e72oYQz5k3nYhHwiloShDHskM/icrPVIU5xh9jFfmcNuY8prgWCEDJGBTswqHYuqXAosTMvMJD9e41XLF8WQZCjz07E2TJ5QzKBEhqIAC6nHcA1Le0DuOI2tuVPxHvmwOjIzUyIR460r7zYQJpO6WwqmOGjjOoM9D2cSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yal9BP3yPUMG04IlCMFCOOVxdg5fajAqIYtf3+v2JXw=;
 b=KtiNsR/6NawHz8fh0QfknX9EeRF2SPzpqyaWY5nIG06vdo2Ft89Gr/gRJ7weqpvlE0rS5wtlqVPrPxI+IYxpepXggJOrytat8Mpq0TcchtTHgY747m7klEYFGbNfCRWBoEzh3uiP8OmaZZthXfVvyGXPYZ8RocrnQz3M+gzXaUU=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 2 Sep 2026
 05:08:08 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::aa) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Wed, 2
 Sep 2026 05:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:08:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:07 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:07:58 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 25/40] drm/amd/display: Dump clock registers in HW init
 instead of SW init
Date: Wed, 2 Sep 2026 12:58:47 +0800
Message-ID: <20260902050411.3473916-26-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c19d11-d90e-4bca-f395-08df08b02db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iziWLBmMjqhKjW6SeLiMH64DNT7cFbc31jQpu5QeTDv5spjpYRLTMcaySm6W0XUFxnXhsCEt+HSS0FfYlb+UT6G23SyxI05uAKnv5x9KTs8p9sQsRZi/OkCYHe/t4L/EdE7Do/mkvxo5apvZkRMXJYjzkcjDpK7K0s2FxS+XayDGTrvme3kLEJd+iyFnMEbY69e2pelggty5OI/Rz6Cc6fKJWsXovC9zI4V3sXEPCME4bKyjdpUb6YNaQBTaaTb64woBPdfqCk31Aw0gDxQemD99bMelmHPCtSXEc9822sP75FGwUx1HtfsrRiqUSCDlz6OPUChxi3XHZLMzp4qOtw0xXjKF8h13RIpr6MwPzOijmsMUwfh2OE9hDk5jGylNZ4gF2dz8Js4cVy0p1qDaDzs1LYyh2aiO/9+2dTTxrpSoDsKcz8VTBr3KEvBECrrSqbCJgbcR0E69Ek53m8cm3brz4t0Fhwpulj4Dw6CkFT1/7ylxwA2q2iDZQGXppZXnYZIpNKqmeJ0mjD9H1IfxZXtjJaiGuo2CPNQDFOgwlwNsTxJx8HQIWWQcFzBodAM6PshkIApwWS3yTfRqhWF4aRiiIybT4jbbZY88Bx4pQ27uXX+GqzeyKra4J590ja9cv9p49crF0/BdsgZxY+UB/ooUurFAZi6xQo7e0zjZ1CZ7tUPoscEY6hTlPMm2jEEWgTPleqRYAVdpd77r2EiDww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hg/3Ys7ViQQHGK9CohjyBFm+aXODKlFr9rxIXTexXu5hHmqFx/MDXMovL73EIezgWIl43X2rvkHeLttxltR2nYBrOtGrjwm201PL0ibn23JlxDsBTIztOjMB19WRR/IwascIfs3lHLz5itpOyCHbDxNOFUioc53mAdA9M8eMg7MfND+8fhiws5U3Cxdhd4CkeCteiwhJCy5mnsURYgEYnUTz9PTmGlGdZ8FAB/CBjVI89YU/yN380adYxmrxc5aBJ5vzLY8YsJO0d9hAqWpb7ffD8aCsYWVV4jHeHoXq2o7rfn0lRpAQgM7FVHNtonEvPLMe6KcER6DQuLoMXsSxUPjQwaUcKfeYxqbo8nZqS8CkVVJ/VX2wqcmwQzFYdTtrCIXj2hSFkSSIVfuFi9Hkc6O7SbpVFgEx5f9LbXvu3zKySaPDJ0iqQDK6MXiougiK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:08:08.3840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c19d11-d90e-4bca-f395-08df08b02db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
- Dumping clock registers in SW init can get incorrect clock readback due
  to other init code (e.g., in DMU) potentially not executed yet
- Move clk_ip register access into HW init to ensure the clock read back
  gets the correct values

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 140 +++++++++---------
 1 file changed, 74 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 2b7740b82161..138afa7afc86 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -756,29 +756,6 @@ static bool dcn60_fetch_dal_init_table(struct clk_mgr_internal *clk_mgr)
 	return true;
 }
 
-void dcn60_init_clocks(struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	uint32_t smu_header_ver = 0;
-
-	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
-	clk_mgr_base->clks.p_state_change_support = true;
-	clk_mgr_base->clks.fclk_p_state_change_support = false;
-	clk_mgr->smu_present = !clk_mgr_base->force_smu_not_present /* not force-disabled */
-			&& dcn60_smu_get_msg_header_version(clk_mgr, &smu_header_ver)
-			&& smu_header_ver != 0;
-
-	clk_mgr->dpm_present = clk_mgr->smu_present
-			&& dcn60_fetch_dal_init_table(clk_mgr)
-			&& clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels
-			&& clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels
-			&& clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
-
-	if (clk_mgr->dpm_present)
-		clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
-				clk_mgr_base->ctx->dc, clk_mgr_base->bw_params);
-}
-
 static inline uint32_t count_to_khz(uint32_t count, uint32_t timer_ths, uint32_t refclk_khz)
 {
 	if (timer_ths == 0)
@@ -899,6 +876,80 @@ static void dcn60_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 	}
 }
 
+static void dcn60_dump_and_assign_boot_clocks(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_log_info log_info = {0};
+
+	dcn60_dump_clk_registers(&clk_mgr_base->boot_snapshot, clk_mgr_base, &log_info);
+
+	if (clk_mgr_base->ctx->dc->debug.disable_dtb_ref_clk_switch &&
+			clk_mgr_base->clks.ref_dtbclk_khz != clk_mgr_base->boot_snapshot.dtbclk) {
+		clk_mgr_base->clks.ref_dtbclk_khz = clk_mgr_base->boot_snapshot.dtbclk;
+	}
+
+	if (clk_mgr_base->boot_snapshot.dprefclk != 0)
+		clk_mgr_base->dprefclk_khz = clk_mgr_base->boot_snapshot.dprefclk;
+}
+
+static void dcn60_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
+{
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+	int ss_info_num = bp->funcs->get_ss_entry_number(
+			bp, AS_SIGNAL_TYPE_GPU_PLL);
+
+	if (ss_info_num) {
+		struct spread_spectrum_info info = { { 0 } };
+		enum bp_result result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
+
+		/* SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr->ss_on_dprefclk = true;
+			clk_mgr->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread
+				 */
+				clk_mgr->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+		}
+	}
+}
+
+void dcn60_init_clocks(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t smu_header_ver = 0;
+
+	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
+	clk_mgr_base->clks.p_state_change_support = true;
+	clk_mgr_base->clks.fclk_p_state_change_support = false;
+
+	dcn60_dump_and_assign_boot_clocks(clk_mgr_base);
+	dcn60_clock_read_ss_info(clk_mgr);
+
+	clk_mgr->smu_present = !clk_mgr_base->force_smu_not_present /* not force-disabled */
+			&& dcn60_smu_get_msg_header_version(clk_mgr, &smu_header_ver)
+			&& smu_header_ver != 0;
+
+	clk_mgr->dpm_present = clk_mgr->smu_present
+			&& dcn60_fetch_dal_init_table(clk_mgr)
+			&& clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels
+			&& clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels
+			&& clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+
+	if (clk_mgr->dpm_present)
+		clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
+				clk_mgr_base->ctx->dc, clk_mgr_base->bw_params);
+}
+
+
 static void dcn60_auto_dpm_test_log(
 		struct dc_clocks *new_clocks,
 		struct clk_mgr_internal *clk_mgr,
@@ -1445,37 +1496,6 @@ static void dcn60_update_clocks(struct clk_mgr *clk_mgr_base,
 
 }
 
-static void dcn60_clock_read_ss_info(struct clk_mgr_internal *clk_mgr)
-{
-	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
-	int ss_info_num = bp->funcs->get_ss_entry_number(
-			bp, AS_SIGNAL_TYPE_GPU_PLL);
-
-	if (ss_info_num) {
-		struct spread_spectrum_info info = { { 0 } };
-		enum bp_result result = bp->funcs->get_spread_spectrum_info(
-				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
-
-		/* SSInfo.spreadSpectrumPercentage !=0 would be sign
-		 * that SS is enabled
-		 */
-		if (result == BP_RESULT_OK &&
-				info.spread_spectrum_percentage != 0) {
-			clk_mgr->ss_on_dprefclk = true;
-			clk_mgr->dprefclk_ss_divider = info.spread_percentage_divider;
-
-			if (info.type.CENTER_MODE == 0) {
-				/* Currently for DP Reference clock we
-				 * need only SS percentage for
-				 * downspread
-				 */
-				clk_mgr->dprefclk_ss_percentage =
-						info.spread_spectrum_percentage;
-			}
-		}
-	}
-}
-
 /* Set min memclk to minimum, either constrained by the current mode or DPM0 */
 static void dcn60_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current_mode)
 {
@@ -1681,7 +1701,6 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct dccg *dccg)
 {
-	struct clk_log_info log_info = {0};
 	struct dcn60_clk_mgr *clk_mgr60 = kzalloc(sizeof(struct dcn60_clk_mgr), GFP_KERNEL);
 	struct clk_mgr_internal *clk_mgr;
 
@@ -1716,17 +1735,6 @@ struct clk_mgr_internal *dcn60_clk_mgr_construct(
 		if (clk_mgr->base.dentist_vco_freq_khz == 0)
 			clk_mgr->base.dentist_vco_freq_khz = 4500000;
 
-		dcn60_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
-
-		if (ctx->dc->debug.disable_dtb_ref_clk_switch &&
-				clk_mgr->base.clks.ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
-			clk_mgr->base.clks.ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
-		}
-
-		if (clk_mgr->base.boot_snapshot.dprefclk != 0)
-			clk_mgr->base.dprefclk_khz = clk_mgr->base.boot_snapshot.dprefclk;
-		dcn60_clock_read_ss_info(clk_mgr);
-
 	clk_mgr->dfs_bypass_enabled = false;
 
 	clk_mgr->smu_present = false;
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63AEC5CFCF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68DA10EC9C;
	Tue, 11 Aug 2026 15:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oB/54t6B";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704B910EC7F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYf9rp7JdIDKz1rCs4niOcndTOgUm58qLGNgwLtEdX23lrkhR2A1MvjugCapOyz86jkM8tbLA0wjuzWzxITXcfOEfbIgYjuRVoi5G8fIkvF8N45u4MUbs5rp4mBq58g8nznMduEg1iUU40wru5U5BpDlGcnjTwQIz3NSXehGeTbBK4CZ0jDhcYSIphxyoWgCS+M7n837Qlpoo7F2hlSVOipeNkjTkqbJkZ59CvSkKMIuKivk9gJPUT5pJg7gO46TF+Y8MIjaZAiNHzPj+kU5zu+BdKx8ZllvgnPVjPqeJ9+rUf0u0qE0u4I14NvsG6mjaiye4SoOGhZ+fjix9HAriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtGY47I82DN7eB6PYtM52i9DEhmkCLfl25LcLTcIDrI=;
 b=HtuCErLEwWSTiCDgdsd8D+1ncgT5tBXJtUGdMh1YhvK9nPs9HnT9PL2QUZoZqaL9+R4QpJ3gnuQVwIv4Q51R7VgckoG7NSg5zukh519aGuFshUlAPjd8SylKOkMrXuPzzTPHiasRWTaRsvk5rXMGlgIChT8tubZmP7YzK1U0OpV/hxxAQQpfy5i6ZMjMo2e9UZXV60qtVROyOxqoF48VQTjWNiu3jhjTvSkB9wzsBM9ZrOB5ohjKCKE6Jiv+mj6ZBrCji25nd7eOFH2ADQ+CLtqe2p9Ql3iixZd3ClFhImKSgGCa1rNwBEHRhc8vTbiGe9NHcuvRnlxokFliKxEijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtGY47I82DN7eB6PYtM52i9DEhmkCLfl25LcLTcIDrI=;
 b=oB/54t6BKaHHQ1wI/7xqERBRD+DnySvvy8ZuhKL0Eknwe4mg1xSt2wE1HrAOZYcaSpggJsHNNF6sXWzV1jKcamrQCQ3LBgJfikTc1Koq8aa0M7NCgiJ3teq6cB3YqSfjCb2sodpfAVKnD6xEx2bNpZxAh+6c63eJY54j5JIW5qQ=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:48:50 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::ab) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:48:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:48:46 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:48:37 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 04/24] drm/amd/display: Rename carried dce clock manager
 functions for dcn10
Date: Tue, 11 Aug 2026 05:28:38 +0800
Message-ID: <20260810213010.1703162-5-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 577c13df-af53-49e7-7af5-08def7c007f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: P9tLmPpYIok4qn09y0tC/uewOPGyo3qLJywh5P0J+Rg0Mx+7swOUMUHUJD1wEVgX5Be3Q6ROqvDhCYZe7Gh1jMc3VyiLq9rQzWYITIS2n2L3JEFWJz8GrFV3eCRWhmYpus5vHhlPDAEO7CXMr2waF7B9aUvO8H2EGdl1FlOp0IBR1bLxv0bmMgTfnNddeyJ0RPAdWoulpFbrs4a93j95PZC8Izis9MgybD60N4vhyqUw2gmpjych8rXuFpmA1AYNO5qUkpSxXsBa0YTWJ76ZlG20LncwUyN4MGteJVLDq6nk1oSXzSTF+E9wgg3FswTIV7jJrE0X332DenqhtfY150AXDA5ajCOB8yHl/wlDLjyf1+BRHZNmIk38yr9OhWThWaiNZuJ+9Q4PWME49Dql+fcG1p0R3C4bgFkbdcTj8YU+oDr+RuXSdHPuT2AipFbsCXQ+8f0P53uMQSSiPTnyyR2OJ/DOm52tEiN1RHTMEAvrHeF5SOFyf0s4yHpVMDH3oa/7eHdoX5WSp60F6Bpzn4oQk5U4VEgZPf5f02CCrkB5YiC/Z5P07KCHwDtcc64hyCIFwUk6OGwm1jTTvYoGaOPZJHnudt22U9jgcTfCUmuYUSOhjPVtnCBDBMkv1z+fvQC383eT1M6hn9CvbIAVHJiRGvBHHIP3bF7Rat5UXS+wM1xPSj8LPe3cV7sg3p/7JBZDMTX3XE8k1eqfS0nNjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x5MROs7TgKlR2s/6/QS/k2bWInrOOLvKaEhVWfsBCoF9drAWaxhWpmE4yHnzAQMCSRd/DmKoL2gN+CXvZQcixKt2ppz54S0WzIW0Xzx3xWAhM243aR98w97qpUGN0iXSBD8Iv/jWQQZwTagZ2vPp0NhRBTMuxYjINZa8jamFiUXMa0dECJzQdMYf4IR2W65cHClu9bmm4YuG7/fPYDHChjdk1O2e2n6oHOrJjG0n2ung4BOk5Flr7qTQncBGVH9xM4yiuB6ZPJvUBF1MDMP97g8UE6BOEYMdQxL5sLvGuZfTrg36ZPUOepuRS+YOszgSWf3CZ7w1E7RBQubBPLFGTNxybYFiIduHMYjqc3ODP0vs5dah/zt3eWLkSj5MauPaaWIB9KuSvUgIpcFtDP81sU7j2NgqYHIt03ahorWbLovfzIJ3RFtFueqqRR1QUWkM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:48:47.1896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 577c13df-af53-49e7-7af5-08def7c007f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Some legacy DCE functions were carried over to DCN10 and later. These
functions are now renamed to remove the DCE prefix and be more generic.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 115 ++++++++++++++++++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   8 +-
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  59 +++++++++
 .../dc/clk_mgr/dce112/dce112_clk_mgr.h        |   4 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  |  14 +--
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |  12 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   9 +-
 .../display/dc/clk_mgr/dcn10/rv2_clk_mgr.c    |   6 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   5 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  18 +--
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  12 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  18 +--
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  14 +--
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |  10 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |   4 +-
 23 files changed, 281 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 42e6d6538825..d891b3bfe2a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -62,6 +62,56 @@ static const struct clk_mgr_mask disp_clk_mask = {
 		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
+unsigned int dentist_get_divider_from_did(unsigned int did)
+{
+	if (did < DENTIST_BASE_DID_1)
+		did = DENTIST_BASE_DID_1;
+	if (did > DENTIST_MAX_DID)
+		did = DENTIST_MAX_DID;
+
+	if (did < DENTIST_BASE_DID_2) {
+		return DENTIST_DIVIDER_RANGE_1_START + DENTIST_DIVIDER_RANGE_1_STEP
+							* (did - DENTIST_BASE_DID_1);
+	} else if (did < DENTIST_BASE_DID_3) {
+		return DENTIST_DIVIDER_RANGE_2_START + DENTIST_DIVIDER_RANGE_2_STEP
+							* (did - DENTIST_BASE_DID_2);
+	} else if (did < DENTIST_BASE_DID_4) {
+		return DENTIST_DIVIDER_RANGE_3_START + DENTIST_DIVIDER_RANGE_3_STEP
+							* (did - DENTIST_BASE_DID_3);
+	} else {
+		return DENTIST_DIVIDER_RANGE_4_START + DENTIST_DIVIDER_RANGE_4_STEP
+							* (did - DENTIST_BASE_DID_4);
+	}
+}
+
+/* SW will adjust DP REF Clock average value for all purposes
+ * (DP DTO / DP Audio DTO and DP GTC)
+ if clock is spread for all cases:
+ -if SS enabled on DP Ref clock and HW de-spreading enabled with SW
+ calculations for DS_INCR/DS_MODULO (this is planned to be default case)
+ -if SS enabled on DP Ref clock and HW de-spreading enabled with HW
+ calculations (not planned to be used, but average clock should still
+ be valid)
+ -if SS enabled on DP Ref clock and HW de-spreading disabled
+ (should not be case with CIK) then SW should program all rates
+ generated according to average value (case as with previous ASICs)
+  */
+
+int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz)
+{
+	if (clk_mgr_dce->ss_on_dprefclk && clk_mgr_dce->dprefclk_ss_divider != 0) {
+		struct fixed31_32 ss_percentage = dc_fixpt_div_int(
+				dc_fixpt_from_fraction(clk_mgr_dce->dprefclk_ss_percentage,
+							clk_mgr_dce->dprefclk_ss_divider), 200);
+		struct fixed31_32 adj_dp_ref_clk_khz;
+
+		ss_percentage = dc_fixpt_sub(dc_fixpt_one, ss_percentage);
+		adj_dp_ref_clk_khz = dc_fixpt_mul_int(ss_percentage, dp_ref_clk_khz);
+		dp_ref_clk_khz = dc_fixpt_floor(adj_dp_ref_clk_khz);
+	}
+	return dp_ref_clk_khz;
+}
+
 static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -105,6 +155,13 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
 }
 
+int dce12_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	return dce_adjust_dp_ref_freq_for_ss(clk_mgr_dce, clk_mgr_base->dprefclk_khz);
+}
+
 /* unit: in_khz before mode set, get pixel clock from context. ASIC register
  * may not be programmed yet
  */
@@ -199,6 +256,64 @@ static void dce_clock_read_integrated_info(struct clk_mgr_internal *clk_mgr_dce)
 			clk_mgr_dce->dfs_bypass_enabled = true;
 }
 
+void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
+{
+	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
+	int ss_info_num = bp->funcs->get_ss_entry_number(
+			bp, AS_SIGNAL_TYPE_GPU_PLL);
+
+	if (ss_info_num) {
+		struct spread_spectrum_info info = { { 0 } };
+		enum bp_result result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_GPU_PLL, 0, &info);
+
+		/* Based on VBIOS, VBIOS will keep entry for GPU PLL SS
+		 * even if SS not enabled and in that case
+		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr_dce->ss_on_dprefclk = true;
+			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* TODO: Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread */
+				clk_mgr_dce->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+
+			return;
+		}
+
+		result = bp->funcs->get_spread_spectrum_info(
+				bp, AS_SIGNAL_TYPE_DISPLAY_PORT, 0, &info);
+
+		/* Based on VBIOS, VBIOS will keep entry for DPREFCLK SS
+		 * even if SS not enabled and in that case
+		 * SSInfo.spreadSpectrumPercentage !=0 would be sign
+		 * that SS is enabled
+		 */
+		if (result == BP_RESULT_OK &&
+				info.spread_spectrum_percentage != 0) {
+			clk_mgr_dce->ss_on_dprefclk = true;
+			clk_mgr_dce->dprefclk_ss_divider = info.spread_percentage_divider;
+
+			if (info.type.CENTER_MODE == 0) {
+				/* Currently for DP Reference clock we
+				 * need only SS percentage for
+				 * downspread */
+				clk_mgr_dce->dprefclk_ss_percentage =
+						info.spread_spectrum_percentage;
+			}
+			if (clk_mgr_dce->base.ctx->dc->config.ignore_dpref_ss)
+				clk_mgr_dce->dprefclk_ss_percentage = 0;
+		}
+	}
+}
+
 static void dce_pplib_apply_display_requirements(
 	struct dc *dc,
 	struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
index 2f4165f1a7bc..e1c6a92d7957 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
@@ -28,9 +28,9 @@
 #define _DCE_CLK_MGR_H_
 
 #include "dc.h"
-#include "dcn10/dcn10_clk_mgr.h"
 
 /* functions shared by other dce clk mgrs */
+int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
 int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
 
 uint32_t dce_get_max_pixel_clock_for_all_paths(struct dc_state *context);
@@ -40,6 +40,10 @@ void dce_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_internal *clk_mgr_dce);
 
+void dce_clock_read_ss_info(struct clk_mgr_internal *dccg_dce);
+
+int dce12_get_dp_ref_freq_khz(struct clk_mgr *dccg);
+
 int dce_set_clock(
 	struct clk_mgr *clk_mgr_base,
 	int requested_clk_khz);
@@ -47,4 +51,6 @@ int dce_set_clock(
 
 void dce_clk_mgr_destroy(struct clk_mgr **clk_mgr);
 
+unsigned int dentist_get_divider_from_did(unsigned int did);
+
 #endif /* _DCE_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 2157761c3b4b..3da0c220d17f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -101,6 +101,65 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 	return actual_clock;
 }
 
+int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
+{
+	struct bp_set_dce_clock_parameters dce_clk_params;
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+	struct dc *dc = clk_mgr->base.ctx->dc;
+	struct dmcu *dmcu = dc->res_pool->dmcu;
+	int actual_clock;
+	/* Prepare to program display clock*/
+	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
+
+	/* Make sure requested clock isn't lower than minimum threshold*/
+	if (requested_clk_khz > 0)
+		requested_clk_khz = max(requested_clk_khz,
+				clk_mgr->base.dentist_vco_freq_khz / 62);
+
+	dce_clk_params.target_clock_frequency = requested_clk_khz;
+	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
+	dce_clk_params.clock_type = DCECLOCK_TYPE_DISPLAY_CLOCK;
+
+	bp->funcs->set_dce_clock(bp, &dce_clk_params);
+	actual_clock = dce_clk_params.target_clock_frequency;
+
+		if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
+			if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
+				dmcu->funcs->set_psr_wait_loop(dmcu,
+						actual_clock / 1000 / 7);
+		}
+
+	clk_mgr->dfs_bypass_disp_clk = actual_clock;
+	return actual_clock;
+
+}
+
+int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr)
+{
+	struct bp_set_dce_clock_parameters dce_clk_params;
+	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
+
+	memset(&dce_clk_params, 0, sizeof(dce_clk_params));
+
+	/*Program DP ref Clock*/
+	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
+	dce_clk_params.target_clock_frequency = 0;
+	dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
+	dce_clk_params.clock_type = DCECLOCK_TYPE_DPREFCLK;
+	if (!((clk_mgr->base.ctx->asic_id.chip_family == FAMILY_AI) &&
+	       ASICREV_IS_VEGA20_P(clk_mgr->base.ctx->asic_id.hw_internal_rev)))
+		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK =
+			(dce_clk_params.pll_id ==
+					CLOCK_SOURCE_COMBO_DISPLAY_PLL0);
+	else
+		dce_clk_params.flags.USE_GENLOCK_AS_SOURCE_FOR_DPREFCLK = false;
+
+	bp->funcs->set_dce_clock(bp, &dce_clk_params);
+
+	/* Returns the dp_refclk that was set */
+	return dce_clk_params.target_clock_frequency;
+}
+
 static void dce112_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
index 766b73c19365..dfb06db118e1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.h
@@ -26,8 +26,6 @@
 #ifndef DAL_DC_DCE_DCE112_CLK_MGR_H_
 #define DAL_DC_DCE_DCE112_CLK_MGR_H_
 
-/* dce112_set_dispclk and dce112_set_dprefclk are declared here. */
-#include "dcn10/dcn10_clk_mgr.h"
 
 void dce112_clk_mgr_construct(
 		struct dc_context *ctx,
@@ -35,5 +33,7 @@ void dce112_clk_mgr_construct(
 
 /* functions shared with other clk mgr */
 int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz);
+int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz);
+int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr);
 
 #endif /* DAL_DC_DCE_DCE112_CLK_MGR_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
index 75d5c90e7707..172bba20a156 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
@@ -7,7 +7,7 @@
 #include "dal_asic_id.h"
 #include "dcn10_clk_mgr.h"
 
-unsigned int dentist_get_divider_from_did(unsigned int did)
+unsigned int dcn10_dentist_get_divider_from_did(unsigned int did)
 {
 	if (did < DENTIST_BASE_DID_1)
 		did = DENTIST_BASE_DID_1;
@@ -41,7 +41,7 @@ unsigned int dentist_get_divider_from_did(unsigned int did)
  (should not be case with CIK) then SW should program all rates
  generated according to average value (case as with previous ASICs)
   */
-int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz)
+int dcn10_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz)
 {
 	if (clk_mgr_dce->ss_on_dprefclk && clk_mgr_dce->dprefclk_ss_divider != 0) {
 		struct fixed31_32 ss_percentage = dc_fixpt_div_int(
@@ -56,14 +56,14 @@ int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_r
 	return dp_ref_clk_khz;
 }
 
-int dce12_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+int dcn10_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 
-	return dce_adjust_dp_ref_freq_for_ss(clk_mgr_dce, clk_mgr_base->dprefclk_khz);
+	return dcn10_adjust_dp_ref_freq_for_ss(clk_mgr_dce, clk_mgr_base->dprefclk_khz);
 }
 
-void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
+void dcn10_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
 {
 	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
 	int ss_info_num = bp->funcs->get_ss_entry_number(
@@ -121,7 +121,7 @@ void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
 	}
 }
 
-int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
+int dcn10_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
 {
 	struct bp_set_dce_clock_parameters dce_clk_params;
 	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
@@ -154,7 +154,7 @@ int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
 
 }
 
-int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr)
+int dcn10_set_dprefclk(struct clk_mgr_internal *clk_mgr)
 {
 	struct bp_set_dce_clock_parameters dce_clk_params;
 	struct dc_bios *bp = clk_mgr->base.ctx->dc_bios;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
index e27486db4b62..99beafbf0092 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h
@@ -14,16 +14,16 @@ struct clk_mgr_internal;
 /*
  * Shared clock helpers referenced by both the DCE and DCN clock managers.
  */
-int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
+int dcn10_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
 
-void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce);
+void dcn10_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce);
 
-int dce12_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
+int dcn10_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
 
-unsigned int dentist_get_divider_from_did(unsigned int did);
+unsigned int dcn10_dentist_get_divider_from_did(unsigned int did);
 
-int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz);
+int dcn10_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz);
 
-int dce112_set_dprefclk(struct clk_mgr_internal *clk_mgr);
+int dcn10_set_dprefclk(struct clk_mgr_internal *clk_mgr);
 
 #endif /* __DCN10_CLK_MGR_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
index 06a51f47aed7..9450b1733f60 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c
@@ -26,8 +26,7 @@
 #include "core_types.h"
 #include "clk_mgr_internal.h"
 #include "rv1_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
-#include "dce112/dce112_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "rv1_clk_mgr_vbios_smu.h"
 #include "rv1_clk_mgr_clk.h"
 
@@ -303,14 +302,14 @@ static void rv1_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 
 static struct clk_mgr_funcs rv1_clk_funcs = {
 	.init_clocks = rv1_init_clocks,
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = rv1_update_clocks,
 	.enable_pme_wa = rv1_enable_pme_wa,
 };
 
 static struct clk_mgr_internal_funcs rv1_clk_internal_funcs = {
 	.set_dispclk = rv1_vbios_smu_set_dispclk,
-	.set_dprefclk = dce112_set_dprefclk
+	.set_dprefclk = dcn10_set_dprefclk
 };
 
 void rv1_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *clk_mgr, struct pp_smu_funcs *pp_smu)
@@ -342,7 +341,7 @@ void rv1_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *clk_
 		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
 			clk_mgr->dfs_bypass_enabled = true;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn10_clock_read_ss_info(clk_mgr);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c
index b9ba6dbc2b46..3a9849b4df74 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv2_clk_mgr.c
@@ -27,11 +27,11 @@
 #include "clk_mgr_internal.h"
 #include "rv1_clk_mgr.h"
 #include "rv2_clk_mgr.h"
-#include "dce112/dce112_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 
 static struct clk_mgr_internal_funcs rv2_clk_internal_funcs = {
-	.set_dispclk = dce112_set_dispclk,
-	.set_dprefclk = dce112_set_dprefclk
+	.set_dispclk = dcn10_set_dispclk,
+	.set_dprefclk = dcn10_set_dprefclk
 };
 
 void rv2_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *clk_mgr, struct pp_smu_funcs *pp_smu)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index cbd989b6a3df..86f3f32768e3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -26,7 +26,7 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
@@ -436,8 +436,8 @@ void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base)
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_WDIVIDER, &dppclk_wdivider);
 
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
-	dpp_divider = dentist_get_divider_from_did(dppclk_wdivider);
+	disp_divider = dcn10_dentist_get_divider_from_did(dispclk_wdivider);
+	dpp_divider = dcn10_dentist_get_divider_from_did(dppclk_wdivider);
 
 	if (disp_divider && dpp_divider) {
 		/* Calculate the current DFS clock, in kHz.*/
@@ -518,7 +518,7 @@ static void dcn2_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc
 }
 
 static struct clk_mgr_funcs dcn2_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = dcn2_update_clocks,
 	.init_clocks = dcn2_init_clocks,
 	.enable_pme_wa = dcn2_enable_pme_wa,
@@ -558,7 +558,7 @@ void dcn20_clk_mgr_construct(
 	/* DFS Slice 2 should be used for DPREFCLK */
 	dprefclk_did = REG_READ(CLK3_CLK2_DFS_CNTL);
 	/* Convert DPREFCLK DFS Slice DID to actual divider */
-	target_div = dentist_get_divider_from_did(dprefclk_did);
+	target_div = dcn10_dentist_get_divider_from_did(dprefclk_did);
 	/* get FbMult value */
 	pll_req_reg = REG_READ(CLK3_CLK_PLL_REQ);
 
@@ -588,5 +588,5 @@ void dcn20_clk_mgr_construct(
 	//Also there is no plan for now that DFS BYPASS will be used on NV10/12/14.
 	clk_mgr->dfs_bypass_enabled = false;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn10_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
index 76c612ecfe3c..7ab548e41b40 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 #include "dcn201_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
 #include "dm_helpers.h"
 #include "dm_services.h"
 
@@ -170,7 +170,7 @@ static void dcn201_update_clocks(struct clk_mgr *clk_mgr_base,
 }
 
 static struct clk_mgr_funcs dcn201_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = dcn201_update_clocks,
 	.init_clocks = dcn201_init_clocks,
 	.get_clock = dcn2_get_clock,
@@ -213,5 +213,5 @@ void dcn201_clk_mgr_construct(struct dc_context *ctx,
 		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
 			clk_mgr->dfs_bypass_enabled = true;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn10_clock_read_ss_info(clk_mgr);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index b5378344d2bc..488ae92d24fa 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -26,6 +26,7 @@
 #include "dccg.h"
 #include "rn_clk_mgr.h"
 
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dml/dcn20/dcn20_fpu.h"
 
@@ -565,7 +566,7 @@ static void rn_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc_l
 }
 
 static struct clk_mgr_funcs dcn21_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = rn_update_clocks,
 	.init_clocks = rn_init_clocks,
 	.enable_pme_wa = rn_enable_pme_wa,
@@ -770,7 +771,7 @@ void rn_clk_mgr_construct(
 	rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
 
 	clk_mgr->base.dprefclk_khz = 600000;
-	dce_clock_read_ss_info(clk_mgr);
+	dcn10_clock_read_ss_info(clk_mgr);
 
 
 	clk_mgr->base.bw_params = &rn_bw_params;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 5641f9089b0b..80bdaf762a23 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -26,8 +26,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 #include "dcn30_clk_mgr_smu_msg.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
 #include "dcn30/dcn30_clk_mgr.h"
 #include "dml/dcn30/dcn30_fpu.h"
 #include "dcn30/dcn30m_clk_mgr.h"
@@ -493,7 +493,7 @@ static void dcn30_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct d
 }
 
 static struct clk_mgr_funcs dcn3_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 		.update_clocks = dcn3_update_clocks,
 		.init_clocks = dcn3_init_clocks,
 		.notify_wm_ranges = dcn3_notify_wm_ranges,
@@ -517,7 +517,7 @@ static void dcn3_init_clocks_fpga(struct clk_mgr *clk_mgr)
 }
 
 struct clk_mgr_funcs dcn3_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = dcn2_update_clocks_fpga,
 	.init_clocks = dcn3_init_clocks_fpga,
 };
@@ -567,7 +567,7 @@ void dcn3_clk_mgr_construct(
 
 	clk_mgr->smu_present = false;
 
-	dce_clock_read_ss_info(clk_mgr);
+	dcn10_clock_read_ss_info(clk_mgr);
 
 	clk_mgr->base.bw_params = kzalloc_obj(*clk_mgr->base.bw_params);
 	if (!clk_mgr->base.bw_params) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index e40bbc495fc4..ace3ceb228c6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -26,8 +26,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -482,7 +482,7 @@ static bool vg_are_clock_states_equal(struct dc_clocks *a,
 
 
 static struct clk_mgr_funcs vg_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = vg_update_clocks,
 	.init_clocks = vg_init_clocks,
 	.enable_pme_wa = vg_enable_pme_wa,
@@ -748,7 +748,7 @@ void vg_clk_mgr_construct(
 	vg_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, &clk_mgr->base.base, &log_info);
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 
 	clk_mgr->base.base.bw_params = &vg_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index ff47af3854b6..938bc2bbe6d7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -666,7 +666,7 @@ int dcn31_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 }
 
 static struct clk_mgr_funcs dcn31_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn31_update_clocks,
 	.init_clocks = dcn31_init_clocks,
@@ -744,9 +744,9 @@ void dcn31_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
-	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
+	//clk_mgr->base.dccg->ref_dtbclk_khz = dcn10_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn31_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 24f6304011ae..2aa3e8e66cb7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -31,8 +31,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -200,7 +200,7 @@ void dcn314_init_clocks(struct clk_mgr *clk_mgr)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn314_is_spll_ssc_enabled(clk_mgr))
 		clk_mgr->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+			dcn10_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
 }
@@ -766,7 +766,7 @@ static void dcn314_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *cl
 }
 
 static struct clk_mgr_funcs dcn314_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn314_update_clocks,
 	.init_clocks = dcn314_init_clocks,
@@ -861,7 +861,7 @@ void dcn314_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 	dcn314_read_ss_info_from_lut(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 75d39cb26dba..6ba7cff2ce05 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
@@ -600,7 +600,7 @@ static void dcn315_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 }
 
 static struct clk_mgr_funcs dcn315_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn315_update_clocks,
 	.init_clocks = dcn31_init_clocks,
@@ -675,8 +675,8 @@ void dcn315_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
-	dce_clock_read_ss_info(&clk_mgr->base);
-	clk_mgr->base.base.clks.ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
+	clk_mgr->base.base.clks.ref_dtbclk_khz = dcn10_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn315_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index c7fecbdfda2c..96bd653a9b71 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -28,8 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
@@ -576,7 +576,7 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 
 static struct clk_mgr_funcs dcn316_funcs = {
 	.enable_pme_wa = dcn316_enable_pme_wa,
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn316_update_clocks,
 	.init_clocks = dcn31_init_clocks,
@@ -659,9 +659,9 @@ void dcn316_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn316_smu_get_dpref_clk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 	/*clk_mgr->base.dccg->ref_dtbclk_khz =
-	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
+	dcn10_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
 
 	clk_mgr->base.base.bw_params = &dcn316_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index f9886a0eca92..22dfca6efba6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -26,8 +26,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 #include "dcn32/dcn32_clk_mgr_smu_msg.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
 #include "dcn32/dcn32_clk_mgr.h"
 #include "reg_helper.h"
@@ -409,7 +409,7 @@ static void dcn32_update_clocks_update_dentist(
 		}
 	} else if (new_dispclk_wdivider == 127 && old_dispclk_wdivider != 127) {
 		/* request clock with 126 divider first */
-		uint32_t temp_disp_divider = dentist_get_divider_from_did(126);
+		uint32_t temp_disp_divider = dcn10_dentist_get_divider_from_did(126);
 		uint32_t temp_dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / temp_disp_divider;
 
 		if (clk_mgr->smu_present)
@@ -490,7 +490,7 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	disp_divider = dcn10_dentist_get_divider_from_did(dispclk_wdivider);
 
 	/* Return DISPCLK freq in Khz */
 	if (disp_divider)
@@ -922,31 +922,31 @@ static void dcn32_dump_clk_registers(struct clk_state_registers_and_bypass *regs
 	}
 
 	/* Convert DISPCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dispclk_did);
+	target_div = dcn10_dentist_get_divider_from_did(dispclk_did);
 	//Get dispclk in khz
 	regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DISPCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dppclk_did);
+	target_div = dcn10_dentist_get_divider_from_did(dppclk_did);
 	//Get dppclk in khz
 	regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DPREFCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dprefclk_did);
+	target_div = dcn10_dentist_get_divider_from_did(dprefclk_did);
 	//Get dprefclk in khz
 	regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DCFCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dcfclk_did);
+	target_div = dcn10_dentist_get_divider_from_did(dcfclk_did);
 	//Get dcfclk in khz
 	regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 	/* Convert DTBCLK DFS Slice DID to divider*/
-	target_div = dentist_get_divider_from_did(dtbclk_did);
+	target_div = dcn10_dentist_get_divider_from_did(dtbclk_did);
 	//Get dtbclk in khz
 	regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz) / target_div;
@@ -1139,7 +1139,7 @@ static void dcn32_set_min_memclk(struct clk_mgr *clk_mgr_base, unsigned int memc
 }
 
 static struct clk_mgr_funcs dcn32_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 		.update_clocks = dcn32_update_clocks,
 		.dump_clk_registers = dcn32_dump_clk_registers,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index a69824e1eb26..990c362623d8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -29,8 +29,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -758,7 +758,7 @@ void dcn35_init_clocks(struct clk_mgr *clk_mgr)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn35_is_spll_ssc_enabled(clk_mgr))
 		clk_mgr->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
+			dcn10_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr->dprefclk_khz);
 	else
 		clk_mgr->dp_dto_source_clock_in_khz = clk_mgr->dprefclk_khz;
 
@@ -1346,7 +1346,7 @@ static unsigned int dcn35_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum c
 }
 
 static struct clk_mgr_funcs dcn35_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn35_update_clocks,
 	.init_clocks = dcn35_init_clocks,
@@ -1360,7 +1360,7 @@ static struct clk_mgr_funcs dcn35_funcs = {
 };
 
 struct clk_mgr_funcs dcn35_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = dcn35_update_clocks_fpga,
 	.init_clocks = dcn35_init_clocks_fpga,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1499,7 +1499,7 @@ void dcn35_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = dcn35_smu_get_dprefclk(&clk_mgr->base);
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn35_read_ss_info_from_lut(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 6ee3da89d058..6d791a5d9776 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -5,8 +5,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 #include "dcn401/dcn401_clk_mgr_smu_msg.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
-#include "dce100/dce_clk_mgr.h"
 #include "dcn31/dcn31_clk_mgr.h"
 #include "dcn32/dcn32_clk_mgr.h"
 #include "dcn401/dcn401_clk_mgr.h"
@@ -358,37 +358,37 @@ static void dcn401_dump_clk_registers(struct clk_state_registers_and_bypass *reg
 		fclk_did = REG_READ(CLK2_CLK2_DFS_CNTL);
 
 		/* Convert DISPCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dispclk_did);
+		target_div = dcn10_dentist_get_divider_from_did(dispclk_did);
 		//Get dispclk in khz
 		regs_and_bypass->dispclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DISPCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dppclk_did);
+		target_div = dcn10_dentist_get_divider_from_did(dppclk_did);
 		//Get dppclk in khz
 		regs_and_bypass->dppclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DPREFCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dprefclk_did);
+		target_div = dcn10_dentist_get_divider_from_did(dprefclk_did);
 		//Get dprefclk in khz
 		regs_and_bypass->dprefclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DCFCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dcfclk_did);
+		target_div = dcn10_dentist_get_divider_from_did(dcfclk_did);
 		//Get dcfclk in khz
 		regs_and_bypass->dcfclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DTBCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(dtbclk_did);
+		target_div = dcn10_dentist_get_divider_from_did(dtbclk_did);
 		//Get dtbclk in khz
 		regs_and_bypass->dtbclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
 
 		/* Convert DTBCLK DFS Slice DID to divider*/
-		target_div = dentist_get_divider_from_did(fclk_did);
+		target_div = dcn10_dentist_get_divider_from_did(fclk_did);
 		//Get fclk in khz
 		regs_and_bypass->fclk = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 				* clk_mgr->base.dentist_vco_freq_khz) / target_div;
@@ -1552,7 +1552,7 @@ static int dcn401_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	disp_divider = dcn10_dentist_get_divider_from_did(dispclk_wdivider);
 
 	/* Return DISPCLK freq in Khz */
 	if (disp_divider)
@@ -1599,7 +1599,7 @@ static void dcn401_execute_clk_mgr_block_sequence_bls(struct clk_mgr *clk_mgr_ba
 }
 
 static struct clk_mgr_funcs dcn401_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn401_get_dtb_ref_freq_khz,
 		.update_clocks = dcn401_update_clocks,
 		.dump_clk_registers = dcn401_dump_clk_registers,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 19ef0b92e8e6..a2ecde8362a5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -7,8 +7,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -625,7 +625,7 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
 		clk_mgr_base->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
+			dcn10_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
 	else
 		clk_mgr_base->dp_dto_source_clock_in_khz = clk_mgr_base->dprefclk_khz;
 
@@ -912,7 +912,7 @@ int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 	unsigned int disp_divider;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
-	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	disp_divider = dcn10_dentist_get_divider_from_did(dispclk_wdivider);
 
 	/* Return DISPCLK freq in Khz */
 	if (disp_divider)
@@ -1074,7 +1074,7 @@ void dcn42_request_dtbclk(struct clk_mgr *clk_mgr_base, bool enable)
 	}
 }
 static struct clk_mgr_funcs dcn42_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn42_update_clocks,
 	.init_clocks = dcn42_init_clocks,
@@ -1091,7 +1091,7 @@ static struct clk_mgr_funcs dcn42_funcs = {
 };
 
 struct clk_mgr_funcs dcn42_fpga_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.update_clocks = dcn42_update_clocks_fpga,
 	.init_clocks = dcn42_init_clocks_fpga,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1153,7 +1153,7 @@ void dcn42_clk_mgr_construct(
 		/* Saved clocks configured at boot for debug purposes */
 		dcn42_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn42_read_ss_info_from_lut(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 770b2351c631..90cc2c3aabe4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -9,8 +9,8 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 
-// For dce12_get_dp_ref_freq_khz
-#include "dce100/dce_clk_mgr.h"
+// For dcn10_get_dp_ref_freq_khz
+#include "dcn10/dcn10_clk_mgr.h"
 
 // For dcn20_update_clocks_update_dpp_dto
 #include "dcn20/dcn20_clk_mgr.h"
@@ -234,7 +234,7 @@ void dcn42b_init_clocks(struct clk_mgr *clk_mgr_base)
 	// to adjust dp_dto reference clock if ssc is enable otherwise to apply dprefclk
 	if (dcn42_is_spll_ssc_enabled(clk_mgr_base))
 		clk_mgr_base->dp_dto_source_clock_in_khz =
-			dce_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
+			dcn10_adjust_dp_ref_freq_for_ss(clk_mgr_int, clk_mgr_base->dprefclk_khz);
 	else
 		clk_mgr_base->dp_dto_source_clock_in_khz = clk_mgr_base->dprefclk_khz;
 
@@ -418,7 +418,7 @@ static void dcn42b_update_clocks(struct clk_mgr *clk_mgr_base,
 }
 
 static struct clk_mgr_funcs dcn42b_funcs = {
-	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn42b_update_clocks,
 	.init_clocks = dcn42b_init_clocks,
@@ -657,7 +657,7 @@ void dcn42b_clk_mgr_construct(
 		/* Saved clocks configured at boot for debug purposes */
 		dcn42b_dump_clk_registers(&clk_mgr->base.base.boot_snapshot, clk_mgr);
 
-	dce_clock_read_ss_info(&clk_mgr->base);
+	dcn10_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn42b_read_ss_info_from_lut(&clk_mgr->base);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 267e5060c6b1..40e975e8a550 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -6,7 +6,7 @@
 #include "clk_mgr_internal.h"
 #include "dcn60/dcn60_clk_mgr_smu_msg.h"
 #include "hw_sequencer.h"
-#include "dce100/dce_clk_mgr.h"
+#include "dcn10/dcn10_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dcn401/dcn401_clk_mgr.h"
 #include "dcn60/dcn60_clk_mgr.h"
@@ -1584,7 +1584,7 @@ static void dcn60_execute_clk_mgr_block_sequence_bls(struct clk_mgr *clk_mgr_bas
 }
 
 static struct clk_mgr_funcs dcn60_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn60_get_dtb_ref_freq_khz,
 		.update_clocks = dcn60_update_clocks,
 		.dump_clk_registers = dcn60_dump_clk_registers,
-- 
2.43.0


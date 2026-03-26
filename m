Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14D8109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07F310E934;
	Thu, 26 Mar 2026 03:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x/jR1/Mc";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7359810E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4qs89PduOKilpvwuxapXtN+Hm47zKqq6tMOLk1h03W4a3c7xa5dsgVr4ZM+pwOa0ELx7C5PROPjoeY1oFiaJZaDjnQInTTFCbvzkV2tCencAvB5JJX83t2k6eY2RRLh0A80pM01qSk5HUPp/pRPShVjrbzb4KRfDXEd00BpCmgrFizLqG8NGtNxOOgSPNnjJBIqbpipDdYWX20xQge8mWGNQM8NvHGDj18uzLC47UCGuiVPthMtPZT5Zx6e2i6FjjrtggbBExdpKR4p/jRqZ7ZuofxGENq3e09BKgjWoB3sMmVerSdgX6h/NfWUH7W0J7bSqq290j4IXJ814xS7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PtbzIx1WaKAzmxwwF1yokOmxoIPFtGDKThUUfKtK1o=;
 b=DXKyaY6Y5hOi26sJFrgfYMv9kYF7HILTQiGYAsh3tzE+YKnJtlXq74LPnwGsCIMpEfHVwet0M7X8O+0CCcw8X/ndz+XfhxOpAuWc6fnRIiZCxEz2IrGf8NxpCqWBavKcrjSdmtCIVmJM/fBUNX1Qb+GtqDh/n8DUBdM7Z7NPlkPidpps+6A7JcVyCxgwmtOd0mR7AJOKc99R/UY529K/+/lXRNXRPfD5IGjCvVacZRG8EffQjPMsrx9GR9mB1Vay5ZDW0Wnyg+dSMNsn04szTubnVViyD/M3CxPgbWSK5/N8TKohXALs7OBOj+KVzyrDASibKKysS/LtGkQDHvEopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PtbzIx1WaKAzmxwwF1yokOmxoIPFtGDKThUUfKtK1o=;
 b=x/jR1/McmGQ7BkT111Fi9ejiCFjg1LqhDyCMkVtsrdQ1bhX9/78a++xCRnNN4fKbFOqfbpvkVWPg1TzNDnAKUFsTuFSWsYe7TvRhc1nYKtbs7NgzEyQQQz6Qh99aeiiKv+giRe7G7ERUe2LN3wtZwUON5bMJeI7xlOro2/kD51U=
Received: from BL1PR13CA0165.namprd13.prod.outlook.com (2603:10b6:208:2bd::20)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:06 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::19) by BL1PR13CA0165.outlook.office365.com
 (2603:10b6:208:2bd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.20 via Frontend Transport; Thu,
 26 Mar 2026 03:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:05 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:00 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 10/30] drm/amd/display: eliminate clock manager code
 duplication
Date: Thu, 26 Mar 2026 10:57:01 +0800
Message-ID: <20260326030153.406612-11-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ec95c2-4b15-4cf2-169f-08de8ae3ec22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: T6Wl0E4x4bwo06Ux9VrkH55U3xZtCjpqpS9/Py+3dbNbFye8B+aRv+0ILTmmTRmj9v2yXYgmx8QSkGiei8t/tVJGBnSzN6hXgduVcXZKq9VoNNkvmJjv0ojXYLy1W7/TUA06Q87ytcyPE8FHeAIOgp+4wGRPdN/eOYOkPnacChODio+Yxw+hw7D5b17uHSCfbWHPVrpztaoIedDBhNNzrHugkJvA0j4m5lqL5oyqxDilFi9pl4c1WoBVs3+DTbRgTpTksAv82ZKvun7EChyplGdlOkiJhjtnpza4y8prY2K36PoWu5GFFeANVLT/9Z59pZX1Xj1z7Vgidi5+KdT5OG+o9xPb3/hy8CX45X5ft/q5QQA8KhDJNOL/5SQs2CEU+bJg++3U1tSH0quMqKjk9GSZ3mldaOq6ox8QGN2BmTi+l0Z2eFQLq5fYfOd+kPqo2Er/OZYSVDGim6/4NczoBd7LqX3WrgkcjtRPrIIsBs/chmBm05OI0a7D91nb2uIWjSu9U+nN6sRIc98rsOaLqcXFsAxYrL7uthbVXbmQ/qyEBcLt+IofYLXIgJmKCP5JWR2+yMrZgfw6pareou2Fr4CevjN5RY3dkuHlsf1IcuiGzI61+Cy666/V/uON2llejKmv9zCEwgjs5BjwEwA36KUkQgDE69LdxUJnV+WaQodoib/xRS64GuWbWPwU0PlV9mbs5ogoDHJyrZ6LSnZPGIzKSQS0RCIetaUV9GAbzz1qz9l5Th+HLc4DjS9pg8O1c/Zn9yvQ1VYy8nG6Z7epfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: brMdRwWrmMt0QR6oco0h0/rgqGaCVfXzEO6UOzT9kvtNyS9PiuEK9OIjtY8oeCr/mOBinhc2rQoM1YPFullLBndqzC2XiTcBuCMtIIIWdWF5jbttrWsEGmNnSPjA868/w30OoUCMALP/gVNKmnykgb8XajwBaOhFIgYi3ZTxon4/5PstDhCCyXMG7xG20Kfx6bTPOtvBwOhTqXJQ9GUQKt8BhpyFhyflOofDDYxbi9yxPLKldFczck25dgVD6rYu67+TaOUaaw6tnJ9OAvgaNZ8jMvgXypHLOpGqFjN0TMXfc7AddeXd7brsCDyv1IvJOWOvJfOjyBLfmwusTfT5lmLUrS3JFQRc6I4MVni8A8JQBwsVBj5Qa8NvKxKNl6+tnhJtRIwels4UkUv3pH3TLPAKXKmeQS5cuAUUiOtQ/ANcreH4SstpHFUuKnCE2iDA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:05.6674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ec95c2-4b15-4cf2-169f-08de8ae3ec22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Clock manager contained significant duplicate code between
variants with identical logic for functions using only SMU
calls or shared registers. This increases maintenance overhead
and potential for bugs.

[How]
Expose clock constants and internal functions in header for
sharing. Remove duplicate implementations and update function
pointers to use shared functions. Refactor remaining
variant-specific functions to use shared constants and helper
functions. Add compatibility comments for hardware differences.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 26 ++++++++++---------
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |  8 +++++-
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index b4c6522e922c..97f182bfc9ca 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -43,8 +43,6 @@
 #define DC_LOGGER_INIT(logger) \
 	struct dal_logger *dc_logger = logger
 
-#define DCN42_CLKIP_REFCLK 48000
-
 #undef FN
 #define FN(reg_name, field_name) \
 	clk_mgr->clk_mgr_shift->field_name, clk_mgr->clk_mgr_mask->field_name
@@ -255,6 +253,10 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 			dcn42_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
+		/* Only attempt to enable dtbclk if currently disabled AND new state requests it.
+		 * For dcn42b (no dtbclk hardware), init_clk_states sets dtbclk_en=false and
+		 * new_clocks->dtbclk_en should always be false, so this block never executes.
+		 */
 		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
 			int actual_dtbclk = 0;
 
@@ -326,7 +328,7 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
-	if (!dc->debug.disable_dtb_ref_clk_switch &&
+	if (!dc->debug.disable_dtb_ref_clk_switch && new_clocks->dtbclk_en &&
 	    should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000,
 			     clk_mgr_base->clks.ref_dtbclk_khz / 1000)) {
 		dcn42_update_clocks_update_dtb_dto(clk_mgr, context, new_clocks->ref_dtbclk_khz);
@@ -519,7 +521,7 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
 }
 
-static void dcn42_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+void dcn42_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct dcn42_smu_dpm_clks *smu_dpm_clks)
 {
 	DpmClocks_t_dcn42 *table = smu_dpm_clks->dpm_clks;
@@ -842,7 +844,7 @@ static void dcn42_init_clocks_fpga(struct clk_mgr *clk_mgr)
 
 }
 
-static void dcn42_update_clocks_fpga(struct clk_mgr *clk_mgr,
+void dcn42_update_clocks_fpga(struct clk_mgr *clk_mgr,
 		struct dc_state *context,
 		bool safe_to_lower)
 {
@@ -895,13 +897,13 @@ static void dcn42_update_clocks_fpga(struct clk_mgr *clk_mgr,
 	// Both fclk and ref_dppclk run on the same scemi clock.
 	clk_mgr_int->dccg->ref_dppclk = clk_mgr->clks.fclk_khz;
 
-	/* TODO: set dtbclk in correct place */
-	clk_mgr->clks.dtbclk_en = true;
-
 	dm_set_dcn_clocks(clk_mgr->ctx, &clk_mgr->clks);
+	if (clk_mgr->clks.dtbclk_en) {
+		dcn42_update_clocks_update_dtb_dto(clk_mgr_int, context, clk_mgr->clks.ref_dtbclk_khz);
+	} else {
+		clk_mgr->clks.ref_dtbclk_khz = 0;
+	}
 	dcn42_update_clocks_update_dpp_dto(clk_mgr_int, context, safe_to_lower);
-
-	dcn42_update_clocks_update_dtb_dto(clk_mgr_int, context, clk_mgr->clks.ref_dtbclk_khz);
 }
 
 unsigned int dcn42_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type clk_type)
@@ -933,7 +935,7 @@ unsigned int dcn42_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type
 	return 0;
 }
 
-static int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
+int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	uint32_t dispclk_wdivider;
@@ -954,7 +956,7 @@ bool dcn42_is_smu_present(struct clk_mgr *clk_mgr_base)
 	return clk_mgr->smu_present;
 }
 
-static void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
+void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
 {
 	struct clk_mgr *clk_mgr_base = &clk_mgr_int->base;
 	struct dcn42_smu_dpm_clks smu_dpm_clks = { 0 };
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
index 5ad027a9edaf..42aea81fb61c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
@@ -27,6 +27,7 @@
 #include "clk_mgr_internal.h"
 
 #define NUM_CLOCK_SOURCES 5
+#define DCN42_CLKIP_REFCLK 48000
 
 struct dcn42_watermarks;
 
@@ -71,9 +72,14 @@ void dcn42_set_low_power_state(struct clk_mgr *clk_mgr_base);
 void dcn42_exit_low_power_state(struct clk_mgr *clk_mgr_base);
 unsigned int dcn42_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type clk_type);
 bool dcn42_is_smu_present(struct clk_mgr *clk_mgr_base);
+bool dcn42_has_active_display(struct dc *dc, const struct dc_state *context);
 int dcn42_get_active_display_cnt_wa(struct dc *dc, struct dc_state *context, int *all_active_disps);
 void dcn42_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr, struct dc_state *context, bool safe_to_lower);
 void dcn42_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr, struct dc_state *context, int ref_dtbclk_khz);
 bool dcn42_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base);
-bool dcn42_has_active_display(struct dc *dc, const struct dc_state *context);
+struct dcn42_smu_dpm_clks; /* Forward declaration for pointer parameter below */
+void dcn42_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr, struct dcn42_smu_dpm_clks *smu_dpm_clks);
+void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int);
+void dcn42_update_clocks_fpga(struct clk_mgr *clk_mgr, struct dc_state *context, bool safe_to_lower);
+int dcn42_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base);
 #endif //__DCN42_CLK_MGR_H__
-- 
2.43.0


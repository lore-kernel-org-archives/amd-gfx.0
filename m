Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5BAFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A2510E7A2;
	Wed, 25 Mar 2026 07:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4fETnDyy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF1710E7A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chZYvq9ZIjP1Qy7Og0phdzCvoUBbdSdCeqXDt6TJd4VfCC3QV99JX6om93lNVqDh/+ledvFWOt6nxRYtiVr4oUe1HI6q+AXOOHVqWa9ZDI55RF1qvqvt4bTKKuYLngUlc59DbW5MvOIYTp4sL/a76dayipDgEkLko1+pks/0DMh936+uP67eSrFtRhkNmKQ2uTFqy7Uk48O4yb5U2zMsgwmtghqO/68zRFVNErm64tlaCXMno9gMq/GMQoJvs/JPWL0AYrPhoE2uk8hdWOgdTndlnSRRhKKrdOZGNyfsZXYgXZP0jf2jcoF7PLMYk56Pvv2wDQhmAx8xooczM7QEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PtbzIx1WaKAzmxwwF1yokOmxoIPFtGDKThUUfKtK1o=;
 b=zLJ0YkfPfU8NGWrqq5EdSeTsNYKkL22Zk98WYOIHykTAJLcrXKSh3DbAvd5VkVIbt/0qkYZGh9LnouP9hZ6tH926a6x77rSZ1rpTs4hiFP4MxhsFHYfh2J1JGPvgC+UqsTW0SZ1g/L/joK2e4u6qqUZ+ijediIKE+IPfV9DBHRDudut5oVlSE+H94vQBA1zFkanagdymEqQpQtJig1aOa17omDXWBPWF7R8R2UUftW0/z05i3FFIQKXmfir6CdNqJ48OjZEVsGO4Lz28qp/X0PqxC8yvt8rGwuFza4qF+6tM6er5LPzzfCbXtKRT9xJDIMlQPyt35skxsdMHTasd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PtbzIx1WaKAzmxwwF1yokOmxoIPFtGDKThUUfKtK1o=;
 b=4fETnDyykMdwdPzC0yWfkRO8tLhG0653DGO8N4VMQNG1aiJat0siSKHfueVjVRfBZjfeAABPn+atdv2E5e67DWGvcsWPYyQkPeb+Gm79rXXCgUqtcNcImeSbafb/1BbF45YiglX3byKzkAvnTTWs+Nj77BdGvYwCuz7TnGJDHis=
Received: from BLAPR03CA0031.namprd03.prod.outlook.com (2603:10b6:208:32d::6)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:10 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::b9) by BLAPR03CA0031.outlook.office365.com
 (2603:10b6:208:32d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 07:08:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:08 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:05 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 09/29] drm/amd/display: eliminate clock manager code
 duplication
Date: Wed, 25 Mar 2026 15:06:15 +0800
Message-ID: <20260325071003.4022594-10-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad4d8f9-dd47-4c2d-85ec-08de8a3d68db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bajYC2k46a13d2+oIjBk7kn/xlPSxglPeIWcsRZttjU4yoZeMADo7B5g8+zHrX9FEuOUze5Ci2xYjjVrCu1ZwHV7rFvhFhn74BkUV7HiCeADX1MxFv93gSrYzokcEyRNASDMYXrrroj2r6AOrs/FjNFvS+qQGg5hjHT3V0m/Bpr+x6mlxydaNzKUif9leuWUdVkLLbL2L/qZ2uCrjixofDN/OSPfFuFfrhK0oo7zphoLgr2qG4ncOJ+NSotaVBOQdfMbUI0Xnnz3MUCJQJI+JE8Q8tIhppzfbEsqlaWNH94xW3vV+xSW1fyjhf7fGqrsSfPfUZnSvLVsAUpub+wJj9Fw/xztc/cLpmPb3GFA3m6N1dEkU9Gadc3FxhSaAhWN1RJfhYB7nRIh/xuTJtxTRHnV899BtLLM0VrOaSXBlNrFh+vEBfyVdae3pdO4LcogqtjyX29+gvhHLqDcKjpiqZnauqGfdKNFF7kL7bC6z+CtQixTgOcBh0qxmEg3WjSeTH486ZT4cAa+zelc3czfLn/ihs+bnJTti1jvMteiLt6Kkk+kTUPd0LL/qXq4gVEQtnozvPqvimgW53ywU2i1xDxwWsf+4ZApxNu2xP4Ip/IAPvYoNVNCs6PqNMNjrHFWzA7sSHSWAdwzO7fhMMHuhKMu/X8qHJDVFdEITRkNMRjBGSmGVppN2UoGrVbPf3ZueTclebldHQr1OeegIKe/qMarYHPyP71ZNKXDTot/xAwiLlsot97V0uBvnW+yWGYmwTPhVwFVkrYMntEGfaeLqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7oW6q5ZWBKfMYBbiK5vLG1K7yfjJWfF73000A1UlCgP04ia/o1BDfrX5IMMyWLmqM73egwPd7QlfJJfrBq8sL1hWvk7BMOdnwxoecwnIvtOZWqgLX7sSG5SpbxUyv4yWpl4HRY+0oYGXtWezhdc5k438rtlxiyIuK1JuJsfzsnaf5yu5J2js1FwKmurluYdU9l4UQJVSE8NYoOX/npzwErfGKf+n//ktGo8EDx7hR1rYOf2jcvMkSy4ZiUuW4DLYm1sdEGNR6seL85tilva59MbgmY04RGV6ozyqK6SpCxa8M9hvnAj+1m5Qa8hSNjKbuvANe7b8rLsV6cqBgWVSFEwOZ3p4Mf4dLlTHS414ehKEGSv+ApqhgxciJ7SJH2PWoGRZpp893buVT2Dw4lNa4bGSimlcdKdGkqt+wlx0QEcvVyTucxEyG5yn72RQc2wg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:08.9671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad4d8f9-dd47-4c2d-85ec-08de8a3d68db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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


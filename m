Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8AAC77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055D210E51F;
	Wed, 10 May 2023 20:49:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1D210E51F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky6/gzTMGxCkA/ZpI7TvUaXyO8OZtkSaok9jNb7Lm8MoSlGoc+vznlJkg72u26lRQ68LJ85d5juTujzZjpsO+Xz2sheS+f5FEPTjtLAzTwOHEp1l0fUnei6Gjsquz9an8erZjYQavy47Xq4UcEVGwfO//OQ04LiF86tMyk54F8c7OdA23hkXapsbTiA79xcN5HgImMNVG53V0MycBPVD9/bgtk8kDM/1VcHTmYDYhD1nHRYF02SMR81KHw4OJD71d6t7Yx0cHpjmH8xnZ7j4X4020vUkVC90zJWf7s4AUAfL6ItwlZT2gNCKGB90sRT3dBrGjYRXS28q5T2c1cT/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKxm9UOZCNA/zEqGqy3oym/nb8iqZnHAz4YAlt8KjKU=;
 b=VKck/zEHaNh/JG2chzKIFi7rHmMVe3NpQttF1VP+qZYJYz5fxfagVYNuIUOV1Ux2B/GWCljKlOZ2IeIGT3URPoTogbfpaBX7/KOcmOIzR0ijaLqn64c1GEogQBgvN5pMrcPLcPVQBZckhaNGoNAmDwOQMQV/xvbqsf7UGpYqkc7UuFCuIfm+qN+YdaAc1/IDgdPJtvDa/uOE9q+h7pZ7Ym67F6XgsK6QHbDBYPLdLOEwINRUC9aVHc9UrORHCHawOQeohnZm64ef47h5EUUM8JjGBlinGw/bamNBwmMduOLOFxqoFj4+JpXaJRKnxFdeZZ+a7Ni2a7QpkmIuWW5jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKxm9UOZCNA/zEqGqy3oym/nb8iqZnHAz4YAlt8KjKU=;
 b=W2wGpRoNkg40chpliwEyZT7KQd7NXrYDdFrQ5Wb+/P0SccnkeOH7f9f9pQvJSaZdKs4UNb1kcJQMehoFbw4vuhEGAOBqw+7ERyQso48WlVv+sZUvJDyhmEeIwvjm01+LotSeRsle2Qe3Y0X2c0/XK17Jo3ssdruzSzUsWO0G/xk=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:49:05 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::19) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 20:49:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 20:49:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:04 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amd/display: Only skip update for DCFCLK, UCLK,
 FCLK on overclock
Date: Wed, 10 May 2023 16:48:52 -0400
Message-ID: <20230510204900.949963-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: d562d3e0-e330-4bf8-5706-08db5197fe24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcLLegSNY8ejWTfoffD10+QZJttSWtM9ibFuaQhhNf3/PHEdsaT5exlu9GbkFWRpx9osOLdZ/GU0x31d0ATpNi8Drej1Y4jtvq77TV/WukhrQPtE+s5F64+lSr/spfTGthz4+tQCDcGLjcR9EUc8r8i8jsqT4abquop8dR/AtLaEhOBau/1FmV2NNmmT3j7wOd6ZJTQJkv2AHihOePuVfzr4Eau5bpejy8qfWBzlPe2Vb1eAqFyvs21z5BfPrz6/hL4Xtla2iLNipFKjCjSkAC1hkvP6hwn0GCtUGgMKt/CReXTPcF8KobilNRMXs3XiaHRvJcGDqLY6HZn6nJo1Ghm7YT0p6XioA20MCzjZ/bprVFG+lehdhCyFkgJbnRbY/Bnm33NJgkghyHyTnKMfrtwSgwyOZhnOXZCssF5OUxtRN/JZjFihWV+jkeR0Dv0UuNeTKlQmJyn6cthK59JCLds4l5J9HZBYbNX6nb5+oAVKfzanEAXjbJgNPsPyVZhU7WoCJhl3RQ9leQ9cAcT8+OuRWxaXvCGrYEGmiJ5sPKa5XykFu/RwAVKSypc9+uqH95E7/LrT6SMcRprrj+MI4+YT61CeeVdlJDeWggDV3tWwesA7tkQI34kyDftwJsQRk687rqG5aiMJAuhAQy1ckfnLtPDDcUCHErzCtMldwiXB7ebwGWZ0nNjj8sj2hjm00hfV1xHjLV8O6kR0OSEEsCq/ifNQjOAnV8qq0JpWcko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(6916009)(6666004)(4326008)(5660300002)(44832011)(316002)(81166007)(82310400005)(41300700001)(82740400003)(26005)(70206006)(70586007)(86362001)(15650500001)(1076003)(54906003)(2906002)(8936002)(8676002)(186003)(356005)(7696005)(478600001)(36860700001)(36756003)(47076005)(83380400001)(40460700003)(336012)(426003)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:04.8294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d562d3e0-e330-4bf8-5706-08db5197fe24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
- Update clocks is skipped in the GPU overclock sequence
- However, we still need to update DISPCLK, DPPCLK, and DTBCLK
  because the GPU overclock sequence could temporarily disable
  ODM 2:1 combine because we disable all planes in the sequence

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 24 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 +++++-
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 85e963ec25ab..1df623b298a9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -460,9 +460,6 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool p_state_change_support;
 	bool fclk_p_state_change_support;
 
-	if (dc->work_arounds.skip_clock_update)
-		return;
-
 	if (clk_mgr_base->clks.dispclk_khz == 0 ||
 			(dc->debug.force_clock_mode & 0x1)) {
 		/* This is from resume or boot up, if forced_clock cfg option used,
@@ -489,7 +486,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support;
 
-		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+		if (should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support) &&
+				!dc->work_arounds.clock_update_disable_mask.fclk) {
 			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
 			/* To enable FCLK P-state switching, send FCLK_PSTATE_SUPPORTED message to PMFW */
@@ -503,12 +501,14 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
 					new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
 
-		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
+		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz) &&
+				!dc->work_arounds.clock_update_disable_mask.dcfclk) {
 			clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
 		}
 
-		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
+		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz) &&
+				!dc->work_arounds.clock_update_disable_mask.dcfclk_ds) {
 			clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 			dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
 		}
@@ -527,7 +527,8 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		}
 
 		p_state_change_support = new_clocks->p_state_change_support;
-		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support) &&
+				!dc->work_arounds.clock_update_disable_mask.uclk) {
 			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
 
 			/* to disable P-State switching, set UCLK min = max */
@@ -541,20 +542,23 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			update_fclk = true;
 		}
 
-		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && !clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
+		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && !clk_mgr_base->clks.fclk_p_state_change_support && update_fclk &&
+				!dc->work_arounds.clock_update_disable_mask.fclk) {
 			/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
 			dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
 		}
 
 		/* Always update saved value, even if new value not set due to P-State switching unsupported */
-		if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz)) {
+		if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz) &&
+				!dc->work_arounds.clock_update_disable_mask.uclk) {
 			clk_mgr_base->clks.dramclk_khz = new_clocks->dramclk_khz;
 			update_uclk = true;
 		}
 
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
-				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
+				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support) &&
+				!dc->work_arounds.clock_update_disable_mask.uclk)
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
 		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index f4448b545d70..e89de1078964 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -272,8 +272,13 @@ struct dc_bug_wa {
 	bool dedcn20_305_wa;
 	bool skip_clock_update;
 	bool lt_early_cr_pattern;
+	struct {
+		uint8_t uclk : 1;
+		uint8_t fclk : 1;
+		uint8_t dcfclk : 1;
+		uint8_t dcfclk_ds: 1;
+	} clock_update_disable_mask;
 };
-
 struct dc_dcc_surface_param {
 	struct dc_size surface_size;
 	enum surface_pixel_format format;
-- 
2.40.0


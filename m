Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD14C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD43610E401;
	Wed, 22 Feb 2023 06:42:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8663710E401
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggftkR3Ek3cwPUEGCLcW9IrniVkjNADpu6nsTbJ6f5BICtXQpVbI9EuG6TLTRQcORA8H3C7btQa9cmGx7BSb9x7Du9KHcLImC8SPQ8oq5ot9IXUxOJJWAgRrCHA1lOjtMM06Tso/5ZG/cYln/D7cUVvrDUM/YW/pWS9Wgsc7swIQcVi6hAiQVZiaX70yf3eh7U8Gsg5AJBb2FJdFqbqS5SarIkf/rc5P9eBZljIyqzxoUrgruC3ax+Jn4Bu8GUtbyfGSjciv22YCVdVpZNqRNDMUl/Rx+BVpWr0nbVy/EHFah6X4ondWk2jF73HlY8zSyHFhtEaC21DVTqfHh6+diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKIjdHRm1Z9RCecOpiaqEXqpZoziHFM65UbwFP3DjXU=;
 b=AJs4us3mqOyHZ4ryW6SWqwkq0txS8ZzkproraAu7cTwO1q+aUbkf3TyZezR9GirTCj5i3cchV1i4R2SUJnt9Gm1GDH47GOz2frQdVRTAJSIJFCUcRvNj89v4JtLL6irFPzhcuve6aMArxfbw0TX5E3EWrcqh/hZ3+GLnzS8YOaggFF93MYuCPQHxRSvURqF9ENeiJlzZkU3oF/gYlDTPu3ycxx3t1pnZDWMU9xJaaRm0DCW31H+5IKPIeFkod2O9duTPfVFrHXqls23qljYKWAKii02hQITO3lImBIpQv2TUr1oYE9Ix6/Ox6zqPmJXdCTZ+W6pHfO4vI1/A8wzIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKIjdHRm1Z9RCecOpiaqEXqpZoziHFM65UbwFP3DjXU=;
 b=M85RHLuWpDd/xT2JWViZioNBOmupRwfGs5SQ9AP1sS08avgm6Mo8eSLQuTxA3gafKcRaSuo9cf2RUm6TJn0GSYu4xOGzCVfrZRFRet8blCTXfno8PPeGrWgsOiV4HlT8VaIiTXjNxszi/ElkqtyfST+RjZvunKDCNoOj2NxIRZw=
Received: from DM6PR06CA0061.namprd06.prod.outlook.com (2603:10b6:5:54::38) by
 DM6PR12MB4060.namprd12.prod.outlook.com (2603:10b6:5:216::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Wed, 22 Feb 2023 06:42:25 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::a8) by DM6PR06CA0061.outlook.office365.com
 (2603:10b6:5:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Wed, 22 Feb 2023 06:42:25 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:42:18 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/20] drm/amd/display: DAL to program DISPCLK WDIVIDER if
 PMFW doesn't
Date: Wed, 22 Feb 2023 01:40:32 -0500
Message-ID: <20230222064041.2824-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM6PR12MB4060:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfa6a2a-5197-47ad-9611-08db149ff5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2mUyXjZa+U0J+rkdplUSnS4P74WDxq6kiJojIpdGioCi3oGXjvVUu5+GYvdYSZPGVESx0/XL4V+8f3ABQTlrVmfzzBs56HcyqeXo5SeYfTeK6koW8fJ7kkz7+c05bAccgFytTcxbah927gcE4NrddnPtn+p6ihnRcth3B/AMNgv3m12C3QuwXiIJqQZ38rMyGU+XK2bx0qT5vwlbX+frlL7yWypOBrBNkdDPlQI0gsjIVEQJ/mvcCjmm7Zrj1E+6JHisnJ41YLj/LLa0fxfmP3re7xSjmt1Ydi2pyzVBRHTY8jRTOfaeFBYLgFezbwyjIf5bHgSAywMM/P97hOzloQIF2e+T1j3kfLTXcIn6xH4FDt0xglKEoe6xzqzXrpHOLbgUa2K7ZSnN4RpM87Jf+LynY2495Tkro+YLwn5zwNcqLMVcr8WS5D3KOHnYhddbAPYueybP9up2h+iIXwvUDABCsvbq7b1uEWBiatGAL44BJ/jSDyHCTP6vAH9HgGSf3TTGEWbK9lic/kLVeDkIVup/f5HOtkGTU07bQOzdX7ZoYZS44SzY0MbSnLXe/eceuLs7XheI2tF36UPv9QYjcwO6lRDNGwg45aSVaV6jbmIdbQyZsAMx81+sgdDDtbUBRbQE4Fkf/qBgAL7gLCrjUyMs7OdNMNWpUaJfLl3Q1oxkwDbHoOE/iTb4abvaIlo2DZ5zD4ywr4CfIvKTQyAz8jisAx8bydsprD5MxzNrb4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(40470700004)(46966006)(36840700001)(44832011)(5660300002)(2906002)(36756003)(426003)(83380400001)(47076005)(16526019)(40480700001)(186003)(26005)(336012)(2616005)(356005)(36860700001)(82740400003)(81166007)(4326008)(70206006)(70586007)(8676002)(316002)(40460700003)(6916009)(8936002)(41300700001)(6666004)(1076003)(478600001)(86362001)(54906003)(82310400005)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:25.6949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa6a2a-5197-47ad-9611-08db149ff5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
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
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
- If for any reason PMFW fails to set the expected (or valid)
  DISPCLK WDIVIDER, then DAL will program DENTIST DISPCLK
  WDIVIDER to correct for this issue

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 41 ++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 61768bf726f8..e686d6610fd4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -257,25 +257,24 @@ static void dcn32_update_dppclk_dispclk_freq(struct clk_mgr_internal *clk_mgr, s
 
 static void dcn32_update_clocks_update_dentist(
 		struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context,
-		uint32_t old_dispclk_khz)
+		struct dc_state *context)
 {
 	uint32_t new_disp_divider = 0;
-	uint32_t old_disp_divider = 0;
 	uint32_t new_dispclk_wdivider = 0;
 	uint32_t old_dispclk_wdivider = 0;
 	uint32_t i;
+	uint32_t dentist_dispclk_wdivider_readback = 0;
+	struct dc *dc = clk_mgr->base.ctx->dc;
 
-	if (old_dispclk_khz == 0 || clk_mgr->base.clks.dispclk_khz == 0)
+	if (clk_mgr->base.clks.dispclk_khz == 0)
 		return;
 
 	new_disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
 			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dispclk_khz;
-	old_disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz / old_dispclk_khz;
 
 	new_dispclk_wdivider = dentist_get_did_from_divider(new_disp_divider);
-	old_dispclk_wdivider = dentist_get_did_from_divider(old_disp_divider);
+	REG_GET(DENTIST_DISPCLK_CNTL,
+			DENTIST_DISPCLK_WDIVIDER, &old_dispclk_wdivider);
 
 	/* When changing divider to or from 127, some extra programming is required to prevent corruption */
 	if (old_dispclk_wdivider == 127 && new_dispclk_wdivider != 127) {
@@ -314,6 +313,17 @@ static void dcn32_update_clocks_update_dentist(
 		if (clk_mgr->smu_present)
 			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(temp_dispclk_khz));
 
+		if (dc->debug.override_dispclk_programming) {
+			REG_GET(DENTIST_DISPCLK_CNTL,
+					DENTIST_DISPCLK_WDIVIDER, &dentist_dispclk_wdivider_readback);
+
+			if (dentist_dispclk_wdivider_readback != 126) {
+				REG_UPDATE(DENTIST_DISPCLK_CNTL,
+						DENTIST_DISPCLK_WDIVIDER, 126);
+				REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
+			}
+		}
+
 		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
@@ -341,6 +351,18 @@ static void dcn32_update_clocks_update_dentist(
 	/* do requested DISPCLK updates*/
 	if (clk_mgr->smu_present)
 		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr->base.clks.dispclk_khz));
+
+	if (dc->debug.override_dispclk_programming) {
+		REG_GET(DENTIST_DISPCLK_CNTL,
+				DENTIST_DISPCLK_WDIVIDER, &dentist_dispclk_wdivider_readback);
+
+		if (dentist_dispclk_wdivider_readback > new_dispclk_wdivider) {
+			REG_UPDATE(DENTIST_DISPCLK_CNTL,
+					DENTIST_DISPCLK_WDIVIDER, new_dispclk_wdivider);
+			REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
+		}
+	}
+
 }
 
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
@@ -361,7 +383,6 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool p_state_change_support;
 	bool fclk_p_state_change_support;
 	int total_plane_count;
-	int old_dispclk_khz = clk_mgr_base->clks.dispclk_khz;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -504,13 +525,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (dpp_clock_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
-			dcn32_update_clocks_update_dentist(clk_mgr, context, old_dispclk_khz);
+			dcn32_update_clocks_update_dentist(clk_mgr, context);
 			if (clk_mgr->smu_present)
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
-				dcn32_update_clocks_update_dentist(clk_mgr, context, old_dispclk_khz);
+				dcn32_update_clocks_update_dentist(clk_mgr, context);
 			/* There is a check inside dcn20_update_clocks_update_dpp_dto which ensures
 			 * that we do not lower dto when it is not safe to lower. We do not need to
 			 * compare the current and new dppclk before calling this function.
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1fde43378689..8a62f3e93e35 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -874,6 +874,7 @@ struct dc_debug_options {
 	bool disable_unbounded_requesting;
 	bool dig_fifo_off_in_blank;
 	bool temp_mst_deallocation_sequence;
+	bool override_dispclk_programming;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 74e50c09bb62..16efb86232d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -726,6 +726,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
+	.override_dispclk_programming = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 55f918b44077..deaa4769be10 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -724,6 +724,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.alloc_extra_way_for_cursor = true,
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
+	.override_dispclk_programming = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.34.1


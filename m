Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C5AE7F13B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CAB10E441;
	Tue, 26 Sep 2023 21:53:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362EA10E43D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFPBIBuCAr+ZAquoBh5po4WCd9SN31ReVvMCr1OCYtWsypb1odAQgmVcpjFX1Zwilyliw+WeXzo5ux4PG+Rw4zxjmZVD+NjHsGAc8ypxQcheDsg6bUHL4evrozfQclpyoXzdmwHoVWOVeFEvJw1qKU52opXB03zkauZMoITbQjQNkQTHTFme0WIWKh5Cni3Knx9nr/POJiXN4c02n6aPI95Xl4Ngendit9YZBnNZhkBbaoG1G10t4lSWA1/8C05IwLfKrYVsEo1LM9KQLAiwsu7pAPS8im0blbjCHlmn6BAsqaAbdxOQz7hnaP8DUmA4bTd8G26yNSmy/xfQJ8m1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWKGB+mJYhIP4xRIrmyzacaVDKygYXI0vSUT1HXGsKE=;
 b=b1KMn1Qo79DSDVuddol9xFofsEYid9TyFotos9niVsZeJyYiGvtzdzRsMG8XrbQ78DcXHJOyVoW3nws5naen4UvERDHZfLuUMz6HgTM3oqMk6yJW4UBHvCCjeGpL8qmaJe1Q2gM2awOECTb5fmu+Jn4ayPJjKOLIYjdxGhoDyr+jiyiFIJh+CHyz6pYDWXRmgM03yCWJrlENDOpKrobYYtyPeA5Z0kKjQIiSNgfZiO/6NOOTxazpU4Oq2v3b4oVFsNnX8w6hsXEmY1i/SSzA2QaYoBGjL50egE46tGAFJ/LmVsTWIjbnToHxxyEYVxoYHfx1pfx8+yFgKEEaFn/PSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWKGB+mJYhIP4xRIrmyzacaVDKygYXI0vSUT1HXGsKE=;
 b=B1k1ScRCLiuI/g/9N67P0NTVK0iLNCHMOxKiRrHEgLixX+/WnP+3L2tCycHhc4g6eJ1nDieU1OOWT86NyUFCitoz5wKdTEJL7wyjDD1qtrZ2jwien092TK8LGQWjEVPPVAUB8m1P5W3erX/76cEO8Ke7kCzctpM5qu/+UidBUcE=
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Tue, 26 Sep 2023 21:53:50 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::1b) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:49 -0500
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Make driver backwards-compatible with
 non-IPS PMFW
Date: Tue, 26 Sep 2023 17:46:58 -0400
Message-ID: <20230926215335.200765-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230926215335.200765-1-aurabindo.pillai@amd.com>
References: <20230926215335.200765-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: 06330e49-94fc-48fd-a8e9-08dbbedb117f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iq87Bfm6DsJadNa70OYPJcAmaSlSt7M8BeOKBNs3M+bgHrVFST3FcdWjeJN+hqenPl2wKJRU8fipVpN7Bl68Tm2y6qSQYek04NGDmnIkusfWXCyUbMd3BVkw4r6CRZnuQ9w/3MTdzqq/wrOieb1c2r3IRF8GqgFkbSXb5SgCO2mIG9xJIfqSauL5rQmc+0cPNoSTYPZMCBe5kMj2rePRSMojv1MeFYDEI1HivAgVgNuN02SyJqySDcQAYq4AJ77nUbIHdhILm3nhPJNNhY6hp3Y5qyuBTFr+ixZyYOy5y+Qlly+OiT33GecP7rl8NTCaRDLwHcnhMxFauKFdYQbR/7uUCVPPg5yDfwD3atst0GBZK6iMO7jqflVd+dCYk5HvcqZiDatrjYVDVBrqRRvJsLMr3p8UACvB7hS+nXnM2P/q36KcDR8eFTEfKFYOZSIgx8vcuZv301pg8CVbQIeNEdqseCUaXRx17A3EdxML6JQD5ANVAFATUE1dS7erBau7P8vpgynKgHx7duQCQgSIy1oEQZDtf0/H9qXmN3PJhABR+QyElVpTRWMvQuBTMW5djAV7YWhjOdeb1gETLHrzNlb+umxEXGTl5mSoR/3jHhEIBC1gP/+czTsss3H0ZB8Wg+QJcaw+pnxCDZ1gJBa4XDLrLI3LIXOxEfvofCnQWLTDiBTMhAM71935ejtFv2xVJuuFHBvX35UyVVU+Nm88yIbtx7k/0kXdludmfvJwC7EtdEM5vodGrGBYP8DA4Ky9tf2sd/Lyz8TQ4Gfu4vcNPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(8676002)(8936002)(4326008)(44832011)(5660300002)(40460700003)(36860700001)(7696005)(70586007)(1076003)(70206006)(54906003)(40480700001)(26005)(6916009)(316002)(83380400001)(336012)(82740400003)(6666004)(356005)(41300700001)(81166007)(2616005)(86362001)(426003)(47076005)(2906002)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:50.2970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06330e49-94fc-48fd-a8e9-08dbbedb117f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ovidiu Bunea <ovidiu.bunea@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why]
Driver needs to be compatible with PM FW that doesn't support IPS

[how]
Toggle internal control flag

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 28 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  1 -
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index c9c7baf45be3..b5acd7b01e40 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -744,16 +744,16 @@ static void dcn35_set_idle_state(struct clk_mgr *clk_mgr_base, bool allow_idle)
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	uint32_t val = dcn35_smu_read_ips_scratch(clk_mgr);
 
-	if (dc->debug.disable_ips == 0) {
+	if (dc->config.disable_ips == 0) {
 		val |= DMUB_IPS1_ALLOW_MASK;
 		val |= DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->debug.disable_ips == DMUB_IPS_DISABLE_IPS1) {
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS1) {
 		val = val & ~DMUB_IPS1_ALLOW_MASK;
 		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->debug.disable_ips == DMUB_IPS_DISABLE_IPS2) {
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2) {
 		val |= DMUB_IPS1_ALLOW_MASK;
 		val = val & ~DMUB_IPS2_ALLOW_MASK;
-	} else if (dc->debug.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
+	} else if (dc->config.disable_ips == DMUB_IPS_DISABLE_IPS2_Z10) {
 		val |= DMUB_IPS1_ALLOW_MASK;
 		val |= DMUB_IPS2_ALLOW_MASK;
 	}
@@ -1036,12 +1036,20 @@ void dcn35_clk_mgr_construct(
 		dm_helpers_free_gpu_mem(clk_mgr->base.base.ctx, DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
 				smu_dpm_clks.dpm_clks);
 
-	if (dcn35_smu_get_ips_supported(&clk_mgr->base)) {
-		ctx->dc->debug.ignore_pg = false;
-		ctx->dc->debug.dmcub_emulation = false;
-		ctx->dc->debug.disable_dpp_power_gate = false;
-		ctx->dc->debug.disable_hubp_power_gate = false;
-		ctx->dc->debug.disable_dsc_power_gate = false;
+	if (ctx->dc->config.disable_ips == 0) {
+		bool ips_support = false;
+
+		/*avoid call pmfw at init*/
+		ips_support = dcn35_smu_get_ips_supported(&clk_mgr->base);
+		if (ips_support) {
+			ctx->dc->debug.ignore_pg = false;
+			ctx->dc->debug.disable_dpp_power_gate = false;
+			ctx->dc->debug.disable_hubp_power_gate = false;
+			ctx->dc->debug.disable_dsc_power_gate = false;
+		} else {
+			/*let's reset the config control flag*/
+			ctx->dc->config.disable_ips = 1; /*pmfw not support it, disable it all*/
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b140eb240ad7..a907cd620e10 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -423,6 +423,7 @@ struct dc_config {
 	bool dc_mode_clk_limit_support;
 	bool EnableMinDispClkODM;
 	bool enable_auto_dpm_test_logs;
+	unsigned int disable_ips;
 };
 
 enum visual_confirm {
@@ -913,7 +914,6 @@ struct dc_debug_options {
 	enum det_size crb_alloc_policy;
 	int crb_alloc_policy_min_disp_count;
 	bool disable_z10;
-	unsigned int disable_ips;
 	bool enable_z9_disable_interface;
 	bool psr_skip_crtc_disable;
 	union dpia_debug_options dpia_debug;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 6214866916c7..693c7ba4b34d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -747,7 +747,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
-	.disable_ips = true,
 	.ips2_eval_delay_us = 200,
 	.ips2_entry_delay_us = 400
 };
-- 
2.42.0


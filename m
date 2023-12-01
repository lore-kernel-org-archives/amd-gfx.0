Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963BC07E97
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5DE10E898;
	Fri,  1 Dec 2023 13:28:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB04C10E8A0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJjvth3NxqurRrUcm/BgahoAMoD9aW+in1nPJxaFRplWEJhyKSldMlvnHcESOOhPqHSfN+1M/TAloZPy+wrWS9Ugpx/ST3mVYdZdm1vKdOl4vnnQuHLlibjW84m5iv98f/EC5P7cgSid4DYNSHFblDPW0o61TJ4t7qyiYyOeokn14bmRr1GfluM0534S+KbBf0EgjXtKoZ76OqBXQtnG/YzxJ2G/w0pFfGZBuuzaHWxlRS4G5y8Iaj0y7iVY+eysoC1IjFRuN6YQOXbrBoCIbfcZjs+9Xow1cyaMLL8G1qLuLW0iuUG3XEAsmxGfIA/ufgDmaGgC1ozZP2sSNztIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr2hmw5eQs5jHnIfaq2Jp7+1zGf19qX1iyx9dYF2ZoA=;
 b=OtTV/VMr/PZZggH0lwOPFpId4rHkxgOkfeidivlQC6qZQwwHzrFkWFvsx52TCfGE++mP5w/mqyAQtdLUagLpyKWlA3yiHqN2yy1q9/eN8xLZt5NrHhDQi+Y/YsLis77YB1A+MYo1HTT2iH2IIRn4Ttr9Euze3mMnIExuOAK0RnRJeBY0STrFPngEVQ3iFedivPyvx4ofs+b5BKT6AVhSm/e2MfoB7dmwFm8FX8HRLzfBNbp96ImqFxKZZKmR/f2sm2dlG5OuQzJqeGi830UfJwoCj18jypFV4IxMwwNVtjpnUzW0+kUXtSTPMCa9lkPAZ7sOOzPYN7/i4aRAoC9IoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr2hmw5eQs5jHnIfaq2Jp7+1zGf19qX1iyx9dYF2ZoA=;
 b=cxxylzDF/GTY0QyZEJ+srQRLsU25Gn2qy5Fulm/Zj0xWGglM4XVEg8We746fPWh7+eV2e9V63Bp6gl5blnLi7wE9BX3DMxmdKHrDe4ej8bdidrlJ7q4oZd+oY9yFsO0aiICPe6a3tN97/C77ig/T4636VMGUgD8mWzyJxbXNxVw=
Received: from DS0PR17CA0001.namprd17.prod.outlook.com (2603:10b6:8:191::19)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:31 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::ba) by DS0PR17CA0001.outlook.office365.com
 (2603:10b6:8:191::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:31 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:28 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/47] drm/amd/display: Added delay to DPM log
Date: Fri, 1 Dec 2023 06:25:13 -0700
Message-ID: <20231201132731.2354141-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b5e66f-0eda-4f50-e083-08dbf271692c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgeHPjFzBBFJ2Ys3Zad2nrSXPOpeZpK/+BN/ZstU8/z3fHaJ98LTAybMrEUg/Bi95uLbKTfl+T07iUYVWSffd5hocLrFgIKe6kdpFzBR/X3O8O9XNS/ZYv7KXbablBH57XgLs0Yu1HLU8GBv/islErtDCRle6EYGAMJQI/oCWARzb9v+8ywou/Itgy+1V8UzMs/B7k0ss8mkTbcoM3pEiqd+VlEDmV3Kz8IAG+ctkDgtR/093A/0PFJAP/lm7lsGm7HgV+lX58QWxUYam0BczKU3NceCWvxqndNzZxz6GK2BnO8EezoGeKQVqcTBD/P9Q+0k2/CethK59npFhF0n9TX0OZnmqW08YPqr/KA7MvdVnHkgqq1y7rsW6aC5pNk6WvnGzrcFJgeOwCbTaydOd7pyovg6owY99nQYDgMSI3wyRfMr4CrhIdEpTOAeucO1oTzkjxRNd2MPlxnWHAT3VDmfzAj/oxYg9zNnI3BkIYDAXzqxEjSxwFX/NBk38e2c3JPUjsVqe6SfekbEzDfQcVPq1fd0i3ZD0C9rtNrqXHxdl/4SAaGsuEHmewsWIf3GRdCuohnQknqHyr0pWYVfEP6MnMBEyzhGoC7lglhaemf/x+k1WV+/4Dh3fKYdk12W5g4bFhF+xABV9AeqCAVSeZFXCRyTK4XoXeb3DRbztISpqCmh9TMkkAu0c0MGk9SAaidXv0LwQoLb8o5fafcFy2JV+Vn6YWXA0yKuPRsqsl4+G0pMItMgTzThY26Yt7JEILZbNej5m7D7f/ZzOlbVjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(1076003)(5660300002)(2906002)(8676002)(4326008)(6916009)(54906003)(316002)(8936002)(70586007)(70206006)(40480700001)(16526019)(26005)(41300700001)(6666004)(478600001)(2616005)(83380400001)(426003)(336012)(40460700003)(47076005)(36860700001)(82740400003)(356005)(81166007)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:31.2050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b5e66f-0eda-4f50-e083-08dbf271692c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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
Cc: stylon.wang@amd.com, Relja Vojvodic <relja.vojvodic@amd.com>,
 jerry.zuo@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <martin.leung@amd.com>, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Relja Vojvodic <relja.vojvodic@amd.com>

HW registers were being read to quickly, causing incorrect values to be
logged after a clock frequency was changed

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index a496930b1f9c..95c0b49b531a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -460,18 +460,24 @@ static int dcn32_get_dispclk_from_dentist(struct clk_mgr *clk_mgr_base)
 
 static void dcn32_auto_dpm_test_log(struct dc_clocks *new_clocks, struct clk_mgr_internal *clk_mgr)
 {
-    unsigned int dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
-    unsigned int dppclk_khz_reg     = REG_READ(CLK1_CLK1_CURRENT_CNT); // DPPCLK
-    unsigned int dprefclk_khz_reg   = REG_READ(CLK1_CLK2_CURRENT_CNT); // DPREFCLK
-    unsigned int dcfclk_khz_reg     = REG_READ(CLK1_CLK3_CURRENT_CNT); // DCFCLK
-    unsigned int dtbclk_khz_reg     = REG_READ(CLK1_CLK4_CURRENT_CNT); // DTBCLK
-    unsigned int fclk_khz_reg       = REG_READ(CLK4_CLK0_CURRENT_CNT); // FCLK
+	unsigned int dispclk_khz_reg, dppclk_khz_reg, dprefclk_khz_reg, dcfclk_khz_reg, dtbclk_khz_reg,
+				 fclk_khz_reg;
+	int dramclk_khz_override, fclk_khz_override, num_fclk_levels;
+
+	msleep(5);
+
+    dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
+    dppclk_khz_reg     = REG_READ(CLK1_CLK1_CURRENT_CNT); // DPPCLK
+    dprefclk_khz_reg   = REG_READ(CLK1_CLK2_CURRENT_CNT); // DPREFCLK
+    dcfclk_khz_reg     = REG_READ(CLK1_CLK3_CURRENT_CNT); // DCFCLK
+    dtbclk_khz_reg     = REG_READ(CLK1_CLK4_CURRENT_CNT); // DTBCLK
+    fclk_khz_reg       = REG_READ(CLK4_CLK0_CURRENT_CNT); // FCLK
 
     // Overrides for these clocks in case there is no p_state change support
-    int dramclk_khz_override = new_clocks->dramclk_khz;
-    int fclk_khz_override = new_clocks->fclk_khz;
+    dramclk_khz_override = new_clocks->dramclk_khz;
+    fclk_khz_override = new_clocks->fclk_khz;
 
-    int num_fclk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1;
+    num_fclk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1;
 
     if (!new_clocks->p_state_change_support) {
 	    dramclk_khz_override = clk_mgr->base.bw_params->max_memclk_mhz * 1000;
@@ -707,7 +713,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		dmcu->funcs->set_psr_wait_loop(dmcu,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 
-	if (dc->config.enable_auto_dpm_test_logs) {
+	if (dc->config.enable_auto_dpm_test_logs && safe_to_lower) {
 	    dcn32_auto_dpm_test_log(new_clocks, clk_mgr);
 	}
 }
-- 
2.42.0


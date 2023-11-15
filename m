Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D405C072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D5B10E581;
	Wed, 15 Nov 2023 19:44:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E77410E579
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB0FP0bDceZwoVc51XGp+Sa/w34SWsPuc8yOe2bGNVwti2GcVOBSDVG195QRPb43sPkiuWQKiTFJFdyyl1Yq0crIBCDlmS6mMpa9m/4S0rWKUJvUyY8Ak/tJ8FPpr1NNyDxymFgBKC7e8piIqeAX/u8i7VpZYEFSB2+I4F0WpCTuAndi5y6TcS7LH2JpML9JLWoLUYIHnusDkCggw/BQ02Z011t/jU2M/XXM7So+PaSd/KsHrOpGSW55tlqNnBjJFH8/oAQlA/nQwa11X2QQ+VedH/dLPTcPq0YJUbRpg5U/efGVheYN03Cotw4iugHzXJ8i3TUI+HwBdJM+z7K+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApHsi3tMfRcoOH+waII8fneK0JyDd1wWGlT9fiHLQSg=;
 b=RaOJOCvFA6lUUDtJgWGbUnvralmEZGu75oagYbRgyu3P7Jxy8rquikv1almKSmyCAgC1qiST8ngwfPSYCeq1MM7f+Ltyq42RerN67LXiqDQXEd7ivREdZ/KZYlPvpWPntfAfn8UtPcDMY/xSzVX7Ma/JyOtdL30Wt/7Pnx5BslcN6lnCDlijPtJgUOUGsgjrrsHcoJwsPhq2FZ4tTZ6y/EtYAjLveD1jABObkaaCtH5/wc3tPQAjDValkom69ZrtLdcs6KBqKVqSSRPi1W+fjmysrgukKEetaC5+6tmLRfu90C5mV0MCmx4etWD/Z9QjCmjYHE0X+VgER0GnGM+hEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApHsi3tMfRcoOH+waII8fneK0JyDd1wWGlT9fiHLQSg=;
 b=vo65NvO2m3WujjEobHCyw0mGmQZ8ad7L0n/YeDrQ5V2L5yPjuy2fojUFNpUZJ4pGhgm9ZKD3wshBg5JtS8RwXi+GwOir/a+a5hoseQePGXmx4vZyoNPdS/14pPgGTqy1km9YHkK0oJqXib6ax5RZs8/nmzzG4DocFoXKH1IuFOQ=
Received: from BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25)
 by PH0PR12MB8100.namprd12.prod.outlook.com (2603:10b6:510:29b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:28 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2b) by BL1PR13CA0110.outlook.office365.com
 (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Wed, 15 Nov 2023 19:44:28 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:24 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/35] drm/amd/display: Do not read DPREFCLK spread info from
 LUT on DCN35
Date: Wed, 15 Nov 2023 14:40:28 -0500
Message-ID: <20231115194332.39469-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|PH0PR12MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de10f58-b573-4beb-cfd6-08dbe6134791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEdIbtPVHWrFQ3HThzjoYSUbxW0/JZLnpthjqdbt6y/0ZUM0gLo7fiyvKAbgtm3LrS+7d/mbS/gAyo4Fybm1S8lguQeslWAw/fr454vDjk4K2A2734hB9jxSSvWRQ5t5gHqlhvUJirMx1HvyeWFvUl76InbP2HMwjl4DNvfFoDHl2BB2OkpOn59BvNXmTicTHSXPBprQtoT7vtv55M56h2mwloGCvFoZDbfuroAU+6bVqB0Cn79Y0zcnItcNCpsMQevQAED4kY/N39fZ6Y6zV/tHAuDbAg8PEENMsOJ4sJJlt+CEf5J3pj7tqhnQ6qBsksa/TDkn4q5O5SaEyt0zBZIVi4FhTq9f8UC0WuyJol4KdBdjpHBdMf7b08V4MB2TDiPazGXceBTIqqE2+m0vOPPdtS46nfWIM2v5OYxNBFZVuBXa0jOHLfuZXW/SRphV5xJt7cPnTFOoSREGuQ9Yid0zo/pBGD0v7G7PWOcFkcCjnYSStS3VY1b+6klUbL+Y045Ei3iQfMMQ8Sns2EkcrPf91Lk4PzwFHV+QRAEYBcvWzZIJy96nNsaYN4HJ1XbFflXVv8YR4nlm4kgxBEST9Q58UpPv3dd7T+TqYeuWOH7Rm34uAmWI30Kzz20vjrqctOfgPRMrpWEtnlwOJGh4sSmZfOgUyQrZXGQE6NMqdDd/9PYp+DdB+Mn9Rl/oDggEf/iW7TGHeLNRlF+zn70+qFJQ7k1/fECZO1LCzDNJqHSYuJtPmo5grOiicD7L3V02JGOo9+a1N2ou1xkfaiPeZYLcvghaR17llvY8VrR+eQA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(356005)(47076005)(81166007)(83380400001)(36860700001)(16526019)(26005)(1076003)(40460700003)(82740400003)(8676002)(2906002)(5660300002)(4326008)(41300700001)(8936002)(86362001)(36756003)(70586007)(44832011)(6916009)(70206006)(54906003)(316002)(2616005)(336012)(426003)(478600001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:28.2093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de10f58-b573-4beb-cfd6-08dbe6134791
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8100
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Currently DCN35 does not spread DPREFCLK

[HOW]
Remove hardcoded table with nonzero caps

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 3469f692d6ea..0f3f6a9d5144 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -515,11 +515,6 @@ static DpmClocks_t_dcn35 dummy_clocks;
 
 static struct dcn35_watermarks dummy_wms = { 0 };
 
-static struct dcn35_ss_info_table ss_info_table = {
-	.ss_divider = 1000,
-	.ss_percentage = {0, 0, 375, 375, 375}
-};
-
 static void dcn35_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn35_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -965,21 +960,6 @@ struct clk_mgr_funcs dcn35_fpga_funcs = {
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 };
 
-static void dcn35_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
-{
-	uint32_t clock_source;
-	struct dc_context *ctx = clk_mgr->base.ctx;
-
-	REG_GET(CLK1_CLK2_BYPASS_CNTL, CLK2_BYPASS_SEL, &clock_source);
-
-	clk_mgr->dprefclk_ss_percentage = ss_info_table.ss_percentage[clock_source];
-
-	if (clk_mgr->dprefclk_ss_percentage != 0) {
-		clk_mgr->ss_on_dprefclk = true;
-		clk_mgr->dprefclk_ss_divider = ss_info_table.ss_divider;
-	}
-}
-
 void dcn35_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn35 *clk_mgr,
@@ -1052,8 +1032,6 @@ void dcn35_clk_mgr_construct(
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
-	dcn35_read_ss_info_from_lut(&clk_mgr->base);
-
 	clk_mgr->base.base.bw_params = &dcn35_bw_params;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
-- 
2.42.0


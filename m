Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A3C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB4110E4B4;
	Wed,  2 Aug 2023 06:52:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7177910E4B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKf7p7scocnW3MAI148480Dl8kV/HixESc2E85l+xA89KIMZwwfQIO5H6+6wgSpYbPCGDFEdK+qyQu4Iggz9P5mpvQZ/zdTnrFAy4dWGV23WlPQhRIWUkgKZma7Vtryxdn1WG7HGJiKRwoBFRneEaSzCrY8DG1XB1c38L3R7yp1M92hog5rbSy3MVYPfVSQO8JzT6X+6xn0WfBHTEP43XdMhn5t7Q6oxrISPIxagoh8VvRxsY8zdFZpgVxIktAUgJ6Ywtb/ZUM6iX1drIMApQ72wS+ZME1xruNRBaaut4TsFdayFQj4ltLJZayrDflqVIJvVEfoJR7W7fQNOaG93iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRpOmdkUyUPlWqDAjeK00Wy9z6rYf3aWoi40bz2JU3g=;
 b=axh68f2B1BtW9evrReS8feZONucF/0s4zJo9ixRZlGdFx0Kbgol8wh8tehEmZs25BRXnqvLrZXARCGRI1FTKIxHL9Pjrj6BajPsOQrbvikgndsEB0e6/VEWdrKcHXJ6Agrqv4o8f8zYxT1WjuM6F+kuJS3C7cUKOoSZoa0XBjjP20ntLvlvaWrZcDWiiuHYl8k9aoUsBKdLs+McjbQ4RUzp8RMTm5OZzo1CTBIfYNBigsWYI0Lx7fC8ALT4s/vAzZgiM/38WquAgWJarqzbpfe/ELdkaksLyQ5O+25548mQmuPTbe4DnqOlLkfikP2WM1ly2iNjbSrS1iDu8ZZou5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRpOmdkUyUPlWqDAjeK00Wy9z6rYf3aWoi40bz2JU3g=;
 b=wH6JEVfiHkhK4LY0oNe5d0bdbeV7czHbudvKr49+QeTHNWHUYLAGEFs43VpKacnnwm4MZV5kq+1NK4/o8GxruMeoXXwcxyXEu8i4X70JQD3NgteCF/O5fulOLUu/KSFaCf/tyfnEpTtIVndXDxnmsbVuL1A0XbhyV/3i3VdrWDg=
Received: from BY5PR17CA0004.namprd17.prod.outlook.com (2603:10b6:a03:1b8::17)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:55 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::f7) by BY5PR17CA0004.outlook.office365.com
 (2603:10b6:a03:1b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:53 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:50 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: Revert "dc: read down-spread
 percentage from lut to adjust dprefclk"
Date: Wed, 2 Aug 2023 14:51:23 +0800
Message-ID: <20230802065132.3129932-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f69746-1872-4ef5-1791-08db9325192b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xaj4cWwUtxK9wiqtiaRvkLp+fUO51/VKH8Y151MN6bh/a0KiWAtGqeqa6KxHcP9VIL5jBmnG1nEibkIYYAfWnjEImgcl/ksg876r9Hws0f0VHuOY+jtmrNSSiP2TL+nRnZvwgJuvQe/bBYNP5eN/SqbKMBvU0/449c6OrYCgzc8OErC5Jm2+i0B6+pw9dZc1uNnhNcqKaJyNgtqDfyrsBQCAltFUuoRwNfGFCrcS1Ho6a7ImGYRTPIquVNQjD2FiL26vhLSN8YBOnYR7GKbprZmewWts2jZbycaHtJrTLLFcoEYw4983zWipAU1INEdYlxwrfdfGrZAkZA8GUaxzNcdyvCx2plJR09Ud6moKaMoaKMNfwo4zhi1z4F5U5JvDPdyXrMF8nuNePIAVkJqFScPJmxly7lozFOigVfy9vIAQFiaE1pLCvlTqkAoY3XG74pemFDEw/hFir8GaiXzgvCvUhmXrh7A05OKD1nVocU9c0DwBXLFLDQmegKr75n/SGiQbjuH73a6C2iXFC4wkuW2nZP7rcrVqiWBYvDR+F4mF2CdPZKccwLJVDWU+0y+uu+PckpiX/riX+4J7izKnkneERj3bbrG8f2cL7SG7fVyu7Oe4LxjzPUbbWoi12jDyU9gDtXoq0CPrB9V3uEq7/mHQJwfTH5g621aDEdnu2wEQcdGhl4Z57lfNH6mox+JHVmRXGbk8jZGCe1iR2Y1JsIBvhbZUtFu70ASlYuBxrcTlLO5jEoSvKBs0FDgHBmJT0OyVCQ+ShxxjtSwiKVTYJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(336012)(186003)(40460700003)(2616005)(36756003)(316002)(86362001)(478600001)(81166007)(54906003)(19627235002)(70586007)(70206006)(6666004)(7696005)(4326008)(6916009)(82740400003)(356005)(26005)(1076003)(41300700001)(8936002)(8676002)(426003)(47076005)(83380400001)(36860700001)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:54.6822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f69746-1872-4ef5-1791-08db9325192b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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
Cc: stylon.wang@amd.com, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
Revert commit feb90174e9c6 ("drm/amd/display: Read down-spread percentage from lut to adjust dprefclk.")
This change was causing 240hz display to not light up after s0i3.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 32 +------------------
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |  7 ----
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 3ba2e13d691d..7326b7565846 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -87,14 +87,6 @@ static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0,
 #define CLK1_CLK_PLL_REQ__PllSpineDiv_MASK	0x0000F000L
 #define CLK1_CLK_PLL_REQ__FbMult_frac_MASK	0xFFFF0000L
 
-#define regCLK1_CLK2_BYPASS_CNTL			0x029c
-#define regCLK1_CLK2_BYPASS_CNTL_BASE_IDX	0
-
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL__SHIFT	0x0
-#define CLK1_CLK2_BYPASS_CNTL__LK2_BYPASS_DIV__SHIFT	0x10
-#define CLK1_CLK2_BYPASS_CNTL__CLK2_BYPASS_SEL_MASK		0x00000007L
-#define CLK1_CLK2_BYPASS_CNTL__LK2_BYPASS_DIV_MASK		0x000F0000L
-
 #define REG(reg_name) \
 	(CLK_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
 
@@ -444,11 +436,6 @@ static DpmClocks314_t dummy_clocks;
 
 static struct dcn314_watermarks dummy_wms = { 0 };
 
-static struct dcn314_ss_info_table ss_info_table = {
-	.ss_divider = 1000,
-	.ss_percentage = {0, 0, 375, 375, 375}
-};
-
 static void dcn314_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn314_watermarks *table)
 {
 	int i, num_valid_sets;
@@ -728,20 +715,6 @@ static struct clk_mgr_funcs dcn314_funcs = {
 };
 extern struct clk_mgr_funcs dcn3_fpga_funcs;
 
-static void dcn314_read_ss_info_from_lut(struct clk_mgr_internal *clk_mgr)
-{
-	uint32_t clock_source;
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
 void dcn314_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn314 *clk_mgr,
@@ -808,11 +781,8 @@ void dcn314_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
-
-	dcn314_read_ss_info_from_lut(&clk_mgr->base);
+	dce_clock_read_ss_info(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
-	clk_mgr->base.base.dprefclk_khz =
-		dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn314_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
index e0670dafe260..171f84340eb2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h
@@ -28,8 +28,6 @@
 #define __DCN314_CLK_MGR_H__
 #include "clk_mgr_internal.h"
 
-#define NUM_CLOCK_SOURCES   5
-
 struct dcn314_watermarks;
 
 struct dcn314_smu_watermark_set {
@@ -42,11 +40,6 @@ struct clk_mgr_dcn314 {
 	struct dcn314_smu_watermark_set smu_wm_set;
 };
 
-struct dcn314_ss_info_table {
-	uint32_t ss_divider;
-	uint32_t ss_percentage[NUM_CLOCK_SOURCES];
-};
-
 bool dcn314_are_clock_states_equal(struct dc_clocks *a,
 		struct dc_clocks *b);
 
-- 
2.25.1


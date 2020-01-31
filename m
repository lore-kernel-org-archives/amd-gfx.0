Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33796C33CB7
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0240C2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DBRNKGez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0240C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC736FC41;
	Fri, 31 Jan 2020 22:17:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D036FC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Se2RKGTntZdlp+F6PtO6FkoU5Ck9hLjyy7WveHFKnREQs+9CVWYNK8g/fLgp3AuPxcyaxSYxVFSanCg+9mgo0s7GvvQa+jaMNjznduXZs+RuqVKpTi8fjAUKD9zmGW2wT93kJYPHG7R/IJBuXc7oVwzdZRWvH0c9iDSRJCrPhq8MpZHuXpUSMV6Bp0bLVseMsY2mgSGHq16vuDE4/dVWbnRtEpzwhyM7iNwAtl2bCOhuDouGrsRe17VeS6tRzFXH9s0wbdgbEbrzVZUkgSX6ZWS2fNjiSfIiHTNoX33Z8MEafdwr7O5XypEuC5/Zj+1HdysF1i6jHj+Utkaq9ZOLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fYq8rpodVRIDaF/frdSM90OMhdXuYcrKq2SO8zyN0k=;
 b=bOF/pla5p7MxugfQvOUlMYUzssbMGxpkNTxzp0aBzW6q7FV1q7ticoJgt1k5bqSz6fFKSRcgEqHOsExg0TahS9qtt/2fxJ8BNwTBQ9cEBvxkLJQN0JCykG1NgaWTJ03Cs6cW6cYUUFomVm1SXMAhAWLBQufmsDWAPikDndBBunF2i69TQcC7zNLzptbS/T2s/p2bur0Uwkpcdox806uyIhbRsQeb4v7mpGENU6UIafXxz51K7SI6HwdgO9JGoHi3w2u3rHwF1A+QlkHFJORMZVmCkgpcZV5HocPMpp4/JK/h9LEjbAj/PbaFAXD8Wo1VDUaZiymOhlhm+zRBkBjXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fYq8rpodVRIDaF/frdSM90OMhdXuYcrKq2SO8zyN0k=;
 b=DBRNKGezYAlHgu110AAqnDFIXqXcGgkFhbA2QuMuynFJfH5azoCNWvayCoUZBpzb1GmDqSxDRcEXJtsqOHb+IBu5wrZeBULPqmVhYa0LMbN+WGgH+qWVaM5vYdhGbRMiFeaB7Gly2k2JUto+39qmLcaJ4R703VJbIIqi9G9aojE=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by BY5PR12MB3825.namprd12.prod.outlook.com (2603:10b6:a03:1a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.26; Fri, 31 Jan
 2020 22:17:12 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:10 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:10 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:10 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/33] drm/amd/display: fix inputting clk lvl into dml for RN
Date: Fri, 31 Jan 2020 17:16:32 -0500
Message-ID: <20200131221643.10035-23-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(428003)(189003)(199004)(426003)(70586007)(336012)(5660300002)(7696005)(70206006)(81156014)(8676002)(1076003)(81166006)(2906002)(186003)(4326008)(6916009)(26005)(86362001)(8936002)(36756003)(478600001)(316002)(6666004)(356004)(54906003)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3825; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d9cd7da-e17d-4b63-712a-08d7a69b51b0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3825:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3825491C592D6D286BCF7F25F9070@BY5PR12MB3825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzWS+kQE6PsqBSGrMQUleZET/OZ4ccfYf9CD938DJEY8sXRCWnXIymBzdwmB8QalxYzjhwonJutBVY+h+HX9UbUapxmY25C80q1yyPUTUOx3kqsBJd3rqX0Btc6V/z2Ky9szPuh02vdcNw1BRa/uqt9ju21Uqhhyty6dDs1muwqtNB8BUp6U5qUIVuThObNJycq4/LdHW5SFBv6W8ys5zTurmir4vgCcjjOMcNw5yMvqekFq9WdL/f6KA7XYuh/ePiT7Z3Mo1QWKQRHHyJoI5bPPYXm8anFuMDO9wwMkcB63ADJIs23mnukeNXinvCblQRS0QpznydkAW+czPRh8oTMZbPX+YJvVenwkypEbR3dKojUvJDm71iSA1euz5ySoxev/a+PTWxi4jpuH95/cvp/lLNh2vbknmcjan8hegzUs7yFSM8RYD65M+E1ZaOXW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:11.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9cd7da-e17d-4b63-712a-08d7a69b51b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3825
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, Sung Lee <sung.lee@amd.com>,
 harry.wentland@amd.com, Eric Yang <Eric.Yang2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Previous logic is only good for 15W parts. Other configuration
need a smarter logic to match clk levels with pp table in the fuse.

[How]
Cache all 8 DPM level's clock data, find lvl that match each pstate
in the pp table and build input into DML base on that

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 165 +++++++++++++-----
 .../amd/display/dc/dml/display_mode_structs.h |   3 +-
 2 files changed, 127 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 0d506d30d6b6..5f6fb16f16e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -162,10 +162,10 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.clock_limits = {
 			{
 				.state = 0,
-				.dcfclk_mhz = 304.0,
-				.fabricclk_mhz = 600.0,
-				.dispclk_mhz = 618.0,
-				.dppclk_mhz = 440.0,
+				.dcfclk_mhz = 400.0,
+				.fabricclk_mhz = 400.0,
+				.dispclk_mhz = 600.0,
+				.dppclk_mhz = 400.00,
 				.phyclk_mhz = 600.0,
 				.socclk_mhz = 278.0,
 				.dscclk_mhz = 205.67,
@@ -173,10 +173,10 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 			},
 			{
 				.state = 1,
-				.dcfclk_mhz = 304.0,
-				.fabricclk_mhz = 600.0,
-				.dispclk_mhz = 618.0,
-				.dppclk_mhz = 618.0,
+				.dcfclk_mhz = 464.52,
+				.fabricclk_mhz = 800.0,
+				.dispclk_mhz = 654.55,
+				.dppclk_mhz = 626.09,
 				.phyclk_mhz = 600.0,
 				.socclk_mhz = 278.0,
 				.dscclk_mhz = 205.67,
@@ -184,32 +184,65 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 			},
 			{
 				.state = 2,
-				.dcfclk_mhz = 608.0,
-				.fabricclk_mhz = 1066.0,
-				.dispclk_mhz = 888.0,
-				.dppclk_mhz = 888.0,
-				.phyclk_mhz = 810.0,
+				.dcfclk_mhz = 514.29,
+				.fabricclk_mhz = 933.0,
+				.dispclk_mhz = 757.89,
+				.dppclk_mhz = 685.71,
+				.phyclk_mhz = 600.0,
 				.socclk_mhz = 278.0,
 				.dscclk_mhz = 287.67,
-				.dram_speed_mts = 2133.0,
+				.dram_speed_mts = 1866.0,
 			},
 			{
 				.state = 3,
-				.dcfclk_mhz = 676.0,
-				.fabricclk_mhz = 1600.0,
-				.dispclk_mhz = 1015.0,
-				.dppclk_mhz = 1015.0,
-				.phyclk_mhz = 810.0,
+				.dcfclk_mhz = 576.00,
+				.fabricclk_mhz = 1067.0,
+				.dispclk_mhz = 847.06,
+				.dppclk_mhz = 757.89,
+				.phyclk_mhz = 600.0,
 				.socclk_mhz = 715.0,
 				.dscclk_mhz = 318.334,
-				.dram_speed_mts = 4266.0,
+				.dram_speed_mts = 2134.0,
 			},
 			{
 				.state = 4,
-				.dcfclk_mhz = 810.0,
+				.dcfclk_mhz = 626.09,
+				.fabricclk_mhz = 1200.0,
+				.dispclk_mhz = 900.00,
+				.dppclk_mhz = 847.06,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 953.0,
+				.dscclk_mhz = 489.0,
+				.dram_speed_mts = 2400.0,
+			},
+			{
+				.state = 5,
+				.dcfclk_mhz = 685.71,
+				.fabricclk_mhz = 1333.0,
+				.dispclk_mhz = 1028.57,
+				.dppclk_mhz = 960.00,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 278.0,
+				.dscclk_mhz = 287.67,
+				.dram_speed_mts = 2666.0,
+			},
+			{
+				.state = 6,
+				.dcfclk_mhz = 757.89,
+				.fabricclk_mhz = 1467.0,
+				.dispclk_mhz = 1107.69,
+				.dppclk_mhz = 1028.57,
+				.phyclk_mhz = 810.0,
+				.socclk_mhz = 715.0,
+				.dscclk_mhz = 318.334,
+				.dram_speed_mts = 3200.0,
+			},
+			{
+				.state = 7,
+				.dcfclk_mhz = 847.06,
 				.fabricclk_mhz = 1600.0,
 				.dispclk_mhz = 1395.0,
-				.dppclk_mhz = 1285.0,
+				.dppclk_mhz = 1285.00,
 				.phyclk_mhz = 1325.0,
 				.socclk_mhz = 953.0,
 				.dscclk_mhz = 489.0,
@@ -217,8 +250,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 			},
 			/*Extra state, no dispclk ramping*/
 			{
-				.state = 5,
-				.dcfclk_mhz = 810.0,
+				.state = 8,
+				.dcfclk_mhz = 847.06,
 				.fabricclk_mhz = 1600.0,
 				.dispclk_mhz = 1395.0,
 				.dppclk_mhz = 1285.0,
@@ -265,7 +298,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.xfc_bus_transport_time_us = 4,
 	.xfc_xbuf_latency_tolerance_us = 4,
 	.use_urgent_burst_bw = 1,
-	.num_states = 5
+	.num_states = 9
 };
 
 #ifndef MAX
@@ -1333,26 +1366,78 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 {
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	int i;
+	unsigned int i, j, k;
+	int closest_clk_lvl;
+
+	// diags does not retrieve proper values from SMU
+	// cap states to 5 and make state 5 the max state
+	if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) || IS_DIAG_DC(dc->ctx->dce_environment)) {
+		dcn2_1_soc.num_states = 5;
+
+		dcn2_1_soc.clock_limits[5].state = 5;
+		dcn2_1_soc.clock_limits[5].dcfclk_mhz = 810.0;
+		dcn2_1_soc.clock_limits[5].fabricclk_mhz = 1600.0;
+		dcn2_1_soc.clock_limits[5].dispclk_mhz = 1395.0;
+		dcn2_1_soc.clock_limits[5].dppclk_mhz = 1285.0;
+		dcn2_1_soc.clock_limits[5].phyclk_mhz = 1325.0;
+		dcn2_1_soc.clock_limits[5].socclk_mhz = 953.0;
+		dcn2_1_soc.clock_limits[5].dscclk_mhz = 489.0;
+		dcn2_1_soc.clock_limits[5].dram_speed_mts = 4266.0;
+	} else {
+		dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
+		dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
+		dcn2_1_soc.num_chans = bw_params->num_channels;
+
+		/* Vmin: leave lowest DCN clocks, override with dcfclk, fclk, memclk from fuse */
+		dcn2_1_soc.clock_limits[0].state = 0;
+		dcn2_1_soc.clock_limits[0].dcfclk_mhz = clk_table->entries[0].dcfclk_mhz;
+		dcn2_1_soc.clock_limits[0].fabricclk_mhz = clk_table->entries[0].fclk_mhz;
+		dcn2_1_soc.clock_limits[0].socclk_mhz = clk_table->entries[0].socclk_mhz;
+		dcn2_1_soc.clock_limits[0].dram_speed_mts = clk_table->entries[0].memclk_mhz * 2;
+
+		/*
+		 * Other levels: find cloest DCN clocks that fit the given clock limit using dcfclk
+		 * as indicater
+		 */
 
-	dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
-	dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
-	dcn2_1_soc.num_chans = bw_params->num_channels;
+		closest_clk_lvl = -1;
+		/* index currently being filled */
+		k = 1;
+		for (i = 1; i < clk_table->num_entries; i++) {
+			/* loop backwards, skip duplicate state, +1 because SMU has precision issue */
+			for (j = dcn2_1_soc.num_states - 2; j >= k; j--) {
+				if ((unsigned int) dcn2_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
 
-	for (i = 0; i < clk_table->num_entries; i++) {
+			/* if found a lvl that fits, use the DCN clks from it, if not, go to next clk limit*/
+			if (closest_clk_lvl != -1) {
+				dcn2_1_soc.clock_limits[k].state = i;
+				dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+				dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+				dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
+				dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+				dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+				dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+				dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+				dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+				dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+				dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+				dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+				k++;
+			}
+		}
 
-		dcn2_1_soc.clock_limits[i].state = i;
-		dcn2_1_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-		dcn2_1_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-		dcn2_1_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-		dcn2_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+		/* duplicate last level */
+		dcn2_1_soc.clock_limits[k] = dcn2_1_soc.clock_limits[k - 1];
+		dcn2_1_soc.clock_limits[k].state = k;
+		dcn2_1_soc.num_states = k + 1;
 	}
-	dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i - 1];
-	dcn2_1_soc.num_states = i;
 
-	// diags does not retrieve proper values from SMU, do not update DML instance for diags
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) && !IS_DIAG_DC(dc->ctx->dce_environment))
-		dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
+	dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
 }
 
 /* Temporary Place holder until we can get them from fuse */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 1f5446321112..9bb8bff4cdd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -25,7 +25,7 @@
 #ifndef __DISPLAY_MODE_STRUCTS_H__
 #define __DISPLAY_MODE_STRUCTS_H__
 
-#define MAX_CLOCK_LIMIT_STATES 8
+#define MAX_CLOCK_LIMIT_STATES 9
 
 typedef struct _vcs_dpi_voltage_scaling_st voltage_scaling_st;
 typedef struct _vcs_dpi_soc_bounding_box_st soc_bounding_box_st;
@@ -61,6 +61,7 @@ struct _vcs_dpi_voltage_scaling_st {
 	double dram_speed_mts;
 	double fabricclk_mhz;
 	double dispclk_mhz;
+	double dram_bw_per_chan_gbps;
 	double phyclk_mhz;
 	double dppclk_mhz;
 	double dtbclk_mhz;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

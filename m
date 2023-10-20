Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F15C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 21:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B635510E5F4;
	Fri, 20 Oct 2023 21:30:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B657210E5F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 21:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuC4RK+tY8OBnKlA2UtaOSpMzNtTL35gNQGhKZq8dGXjCFR7ikO7klzOHyhRaZUIRR/w1j9+ZELXjmYcbJjD7pszvTQgAc2MAV+H78mN3i6rXd3YvfTyCD689oEHaC4S5q5MnNl+LQO7p/0zpYb811K/VhGclMO8xlXlYqo/hl+qtKZIWWPoHpSoBugf0agFYUP8DtpNF7AwvEqwraxAIYk/BJgHr72QHaUvFGj0TTtGXQnHIsXO40pJkHZkCdqU9b+JtTboMlYdtNgBdqIj6rEx+CDQEbuuZ6BhuFnAg0j4drvxIDkF8S6+cLuJ7/JzMrHFZ+7C1v12B+3/zZ07Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB8rUBKBriDfmUVAECbj9Uiwl6QSNds7LGm+GucOSuA=;
 b=drTOVdkrexb/iUmUJQJVrZKfZ00tH3jCdy7WzNeUAi5lfHykQc2K9zEL1p5MltfsopepPtXhsKE66V58vRBnQT032FPUy2nMVC+KIHjtcdRKX3rYuzHyWTpzAi9IXQJqZgYlNlVviucWanSSTqEJdtxYctSJOFld4MrFSW+ptmf9d9S4KgR0C52KqRskI4ufMguE7D1TEcg8Ky/YwopkgDwbTdnzfIrW0U2cmXatxMt7Kws2wDKzmv3EzvMbtWLvG0t4rIrMP0HEo0TMRnkJDLiwy3Ez3Puskn3bq/d8/ISO+pSnGd+EcFsxIdNHBiP0YBwXlgzXmslmekMDotQ9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB8rUBKBriDfmUVAECbj9Uiwl6QSNds7LGm+GucOSuA=;
 b=1qPsUyfd6CKd2ZWbAbSHiSdN1AQqKQEwgEg/INner3eavwiZLQFPcNY6bPkgC0m76i98naRsLLf6FYxIiDs6n5r4XwVmeoDmlZt2tf29ZWXwkQympPtkCzA8YRXHpsoyA5QWb3iBIIY+Xs0J/4v5dgLfS8EoQ2n9cCDaXxi6rQo=
Received: from MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27) by
 MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Fri, 20 Oct 2023 21:30:39 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::5c) by MN2PR01CA0058.outlook.office365.com
 (2603:10b6:208:23f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 21:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 21:30:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 16:30:37 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/display: Set the DML2 attribute to false in
 all DCNs older than version 3.5
Date: Fri, 20 Oct 2023 15:26:33 -0600
Message-ID: <20231020213009.486473-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
References: <20231020213009.486473-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e302637-3dc0-430b-c079-08dbd1b3cdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAseEPx5idOPB6Y3cY6VwqEqEX5Bq8dGG0UFEGJG6N6aDqSK1QMU3aD2XECCvwoLipXL6U9XaZcYZOEm1jqAZ3yglDc7mzV4K6D++PtmO7RzFL8ABIEHLNjWvUk00VXQnWsLVXkeifaDxDSTByzQPgJiRg2b91KhRqJ9gB/MAAgVxaihuS5TWPj9LIyOEDFg8xnWbVpMPCfxDWBKtu76xuCTdiwjoHq8OkqABpFeLxnXPgFJiuJlgGDzf4/baPpHUePZs0LRj8VeXSt82/qJ6tpxTPNCrA/MgeeoNTZsebozsVDrk2RsYzA0JFEZUtWCLM3Tdd+2Azyf8RuQGGdS754qGNtgeWck2l/MTzxRhpqm+6pe6IGfV3txJcgWlkGHD/dEILx5ULOHyPeyygNuwak4VhI0GwR9WUVtp4qkK2VVIdgLDs3gSpYlvoMnA1elsq4smxaXrRThwE3Yovq3H/3OYefGX2loaFfDWV5qvnrkaj5KwlTbPhpblkzYxA5LKY9SQhxcUlBKM93SeJ3R3wkFvwcUPPaoEhTBsSxZatEfYZu1IwoLfL8cht48SrlHe9tgbZb7AnJpmrUWE1h0sGoGuJswtojmisXmoA1lZSdcOuxwJrocx93oUtHu1zr9fFcRlw7lisGOXMY4edbDuzaYs/m3dt9DHnICcDgHySy1uQ9KEqoNb1NoUvDLEl1g6L+o93oK0noiAhyBE2tjnKsdE9TH1fPP1M9kxmgjXlvGbx49kB1xTJjo1cKI0DQAoWSsG4PPlk22cI3Tse9lmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(8936002)(40460700003)(26005)(16526019)(2616005)(6666004)(4326008)(336012)(83380400001)(316002)(41300700001)(5660300002)(8676002)(36860700001)(478600001)(47076005)(70206006)(2906002)(70586007)(54906003)(1076003)(6916009)(426003)(82740400003)(356005)(86362001)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:30:38.7767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e302637-3dc0-430b-c079-08dbd1b3cdfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
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
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When DML2 was introduced, it targeted only new DCN versions. For
controlling which ASIC should use this new version of DML, it was
introduced the using_dml2 attribute. To avoid ambiguities, this commit
explicitly sets using_dml2 to false in all ASICs that do not support
DML2.

Cc: Vitaly Prosyak <vprosyak@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 13 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index d1d8e904346e..b94c5c97eee7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -554,6 +554,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.max_downscale_src_width = 3840,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_legacy_fast_update = true,
+		.using_dml2 = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 7eda4bbcd8ac..0a422fbb14bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -723,6 +723,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.sanity_checks = false,
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_legacy_fast_update = true,
+		.using_dml2 = false,
 };
 
 void dcn20_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index a11b2f6afe4a..bca22d867696 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -614,6 +614,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.underflow_assert_delay_us = 0xFFFFFFFF,
 		.enable_tri_buf = false,
 		.enable_legacy_fast_update = true,
+		.using_dml2 = false,
 };
 
 static void dcn201_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 58a0d37e9523..42277b280586 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -654,6 +654,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.dmub_command_table = true,
 		.use_max_lb = true,
 		.enable_legacy_fast_update = true,
+		.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 473581cff06b..7b259cb5f418 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -729,6 +729,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.use_max_lb = true,
 	.exit_idle_opt_for_cursor_updates = true,
 	.enable_legacy_fast_update = false,
+	.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index b4b3b52990b9..f3b75f283aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -701,7 +701,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.dwb_fi_phase = -1, // -1 = disable
 	.dmub_command_table = true,
 	.use_max_lb = false,
-	.exit_idle_opt_for_cursor_updates = true
+	.exit_idle_opt_for_cursor_updates = true,
+	.using_dml2 = false,
 };
 
 static void dcn301_dpp_destroy(struct dpp **dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 06332bd4e625..63ac984a04f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -99,6 +99,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.use_max_lb = true,
 		.exit_idle_opt_for_cursor_updates = true,
 		.enable_legacy_fast_update = false,
+		.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 0d91291a54a9..3f0b52f50d93 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -81,6 +81,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.dmub_command_table = true,
 		.exit_idle_opt_for_cursor_updates = true,
 		.disable_idle_power_optimizations = false,
+		.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index cdf005f91869..79416cfb22f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -893,6 +893,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_legacy_fast_update = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
 	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
+	.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 2d7436f2ea82..ab301ea7c10b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -924,7 +924,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 			}
 	},
 
-	.seamless_boot_odm_combine = true
+	.seamless_boot_odm_combine = true,
+	.using_dml2 = false,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index c11dbb1f4033..cb8024eee8e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -889,6 +889,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.enable_legacy_fast_update = true,
 	.psr_power_use_phy_fsm = 0,
+	.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 4220fe4cae4a..b9753d4606f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -885,6 +885,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		}
 	},
 	.enable_legacy_fast_update = true,
+	.using_dml2 = false,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 44caf6711589..0b1ce6e28e11 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -732,6 +732,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.fpo_vactive_max_blank_us = 1000,
 	.enable_legacy_fast_update = false,
 	.disable_dc_mode_overwrite = true,
+	.using_dml2 = false,
 };
 
 static struct dce_aux *dcn321_aux_engine_create(
-- 
2.42.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A581DC25B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C0E10E81C;
	Thu, 26 Oct 2023 14:21:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F2510E812
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHiIEIM8WasAhlzNg6gq6GGEn6i7vnYO+0LJVpjv5SeyYP7CySC+5ka1wxw701OJW2lvEFmzBf5wYBnwxNpGZNOxWlHSAcqAiEMG/LfJXON1Jaf7xTxnPL7cV9kXmEKwtMntajxWJ4iU/6R1C2srUWPLqE3zXWXR4CXh1XG1krlJLYy5HhKDVamd79jDcX5vMeInDumFHbBU+diaLEwpp4mBMWCVFFqN1Sbvs5OwwTKRAiiUG3YHrAjYhaITLtludC2Z0Skby0lygyk2O9Vmv+pVsw6JsZc8PecziZ3RZ8wSx/UxDq/pQGk+Ubojyu+mCVSGSdpx8cji/ZsMXOVXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy0TMFZ8Efb/1x/+mJAEXsS1ZOWtTHEA8ZKhA7m6ozE=;
 b=frMok58mbEPGVneP/AkqC7yu1QN+lyh1New9Zak7vGVzYTYim4ugNa5yHCFlMML7yaaH018FUkw7cQ5HtbnMJj23TaMrXtABUhnSoUr3TbzMOICX3x65xGPeGFNmnY1eljN4JialXK0CzUGJ6lnRub89Q2pTyCglw2jlVkG5vwDxtTxyUZve/HzySSPPfrf3o3pZkXimpKgtlfKa1g13ZCxG2NBXwL0Xdq82QuIjNWrOvOoePVJkat7MTChs5xkX4vecrqsSTEfqNdg+8nQGtsJ8oUHnQVi6wY/gG3/ziacFH9r1nPgAuVv7xgqY5uBiHs1vyqALMkCFJPnOT0ZztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy0TMFZ8Efb/1x/+mJAEXsS1ZOWtTHEA8ZKhA7m6ozE=;
 b=v81kde49AoQSA37glH5HP3SF9a1MyGgudL+Cs8wBQbdiuV75hKK8OZD9a3B0xVngfXIleciwDbgjUxvCq9GEtJz8727+nWhj93jAbubVKile/GmJTuOmHBD9qVpV6m0p1y4JXpIvssYFGDwdZNEu11coNgMYW6FdqtmvBQ4BjFs=
Received: from DM6PR13CA0071.namprd13.prod.outlook.com (2603:10b6:5:134::48)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 14:20:47 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::1f) by DM6PR13CA0071.outlook.office365.com
 (2603:10b6:5:134::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:46 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:45 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/25] drm/amd/display: Enable DCN clock gating
Date: Thu, 26 Oct 2023 10:20:11 -0400
Message-ID: <20231026142020.67861-17-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 8178c3af-16b5-4389-d0f8-08dbd62ebfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb9+k48Q9DQBiV5g3vRXl0wNyCmdeDxUIJOvypnPwB+/HQsXvwHgWYtyoW8y9Y5HefWCxdin4x7TgYUUeTF0HPdakPonBK2yLAqS3StlNZPtv9LCN7fmr2Z0M/kOGW41KJGqt19C66emtK0wCcICaG4XB9PYAryqqtd7Kye8kY3NwzFmEbPEHM6jiyPZHsa0zjgwybO6MwPdaReQ16AMz6DC0MxHRgiSRHE5Gtx+DIqEDJgAop1WzqISK6OIOC4TYaZcsUJwmEhGTRCfaTRbx20qSes3a6HXqhwyC57KhnLNBh07ODbEQJRqBvEYAT/fuQbBWEfKfjy12TRlpOf4ynT9INUZIXOacWv2mCtwTCMU4GdyY6efX6cOfkEpr4ksR8YZVYJN2UWe0G30p2ux9/0ww6/roMfAcmyXyR8XF121+TFzsQ+BZJyPxjkyhLmcVU/C8uTwOcNtcvamXOzTEWG7D6pqWcC+TZl/wipxqKGLvY21D4VrstVU+oTEvcY8Rs5tX/+v+PMDqjnpTZZn99y4uuboffj5SXISn0/6xvbb0cYuUF/OxJYKXSAeSxCN7NpZQXySLGfGCh6IwTTrLi4TUaqer73mkM+ccyxJlAUhuSfmUXOYEAxfKqV0e/KsqKebMBiN+NsKuD49kG4rK8w3DJ06ZuJeBz2mTLojghCR+dVACmmr0k0iMxovZ1suaROH5v5OqntCefBNRQU2DMOzltPVI8xWiC96lPGT4Ue3sbPbFMu3D/Hwu/YqIaJJkxCDuDkL0Pmb2jeiXvFHyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(6666004)(40460700003)(40480700001)(336012)(426003)(356005)(82740400003)(81166007)(86362001)(47076005)(36756003)(83380400001)(36860700001)(2616005)(26005)(1076003)(54906003)(6916009)(316002)(41300700001)(70206006)(5660300002)(70586007)(2906002)(478600001)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:47.5166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8178c3af-16b5-4389-d0f8-08dbd62ebfb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why & How]
Enable dcn clock gating for dcn35
Disable DTBCLK gate before FRL link training
and re-enable afterwards

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h    |  6 +++++-
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c | 10 +---------
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h |  1 -
 .../gpu/drm/amd/display/dc/dcn35/dcn35_resource.c    |  2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c  | 11 +++++------
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h         |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h      |  2 --
 8 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index ab6d09c6fe34..76da59d8caaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -291,7 +291,11 @@
 	type SYMCLKB_FE_SRC_SEL;\
 	type SYMCLKC_FE_SRC_SEL;\
 	type SYMCLKD_FE_SRC_SEL;\
-	type SYMCLKE_FE_SRC_SEL;
+	type SYMCLKE_FE_SRC_SEL;\
+	type DTBCLK_P0_GATE_DISABLE;\
+	type DTBCLK_P1_GATE_DISABLE;\
+	type DTBCLK_P2_GATE_DISABLE;\
+	type DTBCLK_P3_GATE_DISABLE;\
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index addedcfd1238..0290ece6be50 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -744,6 +744,17 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 	}
 }
 
+static void dccg35_set_dtbclk_dto_gating(struct dccg *dccg, bool enable)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL5,
+			DTBCLK_P0_GATE_DISABLE, enable ? 0x0 : 0x1,
+			DTBCLK_P1_GATE_DISABLE, enable ? 0x0 : 0x1,
+			DTBCLK_P2_GATE_DISABLE, enable ? 0x0 : 0x1,
+			DTBCLK_P3_GATE_DISABLE, enable ? 0x0 : 0x1);
+}
+
 static const struct dccg_funcs dccg35_funcs = {
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
@@ -768,6 +779,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
+	.set_dtbclk_dto_gating = dccg35_set_dtbclk_dto_gating,
 };
 
 struct dccg *dccg35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 46f71ff08fd1..0f60c40e1fc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -332,13 +332,6 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	pg_cntl->pg_res_enable[PG_DCIO] = power_on;
 }
 
-void pg_cntl35_set_force_poweron_domain22(struct pg_cntl *pg_cntl, bool power_on)
-{
-	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
-
-	REG_UPDATE(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, power_on ? 1 : 0);
-}
-
 static bool pg_cntl35_plane_otg_status(struct pg_cntl *pg_cntl)
 {
 	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
@@ -508,8 +501,7 @@ static const struct pg_cntl_funcs pg_cntl35_funcs = {
 	.mpcc_pg_control = pg_cntl35_mpcc_pg_control,
 	.opp_pg_control = pg_cntl35_opp_pg_control,
 	.optc_pg_control = pg_cntl35_optc_pg_control,
-	.dwb_pg_control = pg_cntl35_dwb_pg_control,
-	.set_force_poweron_domain22 = pg_cntl35_set_force_poweron_domain22
+	.dwb_pg_control = pg_cntl35_dwb_pg_control
 };
 
 struct pg_cntl *pg_cntl35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
index 069dae08e222..3de240884d22 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
@@ -183,7 +183,6 @@ void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
 	unsigned int optc_inst, bool power_on);
 void pg_cntl35_dwb_pg_control(struct pg_cntl *pg_cntl, bool power_on);
 void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl);
-void pg_cntl35_set_force_poweron_domain22(struct pg_cntl *pg_cntl, bool power_on);
 
 struct pg_cntl *pg_cntl35_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index a1f4d775db23..03fd270f4dbe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -689,7 +689,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
-	.disable_clock_gate = true,
+	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 0569fa6f7600..66175f68f6da 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -145,9 +145,11 @@ void dcn35_init_hw(struct dc *dc)
 		hws->funcs.bios_golden_init(dc);
 	}
 
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
+	if (dc->debug.disable_clock_gate) {
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
+	}
 
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
@@ -312,9 +314,6 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->res_pool->pg_cntl) {
 		if (dc->res_pool->pg_cntl->funcs->init_pg_status)
 			dc->res_pool->pg_cntl->funcs->init_pg_status(dc->res_pool->pg_cntl);
-
-		if (dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22)
-			dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22(dc->res_pool->pg_cntl, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 13f12f2a3f81..1af2f7d3acac 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -196,6 +196,10 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			enum streamclk_source src,
 			uint32_t otg_inst);
+
+	void (*set_dtbclk_dto_gating)(
+			struct dccg *dccg,
+			bool enable);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
index b9812afb886b..00ea3864dd4d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
@@ -47,8 +47,6 @@ struct pg_cntl_funcs {
 	void (*optc_pg_control)(struct pg_cntl *pg_cntl, unsigned int optc_inst, bool power_on);
 	void (*dwb_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
 	void (*init_pg_status)(struct pg_cntl *pg_cntl);
-
-	void (*set_force_poweron_domain22)(struct pg_cntl *pg_cntl, bool power_on);
 };
 
 #endif //__DC_PG_CNTL_H__
-- 
2.25.1


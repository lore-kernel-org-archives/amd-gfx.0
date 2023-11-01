Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D24BC4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A89710E777;
	Wed,  1 Nov 2023 20:08:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B0510E777
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:08:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXDpI1slqpNgJshFh7JLPKODL1OSBndp7agMLb4QgBXnrd6Ol5uISxerPBxGsm0ZVO6GFM30Bvuq+FoB7C8xrsUXb6mfXCzsJq5FP1kFC/dAwML1OHkxGNYD4nOIaAcZ+uQirvrR+sCQTuviJgnCj1O/njatEp0sWbbJARmdt7YFat/yyOKjQz1e0ULPJvBXjfNlgPh7YFVwy5h5oqEBoeZch7q3GvAMZDI6eA4uaeGUILx1A1ZIo98pjGwAZP9b7xfhsEHK/GD5ImynBzSgGZIb3zg0uL1ZslIuZvLNWf2dQFW8O3+eee+4Fw1dvkeTGBN/6fay4VZUlil7io8Zfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+owqnD6dVdDdTbfO5qAxYXNfQfjUdwJcQgocoXM2OQ=;
 b=McrkmEBz26tmX86nbeK8nmU1NMAJsRVqJnoTCuVVmGahs1kmG4MkgcW9+prNafWYfh1DCbZIjCDEu/dPP+1TR01KWNpc+w1ax376FGHglrPr0K20+2Q8BzY7efIWa6J2TQoqokPznCGi3MlnijAXB+R4kFVu0efby7F1h7HIu28+fBzx4uYKNTmN/r5eszoy1eR3SHkxrwGMMi/2dOlSqWtsGZGJazI9m1F4C/XnahIBnZPGveCwyyuzOjXnHYoFCwISN93X8XtOWC4Y5ppDobmfR5QRFBgtzuu7pgxOdfAc/eHLorrkNfMNfG8iAINbg8LklDR3swBgMzsoqnZORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+owqnD6dVdDdTbfO5qAxYXNfQfjUdwJcQgocoXM2OQ=;
 b=4KkXveqDUB3dnRt3CmpxDl0oFEtDiITJv8+3HT/xqbU/QOpVAueUUx3UGCmNA4r2zek6Wc9P67nFbgkYAblI4y26luzR4V4M32Q4GQxTaTi+j1PuAlEU5lA3e2sdtgyT6WjcI6rImG0XONKs0MPDxtvBvHdUZG048rvi6dSsP+4=
Received: from DM6PR17CA0035.namprd17.prod.outlook.com (2603:10b6:5:1b3::48)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 20:08:48 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::96) by DM6PR17CA0035.outlook.office365.com
 (2603:10b6:5:1b3::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:46 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:44 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Revert Enable DCN clock gating
Date: Wed, 1 Nov 2023 16:08:23 -0400
Message-ID: <20231101200832.995436-4-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: b007383e-84a7-4ee2-a879-08dbdb165bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0b+clXfIal/ysSGgR33QfMwvjjqeQ9luEyoM1AOx/JgXTf4H4lAHDICNaDtIWam/UQbe2PW/OYNfj8huWr7Oot5xFTmDwhtJpJFcs192nXtG+cC+A5uIvv+BMtrLZzePwJYKh9zl2JwhJKJhK9MkROMIZrEIX0nqBg5TRGbSGToe+jzMIUBzLjUUqK7GAisD/XFVHd5N0MUhQNdas/NhYBSNCbg2y6TuYtLSa1EAkU/0qg2YYWjFelaugCXTMjyJ7q+hpk5pr7toDd3ZazwY968O9lBPjB64xeujgcownJLJdOOtMNxDk+V+tmrg8W3+ym+VAqazPOGbljUMkt1G+tPh1dmPo2Zek2EGdqyrY8iK1MeyGlL7ShpXVCg5gCsZ/Z88JYnm/NewJwpr8SacVHrkWqx5STQaXHrWAeFe1gIu5iZtM0/IyYnvTr14uZAmAgomPYoI70VxGusYDGiVTnrPohsEAhgCZFSXL8Q/jYUfhAjt2v1UxzAMlICOttfw5B5el+AFX8eOkExfOoy5mi91t0ADbv+ROOcCQPIBCSs+hfx/dNqMbHPjehZ1wnaj2BiPLgepXimkwSmh0bDkAJh8CNCNfPPAEywBKDjc9cSGUR0xe+faEKmxd0WTNJuH8m3A3eiWMcF9BBYmWCLdz7P56yA6J9Om3wBHOsoBOEWVLIpU8fCRK03R8PM8V48ZIhR9IfTxLmAA+PXNkC9pgW8ss/QHrRpQoU1/7AFNR2C3lOtgMzmtj0JnLnWg4oGA92taMdb6qEXo3kwRmIUwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(36840700001)(46966006)(40470700004)(4326008)(5660300002)(41300700001)(8936002)(8676002)(70206006)(6916009)(70586007)(54906003)(316002)(2906002)(40480700001)(40460700003)(478600001)(26005)(6666004)(36860700001)(83380400001)(81166007)(47076005)(356005)(82740400003)(36756003)(7696005)(426003)(1076003)(2616005)(86362001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:08:47.8819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b007383e-84a7-4ee2-a879-08dbdb165bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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

[Why]
DCN clock gating enablement is preventing light up on
high resolution DSC display

[How]
This reverts commit 933b6692d58671e47dff15b77abe69ccb4891298.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h    |  6 +-----
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c    | 12 ------------
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h |  1 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_resource.c    |  2 +-
 .../gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c  | 11 ++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h         |  4 ----
 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h      |  2 ++
 8 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
index 76da59d8caaf..ab6d09c6fe34 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h
@@ -291,11 +291,7 @@
 	type SYMCLKB_FE_SRC_SEL;\
 	type SYMCLKC_FE_SRC_SEL;\
 	type SYMCLKD_FE_SRC_SEL;\
-	type SYMCLKE_FE_SRC_SEL;\
-	type DTBCLK_P0_GATE_DISABLE;\
-	type DTBCLK_P1_GATE_DISABLE;\
-	type DTBCLK_P2_GATE_DISABLE;\
-	type DTBCLK_P3_GATE_DISABLE;\
+	type SYMCLKE_FE_SRC_SEL;
 
 struct dccg_shift {
 	DCCG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index c5d7f67d9856..277aae811eea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -744,17 +744,6 @@ static void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst
 	}
 }
 
-static void dccg35_set_dtbclk_dto_gating(struct dccg *dccg, bool enable)
-{
-	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-
-	REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL5,
-			DTBCLK_P0_GATE_DISABLE, enable ? 0x0 : 0x1,
-			DTBCLK_P1_GATE_DISABLE, enable ? 0x0 : 0x1,
-			DTBCLK_P2_GATE_DISABLE, enable ? 0x0 : 0x1,
-			DTBCLK_P3_GATE_DISABLE, enable ? 0x0 : 0x1);
-}
-
 static const struct dccg_funcs dccg35_funcs = {
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
@@ -780,7 +769,6 @@ static const struct dccg_funcs dccg35_funcs = {
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
-	.set_dtbclk_dto_gating = dccg35_set_dtbclk_dto_gating,
 };
 
 struct dccg *dccg35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
index 0f60c40e1fc5..46f71ff08fd1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
@@ -332,6 +332,13 @@ void pg_cntl35_io_clk_pg_control(struct pg_cntl *pg_cntl, bool power_on)
 	pg_cntl->pg_res_enable[PG_DCIO] = power_on;
 }
 
+void pg_cntl35_set_force_poweron_domain22(struct pg_cntl *pg_cntl, bool power_on)
+{
+	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
+
+	REG_UPDATE(DOMAIN22_PG_CONFIG, DOMAIN_POWER_FORCEON, power_on ? 1 : 0);
+}
+
 static bool pg_cntl35_plane_otg_status(struct pg_cntl *pg_cntl)
 {
 	struct dcn_pg_cntl *pg_cntl_dcn = TO_DCN_PG_CNTL(pg_cntl);
@@ -501,7 +508,8 @@ static const struct pg_cntl_funcs pg_cntl35_funcs = {
 	.mpcc_pg_control = pg_cntl35_mpcc_pg_control,
 	.opp_pg_control = pg_cntl35_opp_pg_control,
 	.optc_pg_control = pg_cntl35_optc_pg_control,
-	.dwb_pg_control = pg_cntl35_dwb_pg_control
+	.dwb_pg_control = pg_cntl35_dwb_pg_control,
+	.set_force_poweron_domain22 = pg_cntl35_set_force_poweron_domain22
 };
 
 struct pg_cntl *pg_cntl35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
index 3de240884d22..069dae08e222 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
@@ -183,6 +183,7 @@ void pg_cntl35_optc_pg_control(struct pg_cntl *pg_cntl,
 	unsigned int optc_inst, bool power_on);
 void pg_cntl35_dwb_pg_control(struct pg_cntl *pg_cntl, bool power_on);
 void pg_cntl35_init_pg_status(struct pg_cntl *pg_cntl);
+void pg_cntl35_set_force_poweron_domain22(struct pg_cntl *pg_cntl, bool power_on);
 
 struct pg_cntl *pg_cntl35_create(
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 4eb76896fd63..e35d4c028d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -689,7 +689,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
-	.disable_clock_gate = false,
+	.disable_clock_gate = true,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 66175f68f6da..0569fa6f7600 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -145,11 +145,9 @@ void dcn35_init_hw(struct dc *dc)
 		hws->funcs.bios_golden_init(dc);
 	}
 
-	if (dc->debug.disable_clock_gate) {
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
-		REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
-	}
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL2, 0x3F000000);
+	REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
 
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
@@ -314,6 +312,9 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->res_pool->pg_cntl) {
 		if (dc->res_pool->pg_cntl->funcs->init_pg_status)
 			dc->res_pool->pg_cntl->funcs->init_pg_status(dc->res_pool->pg_cntl);
+
+		if (dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22)
+			dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22(dc->res_pool->pg_cntl, false);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 1af2f7d3acac..13f12f2a3f81 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -196,10 +196,6 @@ struct dccg_funcs {
 			struct dccg *dccg,
 			enum streamclk_source src,
 			uint32_t otg_inst);
-
-	void (*set_dtbclk_dto_gating)(
-			struct dccg *dccg,
-			bool enable);
 };
 
 #endif //__DAL_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
index 00ea3864dd4d..b9812afb886b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
@@ -47,6 +47,8 @@ struct pg_cntl_funcs {
 	void (*optc_pg_control)(struct pg_cntl *pg_cntl, unsigned int optc_inst, bool power_on);
 	void (*dwb_pg_control)(struct pg_cntl *pg_cntl, bool power_on);
 	void (*init_pg_status)(struct pg_cntl *pg_cntl);
+
+	void (*set_force_poweron_domain22)(struct pg_cntl *pg_cntl, bool power_on);
 };
 
 #endif //__DC_PG_CNTL_H__
-- 
2.25.1


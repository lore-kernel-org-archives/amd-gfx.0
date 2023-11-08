Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8FBC4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 19:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 980AB10E827;
	Wed,  8 Nov 2023 19:08:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8F810E823
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 19:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5m947lGJ0I04crSuYCsGf4R1oxVRbuh5tviMOC8EOIemQd1PFvwaFXDbrfMsOnL7C9hnlUKiHoUASEZoN3gImdPCiP8dynECydRhZdULW3e0+dVR+IkbI3FliITwrLaLp8GWoom2TGL3zplEOPgJusyLzmqUxxADKIvszfdlfmFkCmTpbDmoSMM78vGWEZLZuLSs0H8hPttXrfJi4/gNqip6/xb8hxnlWjNzrQEpoqTmtEyvgcWgf+rIx2TFCmwFbtaIDbUuJbsNzFrEgPcwPW/7RQTMLSVDLcD8UFpq1gnhtSjnOscjPxX6VHKe75hNYCWmxrTIDM0tmP4VvrEqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP1E1uXDZCPrxwZUuABwSHb32HKSfUBlbi982KOBkKQ=;
 b=oDjr661swhLoHNuIQ0u/NAAAiGJUzbczzcwThUyJITa9b5ND2GeScuqcv90Sg7ZxIq49YoVMknxhGC7DyHfvE0lYRAK+xtAFokIJZziWaQBPFhVsXKXfOA61GwHw1A6iATPkA22mWeNRl2MyUnUwMGkD72/dMSMsUSTzv4z5h9Tz6AsgCraZD7bP0AxRt2dX4v075SJPZhety7RZ0kgwTVCGe26fyiA7vnYslHcOQF23w3zruvWb0LLBdJAXCIvu/FKSW5bjYrhH3myeWKJFjsYXYVxblrMTbkEJPZSwXepCrqsg3pyB7RH7Rh247fkkdMdjGXsOBEf79haWNBOiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP1E1uXDZCPrxwZUuABwSHb32HKSfUBlbi982KOBkKQ=;
 b=39yTNVX0mtYQW6+qliZQ7xNf74a/nyXToPR+XG8Z7vPjdNQVu7WORHjAtOEUGXis4gsdp/j51dWcNOKhpkwVuYHAc4ldT0GA5Ypx9bwO87V6Fla7etGwAJ9tL7X78zNdZOmE/CL0K2x6VT/8+/4f0LM7iTGnx2XOcT6C4/CHX5w=
Received: from CH0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:610:cc::12)
 by CY5PR12MB6574.namprd12.prod.outlook.com (2603:10b6:930:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 19:07:49 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::5d) by CH0PR03CA0067.outlook.office365.com
 (2603:10b6:610:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 19:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 19:07:44 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 13:07:40 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/20] drm/amd/display: Enable DCN clock gating for DCN35
Date: Wed, 8 Nov 2023 11:44:26 -0700
Message-ID: <20231108185501.45359-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108185501.45359-1-alex.hung@amd.com>
References: <20231108185501.45359-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: a38112ef-d166-4c62-d7f3-08dbe08dfcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1mhmjODMEh9XrsgSmvAdkYuRN8mpstPocw9i91sjqs1huM8THe8Ze6duyLDzsE3Zp0x+rGhLkV1Cb1oqed0nnETS1kUdN4rjWsGYvo8UgUCAPXaHxSeCp43nQGH3pcJvOADUPaeMkF6fWjzcufdQkqw6TWmKor0yH89Oign5YBZ7tXNXc9Wu7D5kHb6P1XpZ+4ikcYPFvMPgoBj32oCHqNYieozI5YNUje9hPWffSFWeNXshkQTwTgSqP6Tsdqh8kC2nZ2Fy1jtyDMHP4hMdnTGxsJDjSxqUUm/ZJcb8QmaAM0BYpsdy1AQYwdy6M/48igWVGN847LnWC9f1iGrMK9iiAjkoH7gjati5RZDJ9lcPuOA9l3SIiXKlxwAiFrm73ok16Qb4HKyZEOZrSYNPXMMqaQfoJJStGqO6ssOUEszw6S8m6ncJSWu5FssxDRY/7PQRSA3I5y9bNKkwmuLWuRgIVp2ACSIZNKMqriRPpm+wEeTSwxbQn7t6Oo5u/RMogIVby4vtydNGV+qr6DtroQml0gEA7BHvhzaDOAU+WncmGk+HCQAp1sX/3Udx1+0Zjjy4sqannaAwygE52cZ2psGpNFAHf8S6wwqaxt24ScvZk7UaXXeAJ+byfcHoGRoHptG5eKFD+iAlVarx0ObjkfaIcIW7rsSmh4SLgjsG9raXTLD4ubgC0EsJ9yRWnEfyYewwii5df8VPsORnnpW73+Op1mJdnZ4lYJ1Rx9ixypss1MkDw2SjZAzrJ8Dp2bzxJmQgStLY6yhLm2MLd7A0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(6666004)(7696005)(478600001)(2616005)(83380400001)(316002)(426003)(336012)(1076003)(26005)(2906002)(5660300002)(30864003)(4326008)(16526019)(6916009)(82740400003)(70586007)(54906003)(8936002)(8676002)(41300700001)(70206006)(44832011)(356005)(47076005)(36860700001)(36756003)(86362001)(81166007)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 19:07:44.1125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38112ef-d166-4c62-d7f3-08dbe08dfcf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
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
 roman.li@amd.com, Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[WHY & HOW]
Enable DCN clock gating for DCN35.
Disable DTBCLK gate before link training
and re-enable afterwards

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  6 ++-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 30 +++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h |  7 +++-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  | 10 +----
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |  1 -
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   | 15 ++++++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 42 +++++++++++++------
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |  2 -
 .../dc/resource/dcn35/dcn35_resource.c        | 16 ++++++-
 .../dc/resource/dcn35/dcn35_resource.h        |  1 +
 .../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h  |  8 ++++
 11 files changed, 108 insertions(+), 30 deletions(-)

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
index 479f3683c0b7..142efd390d86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -256,6 +256,21 @@ static void dccg35_set_dtbclk_dto(
 	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
 		uint32_t modulo, phase;
 
+		switch (params->otg_inst) {
+		case 0:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, 1);
+			break;
+		case 1:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, 1);
+			break;
+		case 2:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, 1);
+			break;
+		case 3:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, 1);
+			break;
+		}
+
 		// phase / modulo = dtbclk / dtbclk ref
 		modulo = params->ref_dtbclk_khz * 1000;
 		phase = req_dtbclk_khz * 1000;
@@ -280,6 +295,21 @@ static void dccg35_set_dtbclk_dto(
 		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
 				PIPE_DTO_SRC_SEL[params->otg_inst], 2);
 	} else {
+		switch (params->otg_inst) {
+		case 0:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, 0);
+			break;
+		case 1:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, 0);
+			break;
+		case 2:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, 0);
+			break;
+		case 3:
+			REG_UPDATE(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, 0);
+			break;
+		}
+
 		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
 				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
 				PIPE_DTO_SRC_SEL[params->otg_inst], params->is_hdmi ? 0 : 1);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
index 423feb4c2f3f..bde48bee0119 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
@@ -34,6 +34,7 @@
 #define DCCG_REG_LIST_DCN35() \
 	DCCG_REG_LIST_DCN314(),\
 	SR(DPPCLK_CTRL),\
+	SR(DCCG_GATE_DISABLE_CNTL5),\
 	SR(DCCG_GATE_DISABLE_CNTL6),\
 	SR(DCCG_GLOBAL_FGCG_REP_CNTL),\
 	SR(SYMCLKA_CLOCK_ENABLE),\
@@ -174,7 +175,11 @@
 	DCCG_SF(SYMCLKB_CLOCK_ENABLE, SYMCLKB_FE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKC_CLOCK_ENABLE, SYMCLKC_FE_SRC_SEL, mask_sh),\
 	DCCG_SF(SYMCLKD_CLOCK_ENABLE, SYMCLKD_FE_SRC_SEL, mask_sh),\
-	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh)
+	DCCG_SF(SYMCLKE_CLOCK_ENABLE, SYMCLKE_FE_SRC_SEL, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, mask_sh),\
+	DCCG_SF(DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, mask_sh),\
 
 struct dccg *dccg35_create(
 		struct dc_context *ctx,
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
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
index 44b4df6469d1..52f045cfd52a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
@@ -682,6 +682,7 @@ struct dce_hwseq_registers {
 	uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
 	uint32_t HPO_TOP_HW_CONTROL;
 	uint32_t DMU_CLK_CNTL;
+	uint32_t DCCG_GATE_DISABLE_CNTL4;
 	uint32_t DCCG_GATE_DISABLE_CNTL5;
 };
  /* set field name */
@@ -1199,7 +1200,19 @@ struct dce_hwseq_registers {
 	type PHYBSYMCLK_ROOT_GATE_DISABLE;\
 	type PHYCSYMCLK_ROOT_GATE_DISABLE;\
 	type PHYDSYMCLK_ROOT_GATE_DISABLE;\
-	type PHYESYMCLK_ROOT_GATE_DISABLE;
+	type PHYESYMCLK_ROOT_GATE_DISABLE;\
+	type DTBCLK_P0_GATE_DISABLE;\
+	type DTBCLK_P1_GATE_DISABLE;\
+	type DTBCLK_P2_GATE_DISABLE;\
+	type DTBCLK_P3_GATE_DISABLE;\
+	type DPSTREAMCLK0_GATE_DISABLE;\
+	type DPSTREAMCLK1_GATE_DISABLE;\
+	type DPSTREAMCLK2_GATE_DISABLE;\
+	type DPSTREAMCLK3_GATE_DISABLE;\
+	type DPIASYMCLK0_GATE_DISABLE;\
+	type DPIASYMCLK1_GATE_DISABLE;\
+	type DPIASYMCLK2_GATE_DISABLE;\
+	type DPIASYMCLK3_GATE_DISABLE;
 
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 5a8258287438..39260371beb9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -145,17 +145,36 @@ void dcn35_init_hw(struct dc *dc)
 		hws->funcs.bios_golden_init(dc);
 	}
 
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL2,  0);
-
-	/* Disable gating for PHYASYMCLK. This will be enabled in dccg if needed */
-	REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYBSYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYCSYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYDSYMCLK_ROOT_GATE_DISABLE, 1,
-			PHYESYMCLK_ROOT_GATE_DISABLE, 1);
+	if (!dc->debug.disable_clock_gate) {
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL2,  0);
+
+		/* Disable gating for PHYASYMCLK. This will be enabled in dccg if needed */
+		REG_UPDATE_5(DCCG_GATE_DISABLE_CNTL2, PHYASYMCLK_ROOT_GATE_DISABLE, 1,
+				PHYBSYMCLK_ROOT_GATE_DISABLE, 1,
+				PHYCSYMCLK_ROOT_GATE_DISABLE, 1,
+				PHYDSYMCLK_ROOT_GATE_DISABLE, 1,
+				PHYESYMCLK_ROOT_GATE_DISABLE, 1);
+
+		REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL4,
+				DPIASYMCLK0_GATE_DISABLE, 0,
+				DPIASYMCLK1_GATE_DISABLE, 0,
+				DPIASYMCLK2_GATE_DISABLE, 0,
+				DPIASYMCLK3_GATE_DISABLE, 0);
+
+		REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0xFFFFFFFF);
+		REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL5,
+				DTBCLK_P0_GATE_DISABLE, 0,
+				DTBCLK_P1_GATE_DISABLE, 0,
+				DTBCLK_P2_GATE_DISABLE, 0,
+				DTBCLK_P3_GATE_DISABLE, 0);
+		REG_UPDATE_4(DCCG_GATE_DISABLE_CNTL5,
+				DPSTREAMCLK0_GATE_DISABLE, 0,
+				DPSTREAMCLK1_GATE_DISABLE, 0,
+				DPSTREAMCLK2_GATE_DISABLE, 0,
+				DPSTREAMCLK3_GATE_DISABLE, 0);
 
-	REG_WRITE(DCCG_GATE_DISABLE_CNTL5, 0x1f7c3fcf);
+	}
 
 	// Initialize the dccg
 	if (res_pool->dccg->funcs->dccg_init)
@@ -332,9 +351,6 @@ void dcn35_init_hw(struct dc *dc)
 	if (dc->res_pool->pg_cntl) {
 		if (dc->res_pool->pg_cntl->funcs->init_pg_status)
 			dc->res_pool->pg_cntl->funcs->init_pg_status(dc->res_pool->pg_cntl);
-
-		if (dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22)
-			dc->res_pool->pg_cntl->funcs->set_force_poweron_domain22(dc->res_pool->pg_cntl, false);
 	}
 }
 
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
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index a4027bf053c5..5c935d94a95c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -626,7 +626,19 @@ static struct dce_hwseq_registers hwseq_reg;
 	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYBSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
 	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYCSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
 	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYDSYMCLK_ROOT_GATE_DISABLE, mask_sh), \
-	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_ROOT_GATE_DISABLE, mask_sh)
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL2, PHYESYMCLK_ROOT_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P0_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P1_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P2_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DTBCLK_P3_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK0_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK1_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK2_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL5, DPSTREAMCLK3_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK0_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK1_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK2_GATE_DISABLE, mask_sh),\
+	HWS_SF(, DCCG_GATE_DISABLE_CNTL4, DPIASYMCLK3_GATE_DISABLE, mask_sh)
 
 static const struct dce_hwseq_shift hwseq_shift = {
 		HWSEQ_DCN35_MASK_SH_LIST(__SHIFT)
@@ -705,7 +717,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
-	.disable_clock_gate = true,
+	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
 	.performance_trace = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
index 99aea102e3f7..a51c4a9eaafe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
@@ -166,6 +166,7 @@ struct resource_pool *dcn35_create_resource_pool(
 	SR(MMHUBBUB_MEM_PWR_CNTL), \
 	SR(DCCG_GATE_DISABLE_CNTL), \
 	SR(DCCG_GATE_DISABLE_CNTL2), \
+	SR(DCCG_GATE_DISABLE_CNTL4), \
 	SR(DCCG_GATE_DISABLE_CNTL5), \
 	SR(DCFCLK_CNTL),\
 	SR(DC_MEM_GLOBAL_PWR_REQ_CNTL), \
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
index b64664879211..fca72e2ec929 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h
@@ -6220,12 +6220,20 @@
 #define DCCG_GATE_DISABLE_CNTL4__PHYD_REFCLK_ROOT_GATE_DISABLE__SHIFT                                         0x3
 #define DCCG_GATE_DISABLE_CNTL4__PHYE_REFCLK_ROOT_GATE_DISABLE__SHIFT                                         0x4
 #define DCCG_GATE_DISABLE_CNTL4__HDMICHARCLK0_ROOT_GATE_DISABLE__SHIFT                                        0x11
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK0_GATE_DISABLE__SHIFT                                              0x17
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK1_GATE_DISABLE__SHIFT                                              0x18
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK2_GATE_DISABLE__SHIFT                                              0x19
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK3_GATE_DISABLE__SHIFT                                              0x1a
 #define DCCG_GATE_DISABLE_CNTL4__PHYA_REFCLK_ROOT_GATE_DISABLE_MASK                                           0x00000001L
 #define DCCG_GATE_DISABLE_CNTL4__PHYB_REFCLK_ROOT_GATE_DISABLE_MASK                                           0x00000002L
 #define DCCG_GATE_DISABLE_CNTL4__PHYC_REFCLK_ROOT_GATE_DISABLE_MASK                                           0x00000004L
 #define DCCG_GATE_DISABLE_CNTL4__PHYD_REFCLK_ROOT_GATE_DISABLE_MASK                                           0x00000008L
 #define DCCG_GATE_DISABLE_CNTL4__PHYE_REFCLK_ROOT_GATE_DISABLE_MASK                                           0x00000010L
 #define DCCG_GATE_DISABLE_CNTL4__HDMICHARCLK0_ROOT_GATE_DISABLE_MASK                                          0x00020000L
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK0_GATE_DISABLE_MASK                                                0x00800000L
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK1_GATE_DISABLE_MASK                                                0x01000000L
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK2_GATE_DISABLE_MASK                                                0x02000000L
+#define DCCG_GATE_DISABLE_CNTL4__DPIASYMCLK3_GATE_DISABLE_MASK                                                0x04000000L
 #define DPSTREAMCLK_CNTL__DPSTREAMCLK0_SRC_SEL__SHIFT                                                         0x0
 #define DPSTREAMCLK_CNTL__DPSTREAMCLK0_EN__SHIFT                                                              0x3
 #define DPSTREAMCLK_CNTL__DPSTREAMCLK1_SRC_SEL__SHIFT                                                         0x4
-- 
2.42.0


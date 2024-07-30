Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABD7C3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4443110E4C7;
	Tue, 30 Jul 2024 07:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXG7biin";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD03D10E4C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1SWi1axJYBCyXqnrVfZPWcBhzeQOgmFnq//i/uH+ycmbFPpwftsE0A6SqnB9GNPqZySf+49z7ixmTAAWgIUTjCzJC/ZscJW81MIW5ajDbyjtfJRfZh3xi4MZZ11AqUjKn6ACoyN805qpl3gRDKmGg8guTIgUWXLPThIgafvl2TK8UacPe/OOEcTxl7hluzhcl9nVPBK9rsBhd9wH56boRnoEr2izXuqhPx2f4NdlZlbIV6CFfRQg+nED+ennHPaVE58ebFObipJFO+DixNs42NmAA8Zrh4GWshO5BEiYadDU+iiQT3K1rUdHBGrWv3Dd/zTBljn57Sog/dz3gcyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrAoLg4bpo41duc0H9LPTDLmwF8pVMXeoIb/TNmt4YY=;
 b=yV8mZH1u5XNRArpr8lPuMeUlo7nabK5ao0JPGAHijof7V1pS2fX5KTyiEbsjUBmOoavAmox81v9pcTcFS2A+V2AaoGChimTnjrrMosO5E8Bxg+4cwkydJlsgEDMenugcSixpWx9AvPbtTxYr4xISIvuwskkadpcnkSl6T8wpf2d72euQDAMCEgR7Qd7vM2UtlbkJXMQ9xZbBZmvpKdRPyqjki/NZ0UJIFplcxT3dUwvwmWFyoTMxIwg++ISYd2sys6O0bjj+/akuZhrGjxe80XxOMSRzEzMfXl3/QnCCLfePwFQuV/VxrNqjYk8WHStvx7Y2NeHqzEtxqKtPVeH16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrAoLg4bpo41duc0H9LPTDLmwF8pVMXeoIb/TNmt4YY=;
 b=lXG7biin5OqSPhlEV7nnd4PBMIckPfLdK8dy5GuN3R8RvvVR9u6P6VN3aQSjL6U4FapsJx2ypqqxniwDBXKjuyoXn8ILEQjcBH3HaMWWx7iT5IJjDxi9gjT21NAh+2iDbmQnOc4TgKMWbWo/0F+BeamsGWn1baTQrCiAB8gp20c=
Received: from MN2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:c0::16)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:21:33 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::27) by MN2PR05CA0003.outlook.office365.com
 (2603:10b6:208:c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 07:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:21:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:21:31 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:21:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>
Subject: [PATCH 15/22] drm/amd/display: Add clock control callbacks
Date: Tue, 30 Jul 2024 15:18:36 +0800
Message-ID: <20240730071843.880430-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 883231d1-086f-4241-a085-08dcb0683d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I6EkzYdvD0s2kPTMtJmqfq+jgvWK0u2cWWWIRfoKRjNIK+TQoR58W0t24Q0S?=
 =?us-ascii?Q?Avdl5elzoz8seKmSMHIbFHjnilPmskENAp1+JTFf5wgJUF5Q6GKcrVwIanvz?=
 =?us-ascii?Q?2S/89m2xsEkELfghiJJMBiaVDPStB8S/ZIF9cBfMGXvKwadxO7rbjYPhmOLE?=
 =?us-ascii?Q?IGyCGauGnryYYrYs3RxshibCxJ8i+jS+7fAOghB0HlLbWYzN0YDZ3uxU/tHD?=
 =?us-ascii?Q?8j9vdBSIIDQ5jV5OWnED4HjWCOHO8Vgd5sK7nu+NKx/qgn9rjv012dtNFnZ9?=
 =?us-ascii?Q?8TUKHXXlHgyvszEWX98nNUA2ggpJSRaRg+0HoKLey4fHwgi9ecLAME1T7c8O?=
 =?us-ascii?Q?0jC5goqc9aV8ApQTLeWX83YuM0Y9g/y/5uPsYTF24n+nitT02zFZF6q5/SD8?=
 =?us-ascii?Q?JQcG+qPMwbgJhL47bbtOGquCRTSj68HVdQuy3wheng4sgn4tFighVqsJ+zaw?=
 =?us-ascii?Q?gGYgd3gVoE1BltwYePZ79sgMfn50csLW63lOwCSe59ullaI+xzsVHuGCGTLa?=
 =?us-ascii?Q?SsUEnJt1C8o3gb6VEqEJsUhTz5/Lfbt8sxZ8C37pThhwsm1ox6vVdWyFs95t?=
 =?us-ascii?Q?wcJTH4E4gqSUzkRRQHWkeABo5uCeTeWtW2jXhS4BjTdXyqz8mIXgpNbVoyOX?=
 =?us-ascii?Q?xZfi0uzvCpRjhyTkVoZ8SAE1gIW3LOIQE317yi2pfFr71lapZ2kTWrtnScRD?=
 =?us-ascii?Q?vL9M2Ybmbizb3Fnm162+BWO8QUI5SWsPEoq2UReCdUTNTv86/0F8n6XnStG9?=
 =?us-ascii?Q?noJqDerf78iXavMtAo323h1aJcDof+FjLyA8pqb/jnNmxTBIU0mgrcl7Xapg?=
 =?us-ascii?Q?NqlYQjYcT4q6qTZrQBr3rcOdhOszJB9ZUH+uPXCIyTb8OpVa4KQtzC2aRjsP?=
 =?us-ascii?Q?lkQA+ZvS3SnUbmEH/q4gZ57FI+FXwi5AgTnBGzXol7TbUAKq9i9/iPAkL5//?=
 =?us-ascii?Q?e/6oyCxRPYWw3ECzIg+dAfLr4RjFIU+Jd7WP+f54TxvNOpzyrWX3d3Vpnq7M?=
 =?us-ascii?Q?/Y40++Cc+I86ujld4aLftLiqUsMpPDkqR9kx2axf37VK1f2PTVwXofcsshRY?=
 =?us-ascii?Q?lmnkqsuleVdOhZR7KoGE7PBuU3vkSljSrMJUZXxqgnmPRoU0yoQt9Ply0Zn5?=
 =?us-ascii?Q?wNlXAkmDdNsX8y1yoU1/wO1h83q3sHFCRgJ/uegofUW6YORiExzEkAfjxClC?=
 =?us-ascii?Q?g9njoLvfYTQiQVM9rJn4MPngGq3Ez5CMM8/DFLh5Mr8V2QQ/26t2QrdvfxNC?=
 =?us-ascii?Q?ucjq2d3sxA7L5evQkovFyQpZ4oiRpAw938zs0USfYQMlSg0DKXv56Gazb5y+?=
 =?us-ascii?Q?45gdKIH0Hxy6hasz0dvnYXQQVFqg2OHGjDuSOrI+gHKnSAEzqZzbtB0PHaYx?=
 =?us-ascii?Q?nlB0AA2RmD6T0Ld8Hg6ReynNtm84J4+6kCWMH0IQ4bVQVIRby5pP5mxJhn8K?=
 =?us-ascii?Q?ySd9fiW2sPK0mGHNY1Ll3cCMROzXvOzV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:21:33.1055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883231d1-086f-4241-a085-08dcb0683d52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[why & how]
Add clock source selection an control functions based on spec

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 281 ++++++++++++++++--
 1 file changed, 252 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 13e3d64ee2f0..b4f441c405bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -41,13 +41,22 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
-enum physymclk_fe_source {
-	PHYSYMCLK_FE_SYMCLK_A = 0,	// Select functional clock from backend symclk A
-	PHYSYMCLK_FE_SYMCLK_B,
-	PHYSYMCLK_FE_SYMCLK_C,
-	PHYSYMCLK_FE_SYMCLK_D,
-	PHYSYMCLK_FE_SYMCLK_E,
-	PHYSYMCLK_FE_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+enum symclk_fe_source {
+	SYMCLK_FE_SYMCLK_A = 0,	// Select functional clock from backend symclk A
+	SYMCLK_FE_SYMCLK_B,
+	SYMCLK_FE_SYMCLK_C,
+	SYMCLK_FE_SYMCLK_D,
+	SYMCLK_FE_SYMCLK_E,
+	SYMCLK_FE_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
+};
+
+enum symclk_be_source {
+	SYMCLK_BE_PHYCLK = 0,	// Select phy clk when sym_clk_enable = 1
+	SYMCLK_BE_DPIACLK_810 = 4,
+	SYMCLK_BE_DPIACLK_162 = 5,
+	SYMCLK_BE_DPIACLK_540 = 6,
+	SYMCLK_BE_DPIACLK_270 = 7,
+	SYMCLK_BE_REFCLK = 0xFF,	// Arbitrary value to pass refclk selection in software
 };
 
 enum physymclk_source {
@@ -252,7 +261,7 @@ static void dccg35_set_physymclk_rcg(
 	}
 }
 
-static void dccg35_set_physymclk_fe_rcg(
+static void dccg35_set_symclk_fe_rcg(
 		struct dccg *dccg,
 		int inst,
 		bool enable)
@@ -289,6 +298,45 @@ static void dccg35_set_physymclk_fe_rcg(
 	}
 }
 
+static void dccg35_set_symclk_be_rcg(
+	struct dccg *dccg,
+	int inst,
+	bool enable)
+{
+
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	/* TBD add symclk_be in rcg control bits */
+	if (!dccg->ctx->dc->debug.root_clock_optimization.bits.physymclk)
+		return;
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				   SYMCLKA_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 1:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				   SYMCLKB_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 2:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				   SYMCLKC_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 3:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				   SYMCLKD_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	case 4:
+		REG_UPDATE(DCCG_GATE_DISABLE_CNTL5,
+				   SYMCLKE_ROOT_GATE_DISABLE, enable ? 0 : 1);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+}
+
 static void dccg35_set_dtbclk_p_rcg(struct dccg *dccg, int inst, bool enable)
 {
 
@@ -665,6 +713,42 @@ static void dccg35_set_physymclk_src_new(
 	}
 }
 
+static void dccg35_set_symclk_be_src_new(
+	struct dccg *dccg,
+	enum symclk_be_source src,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
+					 SYMCLKA_CLOCK_ENABLE, (src == SYMCLK_BE_REFCLK) ? 0 : 1,
+					 SYMCLKA_SRC_SEL, (src == SYMCLK_BE_REFCLK) ? 0 : src);
+		break;
+	case 1:
+		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
+					 SYMCLKB_CLOCK_ENABLE, (src == SYMCLK_BE_REFCLK) ? 0 : 1,
+					 SYMCLKB_SRC_SEL, (src == SYMCLK_BE_REFCLK) ? 0 : src);
+		break;
+	case 2:
+		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
+					 SYMCLKC_CLOCK_ENABLE, (src == SYMCLK_BE_REFCLK) ? 0 : 1,
+					 SYMCLKC_SRC_SEL, (src == SYMCLK_BE_REFCLK) ? 0 : src);
+		break;
+	case 3:
+		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
+					 SYMCLKD_CLOCK_ENABLE, (src == SYMCLK_BE_REFCLK) ? 0 : 1,
+					 SYMCLKD_SRC_SEL, (src == SYMCLK_BE_REFCLK) ? 0 : src);
+		break;
+	case 4:
+		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
+					 SYMCLKE_CLOCK_ENABLE, (src == SYMCLK_BE_REFCLK) ? 0 : 1,
+					 SYMCLKE_SRC_SEL, (src == SYMCLK_BE_REFCLK) ? 0 : src);
+		break;
+	}
+}
+
 static int dccg35_is_symclk_fe_src_functional_be(struct dccg *dccg,
 												 int symclk_fe_inst,
 												 int symclk_be_inst)
@@ -699,35 +783,35 @@ static int dccg35_is_symclk_fe_src_functional_be(struct dccg *dccg,
 	return 0;
 }
 
-static void dccg35_set_symclk_fe_src_new(struct dccg *dccg, enum physymclk_fe_source src, int inst)
+static void dccg35_set_symclk_fe_src_new(struct dccg *dccg, enum symclk_fe_source src, int inst)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
 	switch (inst) {
 	case 0:
 		REG_UPDATE_2(SYMCLKA_CLOCK_ENABLE,
-					 SYMCLKA_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
-					 SYMCLKA_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+					 SYMCLKA_FE_EN, (src == SYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKA_FE_SRC_SEL, (src == SYMCLK_FE_REFCLK) ? 0 : src);
 		break;
 	case 1:
 		REG_UPDATE_2(SYMCLKB_CLOCK_ENABLE,
-					 SYMCLKB_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
-					 SYMCLKB_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+					 SYMCLKB_FE_EN, (src == SYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKB_FE_SRC_SEL, (src == SYMCLK_FE_REFCLK) ? 0 : src);
 		break;
 	case 2:
 		REG_UPDATE_2(SYMCLKC_CLOCK_ENABLE,
-					 SYMCLKC_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
-					 SYMCLKC_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+					 SYMCLKC_FE_EN, (src == SYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKC_FE_SRC_SEL, (src == SYMCLK_FE_REFCLK) ? 0 : src);
 		break;
 	case 3:
 		REG_UPDATE_2(SYMCLKD_CLOCK_ENABLE,
-					 SYMCLKD_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
-					 SYMCLKD_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+					 SYMCLKD_FE_EN, (src == SYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKD_FE_SRC_SEL, (src == SYMCLK_FE_REFCLK) ? 0 : src);
 		break;
 	case 4:
 		REG_UPDATE_2(SYMCLKE_CLOCK_ENABLE,
-					 SYMCLKE_FE_EN, (src == PHYSYMCLK_FE_REFCLK) ? 0 : 1,
-					 SYMCLKE_FE_SRC_SEL, (src == PHYSYMCLK_FE_REFCLK) ? 0 : src);
+					 SYMCLKE_FE_EN, (src == SYMCLK_FE_REFCLK) ? 0 : 1,
+					 SYMCLKE_FE_SRC_SEL, (src == SYMCLK_FE_REFCLK) ? 0 : src);
 		break;
 	}
 }
@@ -804,9 +888,9 @@ static uint32_t dccg35_is_symclk32_se_rcg(struct dccg *dccg, int inst)
 static void dccg35_enable_symclk_fe_new(
 	struct dccg *dccg,
 	int inst,
-	enum physymclk_fe_source src)
+	enum symclk_fe_source src)
 {
-	dccg35_set_physymclk_fe_rcg(dccg, inst, false);
+	dccg35_set_symclk_fe_rcg(dccg, inst, false);
 	dccg35_set_symclk_fe_src_new(dccg, src, inst);
 }
 
@@ -814,17 +898,17 @@ static void dccg35_disable_symclk_fe_new(
 	struct dccg *dccg,
 	int inst)
 {
-	dccg35_set_symclk_fe_src_new(dccg, PHYSYMCLK_FE_REFCLK, inst);
-	dccg35_set_physymclk_fe_rcg(dccg, inst, true);
+	dccg35_set_symclk_fe_src_new(dccg, SYMCLK_FE_REFCLK, inst);
+	dccg35_set_symclk_fe_rcg(dccg, inst, true);
 }
 
 static void dccg35_enable_symclk_be_new(
 	struct dccg *dccg,
 	int inst,
-	enum physymclk_source src)
+	enum symclk_be_source src)
 {
-	dccg35_set_physymclk_rcg(dccg, inst, false);
-	dccg35_set_physymclk_src_new(dccg, inst, src);
+	dccg35_set_symclk_be_rcg(dccg, inst, false);
+	dccg35_set_symclk_be_src_new(dccg, inst, src);
 }
 
 static void dccg35_disable_symclk_be_new(
@@ -834,7 +918,7 @@ static void dccg35_disable_symclk_be_new(
 	int i;
 
 	/* Switch from functional clock to refclock */
-	dccg35_set_physymclk_src_new(dccg, inst, PHYSYMCLK_REFCLK);
+	dccg35_set_symclk_be_src_new(dccg, inst, SYMCLK_BE_REFCLK);
 
 	/* Check if any other SE connected LE and disable them */
 	for (i = 0; i < 4; i++) {
@@ -845,7 +929,7 @@ static void dccg35_disable_symclk_be_new(
 		}
 	}
 	/* Safe to RCG SYMCLK*/
-	dccg35_set_physymclk_rcg(dccg, inst, true);
+	dccg35_set_symclk_be_rcg(dccg, inst, true);
 }
 
 static void dccg35_enable_symclk32_se_new(
@@ -2041,6 +2125,132 @@ static void dccg35_dpp_root_clock_control_cb(
 		dccg35_disable_dpp_clk_new(dccg, dpp_inst);
 }
 
+static void dccg35_enable_symclk32_se_cb(
+	struct dccg *dccg,
+	int inst,
+	enum phyd32clk_clock_source phyd32clk)
+{
+	dccg35_enable_symclk32_se_new(dccg, inst, (enum symclk32_se_clk_source)phyd32clk);
+}
+
+static void dccg35_disable_symclk32_se_cb(struct dccg *dccg, int inst)
+{
+	dccg35_disable_symclk32_se_new(dccg, inst);
+}
+
+static void dccg35_disable_symclk32_le_cb(struct dccg *dccg, int inst)
+{
+	dccg35_disable_symclk32_le_new(dccg, inst);
+}
+
+static void dccg35_set_symclk32_le_root_clock_gating(
+	struct dccg *dccg,
+	int inst,
+	bool power_on)
+{
+	/* power_on set indicates we need to ungate
+	 * Currently called from optimize_bandwidth and prepare_bandwidth calls
+	 * Since clock source is not passed restore to refclock on ungate
+	 * Redundant as gating when enabled is acheived through disable_symclk32_le
+	 */
+	if (power_on)
+		dccg35_enable_symclk32_le_new(dccg, inst, SYMCLK32_LE_REFCLK);
+	else
+		dccg35_disable_symclk32_le_new(dccg, inst);
+}
+
+static void dccg35_set_dtbclk_p_src_cb(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t inst)
+{
+	if (src == DTBCLK0)
+		dccg35_enable_dtbclk_p_new(dccg, DTBCLK_DTBCLK0, inst);
+	else
+		dccg35_disable_dtbclk_p_new(dccg, inst);
+}
+
+static void dccg35_set_dtbclk_dto_cb(
+		struct dccg *dccg,
+		const struct dtbclk_dto_params *params)
+{
+	/* set_dtbclk_p_src typ called earlier to switch to DTBCLK
+	 * if params->ref_dtbclk_khz and req_dtbclk_khz are 0 switch to ref-clock
+	 */
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	/* DTO Output Rate / Pixel Rate = 1/4 */
+	int req_dtbclk_khz = params->pixclk_khz / 4;
+
+	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
+		uint32_t modulo, phase;
+
+		dccg35_enable_dtbclk_p_new(dccg, DTBCLK_DTBCLK0, params->otg_inst);
+
+		// phase / modulo = dtbclk / dtbclk ref
+		modulo = params->ref_dtbclk_khz * 1000;
+		phase = req_dtbclk_khz * 1000;
+
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], modulo);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], phase);
+
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 1);
+
+		REG_WAIT(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLKDTO_ENABLE_STATUS[params->otg_inst], 1,
+				1, 100);
+
+		/* program OTG_PIXEL_RATE_DIV for DIVK1 and DIVK2 fields */
+		dccg35_set_pixel_rate_div(dccg, params->otg_inst, PIXEL_RATE_DIV_BY_1, PIXEL_RATE_DIV_BY_1);
+
+		/* The recommended programming sequence to enable DTBCLK DTO to generate
+		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
+		 * be set only after DTO is enabled
+		 */
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				PIPE_DTO_SRC_SEL[params->otg_inst], 2);
+	} else {
+		dccg35_disable_dtbclk_p_new(dccg, params->otg_inst);
+
+		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+					 DTBCLK_DTO_ENABLE[params->otg_inst], 0,
+					 PIPE_DTO_SRC_SEL[params->otg_inst], params->is_hdmi ? 0 : 1);
+
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
+	}
+}
+
+static void dccg35_disable_dscclk_cb(struct dccg *dccg,
+									 int inst)
+{
+	dccg35_disable_dscclk_new(dccg, inst);
+}
+
+static void dccg35_enable_dscclk_cb(struct dccg *dccg, int inst)
+{
+	dccg35_enable_dscclk_new(dccg, inst, DSC_DTO_TUNED_CK_GPU_DISCLK_3);
+}
+
+static void dccg35_enable_symclk_se_cb(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst)
+{
+	/* Switch to functional clock if already not selected */
+	dccg35_enable_symclk_be_new(dccg, SYMCLK_BE_PHYCLK, link_enc_inst);
+
+	dccg35_enable_symclk_fe_new(dccg, stream_enc_inst, (enum symclk_fe_source) link_enc_inst);
+
+}
+
+static void dccg35_disable_symclk_se_cb(
+			struct dccg *dccg,
+			uint32_t stream_enc_inst,
+			uint32_t link_enc_inst)
+{
+	dccg35_disable_symclk_fe_new(dccg, stream_enc_inst);
+
+	/* DMU PHY sequence switches SYMCLK_BE (link_enc_inst) to ref clock once PHY is turned off */
+}
+
 static const struct dccg_funcs dccg35_funcs = {
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
@@ -2070,6 +2280,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
 	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
+
 };
 
 struct dccg *dccg35_create(
@@ -2091,7 +2302,7 @@ struct dccg *dccg35_create(
 	(void)&dccg35_set_symclk32_se_rcg;
 	(void)&dccg35_set_symclk32_le_rcg;
 	(void)&dccg35_set_physymclk_rcg;
-	(void)&dccg35_set_physymclk_fe_rcg;
+	(void)&dccg35_set_symclk_fe_rcg;
 	(void)&dccg35_set_dtbclk_p_rcg;
 	(void)&dccg35_set_dppclk_rcg;
 	(void)&dccg35_set_dpstreamclk_rcg;
@@ -2129,6 +2340,18 @@ struct dccg *dccg35_create(
 	(void)&dccg35_set_dpstreamclk_root_clock_gating_cb;
 	(void)&dccg35_update_dpp_dto_cb;
 	(void)&dccg35_dpp_root_clock_control_cb;
+	(void)&dccg35_disable_symclk_se_cb;
+	(void)&dccg35_enable_symclk_se_cb;
+	(void)&dccg35_enable_dscclk_cb;
+	(void)&dccg35_disable_dscclk_cb;
+	(void)&dccg35_set_dtbclk_dto_cb;
+	(void)&dccg35_set_dtbclk_p_src_cb;
+	(void)&dccg35_set_symclk32_le_root_clock_gating;
+	(void)&dccg35_disable_symclk32_le_cb;
+	(void)&dccg35_set_symclk_be_src_new;
+	(void)&dccg35_set_symclk_be_rcg;
+	(void)&dccg35_enable_symclk32_se_cb;
+	(void)&dccg35_disable_symclk32_se_cb;
 
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
-- 
2.37.3


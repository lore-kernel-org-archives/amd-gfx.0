Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8C4C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450EC10E4C4;
	Thu,  4 Jan 2024 15:53:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE1D10E4C7
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8GwNw6ofXOj94ScW4aqbh0Zl+b1ha/p2aWzI9pZlB4BK8M7ob/+JrtJG9UT3nfHU1/tyrLitW5pNno5uzG754FgogV416mHSbO7J21ExNbaPmJMod//CM/im26yvOzflcP/ol4gnhEO3LMWXZ++bQNVWSm2cSwVAt9hL5T56hledfRhduUjGk2UiijqaToL2vV7GQscUgDIgL8HKzsWVW6MhNjaEuI+EAS11qLS5pFxIoQH+62OsxMEWLrp4P0/QMJEZmwQHn6lMFY7tgQmPYQNUlwszFoCelH4a1yzqVI7iF/d1QDt5UHynxKNj6LOiSGF6e/s5IeVNaEzIzYfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp9A8sWgO3yVveg/FwpVsE2vI/i5EyL4FxtRJLqmbCI=;
 b=UUBDi8pllulkZBS/qWTxP1FfDrSz+FBa5lqPrbFTewcizNhYm0ININ9zSHZUB/IRI2EweoRpZDsf4F0jsLkyC4WeQXZC1quMvbBJgt4pHXkaGr1L94liiMQd4BIfxYa0wkSzFtiuQOEneu1h4L2wlhPPIu39YK10hU3aKS+sLPgejuuqVK2+gUU+IkihcNjZZcCVnh45elHeKhGHmKz2gAm1Mz0rqk+5nutywYlgT3JtQOWTMmKpPLjUwv8p5MisyQPSciKtQkxpST8IG+//qdIFdUcllf9pENmUQnAFCkkFL4J3t4WTL+UPzOh8yP2jA+FmNKnpbWtADESprPsSQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp9A8sWgO3yVveg/FwpVsE2vI/i5EyL4FxtRJLqmbCI=;
 b=nihPb5fTM76xBqF1iD7gINEkmwqIp31NPvOPKShJnzHUeEYy3LfM7KoVQjInt5NmMXGO86k7SaB0WmnhnynXma64IP7H3Lx26/UeFtV5CTP9hUZauJ92J0kSN+ao4uFIaeqx01No3l4tmTMN8lAiEZRU0V1nUomGA4VWVUbcNBE=
Received: from PH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::32)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:53:21 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::f1) by PH0P220CA0019.outlook.office365.com
 (2603:10b6:510:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:15 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/10] drm/amd/display: Disconnect phantom pipe OPP from OPTC
 being disabled
Date: Thu, 4 Jan 2024 08:50:59 -0700
Message-ID: <20240104155238.454117-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a7ce54-934b-4eb5-961d-08dc0d3d466f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4rI6jLamWE3nOqduV/OzNXSefhuWfVNL9dCYK6J+fJpB3hEkC85jEA7VEQ1NmtUBZRF6KSC4NX1PiVwPTZiXUEcEGeljPAyR1RmC5tuQKaw21rwnts+mrywlk+PAGlizvTEmV+om5iTdfPDcZawqrjeWjclko1RwLt8DOEOUuUjqFPlLlvep24JEEE/64rIRzvjRm1eibvkNSbdttDEJM7cxyHKCi0TwCi+qjFW9BFu2Wq1/3IRSuEzgap4X4TLxbWq6hjDd0IR5rbh5q7xxYCOIBzx4Mt+FWol6B8CgaRmsm11CCGhNexP17Rw4gJ8H5OJmdJI3lgZluc/eNcfiIdG2zJGiCpiSlIhiQbLOyyQFBCHvcgv6QTKmL1Wz8dTaUdmf09mqO4KdL8nzf3lQLuPhivPUbc3O26wlUDcPZXqe11q8xeGXwGeTyvbG7tZnLcKPJMKjHKenUPbFt4JuGxCXjzND9t/Ys1bfxDI6vGehf1VasmCvDs/V8eiOJ4v+2VJLTzuDIPX3fcjywSWgA0ZO9KLl81lxaVP/Q8Rn0/bmIoXgxOd3NVFlbv+BTjv3ONDF1UIXwVpSfyc59NU98+kI26u854eIofmgpLG+o2Y1vZDNX4c7h7lFEakofdL9MGNHeKdt/M9SOylv5ahlcOh8VdpGu+TFKJr+98Guc5GH92grzDu9VDIldsisfAnZfrHVziu6kaaRwhCnISaTXRU0d8tVD94TPeAjVU7aSs2JWpmW8iapfxFTuixL+k/t+KUVIOfhqzlost72/DkFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(46966006)(40470700004)(36840700001)(336012)(16526019)(426003)(2616005)(47076005)(1076003)(83380400001)(26005)(5660300002)(41300700001)(86362001)(40460700003)(36756003)(40480700001)(82740400003)(36860700001)(2906002)(8936002)(316002)(54906003)(70206006)(8676002)(70586007)(4326008)(6916009)(478600001)(6666004)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:20.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a7ce54-934b-4eb5-961d-08dc0d3d466f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 jerry.zuo@amd.com, Sunpeng.Li@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
If an OPP is used for a different OPTC without first being disconnected
from the previous OPTC, unexpected behaviour can occur. This also
applies to phantom pipes, which is what the current logic missed.

[How]
Disconnect OPPs from OPTC for phantom pipes before disabling OTG master.

Also move the disconnection to before the OTG master disable, since the
register is double buffered.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 19 +++++++++++++------
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 12 ++++++------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 91ea0d4da06a..1788eb29474b 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -166,12 +166,6 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	/* disable otg request until end of the first line
-	 * in the vertical blank region
-	 */
-	REG_UPDATE(OTG_CONTROL,
-			OTG_MASTER_EN, 0);
-
 	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
 			OPTC_SEG0_SRC_SEL, 0xf,
 			OPTC_SEG1_SRC_SEL, 0xf,
@@ -179,6 +173,12 @@ static bool optc32_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	/* disable otg request until end of the first line
+	 * in the vertical blank region
+	 */
+	REG_UPDATE(OTG_CONTROL,
+			OTG_MASTER_EN, 0);
+
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 0);
 
@@ -205,6 +205,13 @@ static void optc32_disable_phantom_otg(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
+	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
+			OPTC_SEG0_SRC_SEL, 0xf,
+			OPTC_SEG1_SRC_SEL, 0xf,
+			OPTC_SEG2_SRC_SEL, 0xf,
+			OPTC_SEG3_SRC_SEL, 0xf,
+			OPTC_NUM_OF_INPUT_SEGMENT, 0);
+
 	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 08a59cf449ca..3d6c1b2c2b4d 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -138,12 +138,6 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 
-	/* disable otg request until end of the first line
-	 * in the vertical blank region
-	 */
-	REG_UPDATE(OTG_CONTROL,
-			OTG_MASTER_EN, 0);
-
 	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
 			OPTC_SEG0_SRC_SEL, 0xf,
 			OPTC_SEG1_SRC_SEL, 0xf,
@@ -151,6 +145,12 @@ static bool optc35_disable_crtc(struct timing_generator *optc)
 			OPTC_SEG3_SRC_SEL, 0xf,
 			OPTC_NUM_OF_INPUT_SEGMENT, 0);
 
+	/* disable otg request until end of the first line
+	 * in the vertical blank region
+	 */
+	REG_UPDATE(OTG_CONTROL,
+			OTG_MASTER_EN, 0);
+
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 0);
 
-- 
2.43.0


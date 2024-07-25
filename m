Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37683C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E084710E8AA;
	Thu, 25 Jul 2024 18:04:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yIcVbrWU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F6E10E8AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2CC4LCzarpjpWbbOiqaFZr7FNzUu78GW3oUvDFTDK9Ql9G4ejBO6hSpNHckRkDOvUEPHej3igPITyLQq3z++WLwUWIYZF0RcLkZqTRtfF4oFZeIFESIFDC4/nfIeLmNG5QZKpuqYJ8ntJN9VQ38vzY3elBnleICKpX5JVPY5PHZopeh2pdBbjMrvd85Kl27v5GmaEgMOaNFyeOZj+MJRibBtJY8FL0uXITUKVPll/1YVl+lYJo8VwDmc8tyeJqkj0lZWxLoww1ogzPa9hLzsIVX740ha50RCnKBbkpzMtaqpthfWdfrFWUAs38LPkriuxa1E0iL3IpsjBxhYvtC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwrxaokk2zo96jE2yFqsMppxQyWUype7uYO95DZkXUw=;
 b=Ydyjng8X7h+So+/UzgEeOLRNpLw2/bD5xXZDarP1evLOZcFNMAlWEOkMs92UGSRgT1P9iO6GcRIKRvStWJjVSLvhcQYgsQvkxNV8mVZ8Z3geiO4CUzYsUNcAHz33wb50D6iuUiGti//LUpwzcHBUkWzRwyJ3iAsi6aVZUU1P+hApI29Fulx0wop9O0uaZQ68cJEGzTHTnkLtsNoCLIWcARyRrOe0adn2HA2KDJC5n9XujmwWBwwtRsvMtaidQjqm0m0c4UivwL9j/S1VtEAwOymh2556w9jb9Rv5NseXfeE06M6U84rKACqZyjMKbNwZvM14jjCQd7XheH0KPQ8Mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwrxaokk2zo96jE2yFqsMppxQyWUype7uYO95DZkXUw=;
 b=yIcVbrWUu/miLFwMh6KG6i76qhLZsj9kOjs2PmTJ6aAXjxSVzgeoceMTqJtwIso7ZXSl1ahTaQHRt531hBU+6SgQ/UmvQ+LR9xUMb/EQsOzKF23psT8CEn4FO1eJHGLqRSTUP0ZhigczPP+0WKLPRta9io8nY1dVVsfj8yg+aMI=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 18:04:07 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::3c) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:04 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 18/39] drm/amd/display: Add new enable and disable functions
Date: Thu, 25 Jul 2024 12:01:02 -0600
Message-ID: <20240725180309.105968-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 0795b463-c405-4dbe-48af-08dcacd42d9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eQkHT/mRBnZExAkMUidQ86KjtgvjjXLLtkmEoEg0NvEjHfDdPTsKD8H3/b8S?=
 =?us-ascii?Q?iicPQtCVrLX/mwfJHB9PAkzY/fmYakbago7qchhaQYFKPhVEr9PctaQNqQCY?=
 =?us-ascii?Q?Eg2wK+SpnGll3ysbs/RoLSnj6t+AIsLLgzO2Lcwpb4766ZrYH/9mS2o+hp71?=
 =?us-ascii?Q?Fon0AknjwzOq9MOrdz7sMIWHiUw+aqPDmnnfkLsWi8VQbhaW295LIwj3aCHa?=
 =?us-ascii?Q?ceR5OnE2TovyPFY44Su3U0maWCmEUU6f1Rfz6QkNoCMI0yYl5AWOZDHSa5W3?=
 =?us-ascii?Q?jhFDcOnECDdKA7uir2DLg/RlGA2h7QatscAB1fIiKj+pIWuOnku1b2HQEuCu?=
 =?us-ascii?Q?dqxZTuI0Id4xfyvzW0Rsgfg6KQORrUGczBolRkrmtOxDhWkZgDYyrmM5bz7R?=
 =?us-ascii?Q?uafZImBKynjbI0xJ6HXLkTw2lTFkeo8xBcNVCv7OXLw5qkkkkerOba/qDYhb?=
 =?us-ascii?Q?atFhTeD7svnTSKUQS3Po5X8zBNFEO2mI1UVseu41Nu7Rr0u7yM2JLgWiN+fF?=
 =?us-ascii?Q?6Vluk9TkJJnfJcz+KicKo/veQ+6hF7MgHZtH/F29GedfUi5PNmwO7GsjTkZO?=
 =?us-ascii?Q?Kp5Eo/3M++8SUrGaoQGqM6Gr1rJNxIm3iHxZHtI/MbnnURs0iVcvuenKcCcz?=
 =?us-ascii?Q?qijErzjXT7kjRvZ+91EhRtvuLp9aObLeXQCLuBZGnb2rpcDU0Flcemuvxmsl?=
 =?us-ascii?Q?ovGcM9xqqH+qwqkqWcuO5OZVbl47eHrti9grWkcsMQDZDBAZcKYVciqhHGJS?=
 =?us-ascii?Q?j4S+QYhb/tSnfaMB2b6ATO+/1sX7EgzmyrAQLJsoSO5F8sYEouGOLWMIl1xl?=
 =?us-ascii?Q?DzJlpCrGzF5bfCgR7N1nU785hQ1VzqQQxHuuU1p4/7evdIGtX8/EbdaH3BDF?=
 =?us-ascii?Q?FlUiyyjiOlSjnlp9c59O58aIBgCq7EHE7FKW948Ch+sVbCwDzVyBICnsaJQI?=
 =?us-ascii?Q?nrv3dhlNz6/cCbwgRWXKNvfLYuylW2JnxOvzzByzwnoRTxVM2LMLXXF8hqD/?=
 =?us-ascii?Q?HMiX/N/ruZ3C18mQLjCCqiBvVKP0BsZCE4xxkyJL+RyIQSUONh8qYBAEJLyM?=
 =?us-ascii?Q?bIjz88f6fGoEcVPYtmuKjz+J6eibvZAD01Ys/LcvhcdG4MorpCFtXPrj9kXY?=
 =?us-ascii?Q?sLnwww1Ps/0rrj8AX91si+TPf/QIMv+0ZQJcgvasRXKAiRtlXnFGXznm+Fwb?=
 =?us-ascii?Q?YNAu9UvWbC8DgXE1TEiyXM9TrmPT0MzmZY7TTt4D2R2RkYAhSXT6bn4kqT0M?=
 =?us-ascii?Q?y9wr+a3owLYeCP2TiWgx5bwxFqQlQ4XIxMDvMb36NsmRxlNZSvTmJv/Emvle?=
 =?us-ascii?Q?zET2Y2lx8ZlBFQw3HeWecIp6220XYqO/SOp70KIepK5gC9qA/l6uiHzU7Qmn?=
 =?us-ascii?Q?bQACef3TJe7h3DhCpluCJOyvmqel/2B3bXlmT98kNUwadN1YI9MCcw/wpTZH?=
 =?us-ascii?Q?Ivd+AFU/1v/hu+tR3V77plEYwZFL+OBe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:07.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0795b463-c405-4dbe-48af-08dcacd42d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386
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

Add new enable and disable functions based on DCCG spec.

Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 212 ++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index b698b773338a..7d88b0ae241c 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -732,6 +732,206 @@ static void dccg35_set_symclk_fe_src_new(struct dccg *dccg, enum physymclk_fe_so
 	}
 }
 
+static uint32_t dccg35_is_fe_rcg(struct dccg *dccg, int inst)
+{
+	uint32_t enable = 0;
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_GET(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKA_FE_ROOT_GATE_DISABLE, &enable);
+		break;
+	case 1:
+		REG_GET(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKB_FE_ROOT_GATE_DISABLE, &enable);
+		break;
+	case 2:
+		REG_GET(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKC_FE_ROOT_GATE_DISABLE, &enable);
+		break;
+	case 3:
+		REG_GET(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKD_FE_ROOT_GATE_DISABLE, &enable);
+		break;
+	case 4:
+		REG_GET(DCCG_GATE_DISABLE_CNTL5,
+				SYMCLKE_FE_ROOT_GATE_DISABLE, &enable);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+	return enable;
+}
+
+static uint32_t dccg35_is_symclk32_se_rcg(struct dccg *dccg, int inst)
+{
+	uint32_t disable_l1 = 0;
+	uint32_t disable_l2 = 0;
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	switch (inst) {
+	case 0:
+		REG_GET_2(DCCG_GATE_DISABLE_CNTL3,
+				  SYMCLK32_SE0_GATE_DISABLE, &disable_l1,
+				  SYMCLK32_ROOT_SE0_GATE_DISABLE, &disable_l2);
+		break;
+	case 1:
+		REG_GET_2(DCCG_GATE_DISABLE_CNTL3,
+				  SYMCLK32_SE1_GATE_DISABLE, &disable_l1,
+				  SYMCLK32_ROOT_SE1_GATE_DISABLE, &disable_l2);
+		break;
+	case 2:
+		REG_GET_2(DCCG_GATE_DISABLE_CNTL3,
+				  SYMCLK32_SE2_GATE_DISABLE, &disable_l1,
+				  SYMCLK32_ROOT_SE2_GATE_DISABLE, &disable_l2);
+		break;
+	case 3:
+		REG_GET_2(DCCG_GATE_DISABLE_CNTL3,
+				  SYMCLK32_SE3_GATE_DISABLE, &disable_l1,
+				  SYMCLK32_ROOT_SE3_GATE_DISABLE, &disable_l2);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		return 0;
+	}
+
+	/* return true if either block level or DCCG level gating is active */
+	return (disable_l1 | disable_l2);
+}
+
+static void dccg35_enable_symclk_fe_new(
+	struct dccg *dccg,
+	int inst,
+	enum physymclk_fe_source src)
+{
+	dccg35_set_physymclk_fe_rcg(dccg, inst, false);
+	dccg35_set_symclk_fe_src_new(dccg, src, inst);
+}
+
+static void dccg35_disable_symclk_fe_new(
+	struct dccg *dccg,
+	int inst)
+{
+	dccg35_set_symclk_fe_src_new(dccg, PHYSYMCLK_FE_REFCLK, inst);
+	dccg35_set_physymclk_fe_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_symclk_be_new(
+	struct dccg *dccg,
+	int inst,
+	enum physymclk_source src)
+{
+	dccg35_set_physymclk_rcg(dccg, inst, false);
+	dccg35_set_physymclk_src_new(dccg, inst, src);
+}
+
+static void dccg35_disable_symclk_be_new(
+	struct dccg *dccg,
+	int inst)
+{
+	int i;
+
+	/* Switch from functional clock to refclock */
+	dccg35_set_physymclk_src_new(dccg, inst, PHYSYMCLK_REFCLK);
+
+	/* Check if any other SE connected LE and disable them */
+	for (i = 0; i < 4; i++) {
+		/* Make sure FE is not already in RCG */
+		if (dccg35_is_fe_rcg(dccg, i) == 0) {
+			if (dccg35_is_symclk_fe_src_functional_be(dccg, i, inst))
+				dccg35_disable_symclk_fe_new(dccg, i);
+		}
+	}
+	/* Safe to RCG SYMCLK*/
+	dccg35_set_physymclk_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_symclk32_se_new(
+	struct dccg *dccg,
+	int inst,
+	enum symclk32_se_clk_source src)
+{
+	dccg35_set_symclk32_se_rcg(dccg, inst, false);
+	dccg35_set_symclk32_se_src_new(dccg, inst, src);
+}
+
+static void dccg35_disable_symclk32_se_new(
+	struct dccg *dccg,
+	int inst)
+{
+	dccg35_set_symclk32_se_src_new(dccg, SYMCLK32_SE_REFCLK, inst);
+	dccg35_set_symclk32_se_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_symclk32_le_new(
+	struct dccg *dccg,
+	int inst,
+	enum symclk32_le_clk_source src)
+{
+	dccg35_set_symclk32_le_rcg(dccg, inst, false);
+	dccg35_set_symclk32_le_src_new(dccg, inst, src);
+}
+
+static void dccg35_disable_symclk32_le_new(
+	struct dccg *dccg,
+	int inst)
+{
+	int i;
+
+	/* Switch from functional clock to refclock */
+	dccg35_set_symclk32_le_src_new(dccg, inst, SYMCLK32_LE_REFCLK);
+
+	/* Check if any SE are connected and disable SE as well */
+	for (i = 0; i < 4; i++) {
+		/* Make sure FE is not already in RCG */
+		if (dccg35_is_symclk32_se_rcg(dccg, i) == 0) {
+			/* Disable and SE connected to this LE before RCG */
+			if (dccg35_is_symclk32_se_src_functional_le_new(dccg, i, inst))
+				dccg35_disable_symclk32_se_new(dccg, i);
+		}
+	}
+	/* Safe to RCG SYM32_LE*/
+	dccg35_set_symclk32_le_rcg(dccg, inst, true);
+}
+
+static void dccg35_enable_dpp_new(
+	struct dccg *dccg,
+	int inst,
+	enum dppclk_clock_source src)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	/* Sanitize inst before use in array de-ref */
+	if (inst < 0) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+	dccg35_set_dppclk_rcg(dccg, inst, false);
+	dcn35_set_dppclk_src_new(dccg, inst, src);
+	/* Switch DPP clock to DTO */
+	REG_SET_2(DPPCLK_DTO_PARAM[inst], 0,
+			  DPPCLK0_DTO_PHASE, 0xFF,
+			  DPPCLK0_DTO_MODULO, 0xFF);
+}
+
+static void dccg35_disable_dpp_new(
+	struct dccg *dccg,
+	int inst)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+	/* Sanitize inst before use in array de-ref */
+	if (inst < 0) {
+		BREAK_TO_DEBUGGER();
+		return;
+	}
+	dcn35_set_dppclk_src_new(dccg, inst, DPP_REFCLK);
+	REG_SET_2(DPPCLK_DTO_PARAM[inst], 0,
+			  DPPCLK0_DTO_PHASE, 0,
+			  DPPCLK0_DTO_MODULO, 1);
+	dccg35_set_dppclk_rcg(dccg, inst, true);
+}
+
 static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
@@ -1753,6 +1953,18 @@ struct dccg *dccg35_create(
 	(void)&dccg35_set_physymclk_src_new;
 	(void)&dccg35_is_symclk_fe_src_functional_be;
 	(void)&dccg35_set_symclk_fe_src_new;
+	(void)&dccg35_is_fe_rcg;
+	(void)&dccg35_is_symclk32_se_rcg;
+	(void)&dccg35_enable_symclk_fe_new;
+	(void)&dccg35_disable_symclk_fe_new;
+	(void)&dccg35_enable_symclk_be_new;
+	(void)&dccg35_disable_symclk_be_new;
+	(void)&dccg35_enable_symclk32_se_new;
+	(void)&dccg35_disable_symclk32_se_new;
+	(void)&dccg35_enable_symclk32_le_new;
+	(void)&dccg35_disable_symclk32_le_new;
+	(void)&dccg35_enable_dpp_new;
+	(void)&dccg35_disable_dpp_new;
 
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
-- 
2.43.0


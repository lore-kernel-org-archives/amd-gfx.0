Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90126C71141
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D3110E156;
	Wed, 11 Jun 2025 18:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rdmeCT0R";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D4F110E317
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6piJ9OHnLIKtIPyn+CqVTmTCg7XZbysK2mBZjlijqZ05h1EZxPVH1Zpq6goXxJGg6cVq4YGqktQmz1IMYcU16u363WkEAvTRA1mU4XVRfACGF1kd0vjhrcRdg3LsAFLlsM+HRwJgOGviP9wRWriUDK9DTG3X9eirOD8bcu3PcuRWcz+xRqacWhI3XNsCOxOPxOpQMdjum1B6KRrwB6k0lvSPe1V2nO5lyEJXE2N2z6azzfcpCMHxh68dF5MYA1zB4YT71eVjCjVRjl6ly6VhvWWdrgSDyTqlEAm3lmJRPo1EqTQkPWD4BfX5l2xrUqOIYbLc6vQLIDPca+8HZCiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XIMfDQxNwIHNO3qZFA+Z45chbZEVQmVlLj5YSwvpFo=;
 b=LuGSdHt4ylKQe2oHzxWRG6V6nR4M4zh/mdgUvjAWvRkFO9k5TO5DvUAguZZrdgrrXMBoprHydIfQt4E6pjwYU2fxKTJhyI7DRkZ9F+Epij9czV24yc+6XGpwQbq6SrNfYv2ufFMP6fkuQ/jshVwR14F0LTVevtwB7jA/omAr8IESYA71CCLqwFMjTUWzUWVKFSmiA3d2ly+YQgqV7g5ZVu6W/fW4hu7RBiCdF0q4WinALskU0Fs5csrYHMBZjq7gEwYOt9GnDeIWSUIFIQCbPEkvraDl4FgwKROSjWvtoRUhVZQinp++/Ix4qpnnHvlhT3kRIO9HU2rzleBOeqzeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XIMfDQxNwIHNO3qZFA+Z45chbZEVQmVlLj5YSwvpFo=;
 b=rdmeCT0RjdRaPlP90VikW0x79ND7ELVcG5eDDgeV1bqXX5Zk3PbmNSzbjlhKa+lTvcXYLOyavndiLINYSBge4vKZ9naDdwcUSo0zyrDrhI7kjh/PysFbHDbGnJe1XnfuXlTesUSDC4ysa+DKdGN3lIc///6F6b25CtgvjjzEukU=
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 18:41:21 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::d4) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Wed,
 11 Jun 2025 18:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:18 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ryan Seto <ryanseto@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 09/10] drm/amd/display: Removing Unused DPP Functions
Date: Wed, 11 Jun 2025 14:39:59 -0400
Message-ID: <20250611184111.517494-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f12970-3f4c-48b1-07e7-08dda9178f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HsxZY7DXjSehoscO9M7jqC2WrIciw6IQs2skhqvijmNBv7EttMN6lSMskStE?=
 =?us-ascii?Q?DHBfHiSb9Ep5u/maXE22ir6rUe6+RjEwk+xOCSH4I5+f79LydKAILUjUbBGQ?=
 =?us-ascii?Q?nAYMUBemsIM9vjsm7QHRLufBy4uzPSJT5b651QiJNC8zOqiP6nEp0WMAFGNJ?=
 =?us-ascii?Q?ivQcZa6es8HJvz4n3lNfr3fc3FYYVleDEAQRGEQQ8dmSWMKKM5hw9f01Ztuw?=
 =?us-ascii?Q?/Tr7jCtavGn+/J6NktV3aiv2gANFFZvCAbG/vezOObXS2Uj7TjEIAxeow6SJ?=
 =?us-ascii?Q?fyf1vjkX7qLuBS+ARcet/jWPFT/FuKdW1eRAsUlwdjuYI69m5Z/KklNn/cEO?=
 =?us-ascii?Q?Dt9kLp+HMEjEaL5vS6EdATQLw021TYsopMaLEKJTxaamfN+mTxCz/cfQgAE3?=
 =?us-ascii?Q?ZdULYGPdYidQBqjI5rVI0avJS4fe8pdSAgRr3mnB62vaJuBT+ONEVVHK/0Yn?=
 =?us-ascii?Q?agQ5NVorpdbLkgkijepKHX/zCipcCio47MommOzZbUv2k6QXBg6DJvmPeTl5?=
 =?us-ascii?Q?BTCd5AGO9fvnvMUAqM1Sqhu8UD+XhEBLKaMQ5X/ZOKOIBOQAlgEPfjFQ4pwM?=
 =?us-ascii?Q?8EyMni3k9pORdn7hCJoKqcoZT/IUvN4KFQfaGYKF8TDvSqTzAwy/IAqKDR3h?=
 =?us-ascii?Q?Tiuy+T1raW2zMJdNbQ3rT8GNRNIzwq9l5s61ejqloBt9WcxEkW9u+h0AumP1?=
 =?us-ascii?Q?711/FHp+eEcnAMWfITdUp9MJ2PA+Fy6e6UzPgnSlEdKpbvIISrXGlD9HXjJu?=
 =?us-ascii?Q?JBCwLPkPQCrE3tzEdcWY9S2KDhC9Xc4zlw0ddNUOrEHDlS1W9NdgB5PCijni?=
 =?us-ascii?Q?0dQ86FUnQL2Fg9w6KJi/FDp2uQ4O3HTzzQVdCaHd14eacXULadMynetWN0B+?=
 =?us-ascii?Q?w79GihpyRzY8ck3SyhLBoJvX9UDLaHsDo5tpwpCSy9pv3Pow6VgNPA9gTX4A?=
 =?us-ascii?Q?uKrXdfnFBu7Za6bU/6D+2g5RxoWzn/qbjvD4TQm+VXeBjguYp5KVkfPf+mnZ?=
 =?us-ascii?Q?OKCVUIdTGYkqe7i52EZ920HzgZCnciQoz2tW/EvGGQ+8DChZ48vwiuUTa/4t?=
 =?us-ascii?Q?SieChBTi6AATILIe8I3VL30BAQ3z5GiMfs5pcwO4hdq82tDCk2LAsOg6/R4x?=
 =?us-ascii?Q?ssYJsjVm68nIZ0DPsMOW3VwKIPLMAe4QhulRM4K/a0VwYVLUda6kc9uWWsjr?=
 =?us-ascii?Q?MjJE3f/g02kKIGM//XZclt3jmN1XV8sSgllqmKpz+B6HtSiyLed5boWXJxyn?=
 =?us-ascii?Q?mP6JqLCfO7eCjeGRle3icznpcfSfzGIzSGTHf0v7VFrU5VVhqYMB9uzFlDvc?=
 =?us-ascii?Q?qLkpNiUqi+37jXq/76ZhbbpuV4638rPJDEswfN8GaxthZMw3eNlKqY670p8c?=
 =?us-ascii?Q?Vyprj6HCQRk1zy0jZWRjwpJKJFJLhvZfl8Gko7D2tUMSI3hzejtPrQtsg1sa?=
 =?us-ascii?Q?dGQGZoU9JIRkql4p+FYRYolKSy5LUBCLE5Wvt14hhzzaGPXSdH6ICx97gBFI?=
 =?us-ascii?Q?o7xrHiLPD5q+KHyvOJJ/Ekt73TN47/tRgXh6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:21.4820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f12970-3f4c-48b1-07e7-08dda9178f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
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

From: Ryan Seto <ryanseto@amd.com>

[Why & How]
The functions in this commit are defined for dpp401 but never used.
Removing them as they are not necessary.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  2 --
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c | 24 -------------------
 3 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 97bf26fa3573..36187f890d5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -231,7 +231,7 @@ static struct dpp_funcs dcn401_dpp_funcs = {
 	.dpp_program_regamma_pwl	= NULL,
 	.dpp_set_pre_degam			= dpp3_set_pre_degam,
 	.dpp_program_input_lut		= NULL,
-	.dpp_full_bypass			= dpp401_full_bypass,
+	.dpp_full_bypass			= NULL,
 	.dpp_setup					= dpp401_dpp_setup,
 	.dpp_program_degamma_pwl	= NULL,
 	.dpp_program_cm_dealpha		= dpp3_program_cm_dealpha,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
index 702b787c640e..5a6a861402b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.h
@@ -684,8 +684,6 @@ void dpp401_dscl_set_scaler_manual_scale(
 	struct dpp *dpp_base,
 	const struct scaler_data *scl_data);
 
-void dpp401_full_bypass(struct dpp *dpp_base);
-
 void dpp401_dpp_setup(
 	struct dpp *dpp_base,
 	enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 712aff7e17f7..7aab77b58869 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -88,30 +88,6 @@ enum dscl_mode_sel {
 	DSCL_MODE_DSCL_BYPASS = 6
 };
 
-void dpp401_full_bypass(struct dpp *dpp_base)
-{
-	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
-
-	/* Input pixel format: ARGB8888 */
-	REG_SET(CNVC_SURFACE_PIXEL_FORMAT, 0,
-			CNVC_SURFACE_PIXEL_FORMAT, 0x8);
-
-	/* Zero expansion */
-	REG_SET_3(FORMAT_CONTROL, 0,
-			CNVC_BYPASS, 0,
-			FORMAT_CONTROL__ALPHA_EN, 0,
-			FORMAT_EXPANSION_MODE, 0);
-
-	/* COLOR_KEYER_CONTROL.COLOR_KEYER_EN = 0 this should be default */
-	if (dpp->tf_mask->CM_BYPASS_EN)
-		REG_SET(CM_CONTROL, 0, CM_BYPASS_EN, 1);
-	else
-		REG_SET(CM_CONTROL, 0, CM_BYPASS, 1);
-
-	/* Setting degamma bypass for now */
-	REG_SET(CM_DGAM_CONTROL, 0, CM_DGAM_LUT_MODE, 0);
-}
-
 void dpp401_set_cursor_attributes(
 	struct dpp *dpp_base,
 	struct dc_cursor_attributes *cursor_attributes)
-- 
2.49.0


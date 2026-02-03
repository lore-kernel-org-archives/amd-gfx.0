Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61886E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046C410E6B6;
	Tue,  3 Feb 2026 15:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PjdzmkHq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F9610E6B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J28xk90rOGw57UFrO58Bc+dwBfJzwLHTw5GqXLhHxWtxjSyIyvrEQNRxydhXw7tgTlbvC754j3dlIYoti7ps56BDf8516aENShu+wW4k/iquVWy7PYCITy2gVeXdIn7ePS2dFCVwURSGAKplbPariyp0xdC2iKV6xzN8ObN/IjtVyfBfjoUd8xR3fNCdB909i4ny1gCyD6c5GwFtWWR4kWBlB8aOxGHv+/I5rH3YBFW9/imIGcCVW04C0Dt4JoNVszxEIjamsQyqT6wa68K+MB8HPk6gJOfSreCKeo6MpLSzpjHzAmfjk1sjtxjlJoNZ+hBhCie1CcXxZCmcZeJGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rNkHX0Vq/Ngkt5d1x+l+tBPHthqZGQnOacW3DgpDrQ=;
 b=Fn1qEz9G54FgKnVf9/d8k0KAxIerEjXyTnilo4gsZKG7TWUKnlsGTGw6IeioVivOnAgo3i3cDiHlQ2bbsQjcluhAyzy8HQJTGRAu1+F8k0a32doi9auzr8wFNK476ke23b1lYcAeyV7WCzBloG67mDGZnrx4Dg5iBgOZCehxeFt1fRALW2cTK8R9al5e6mqkCKsRwdfk22EEW4+kEukYHUL/hEW7c1fOwaWWQShy0CE57gGgOrOIse+i0tqnMEr8kEeiNq1A5balOTHEvTAVJNWAzumZ95f+MFUTPwsLfV3MUFQbL9Z45jANashMyqLlmgCl2T7490TPXbI3O39/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rNkHX0Vq/Ngkt5d1x+l+tBPHthqZGQnOacW3DgpDrQ=;
 b=PjdzmkHqJTejVkyu59irP2nVYWeQMUxSAzkoTRdER2PxYEvLUl/szYJvGWrn94anhW391zXcbikNyzqDCLIqG2/wOsRRsskJm0kKPIBQYNDK2f5qPV8wZZrsLob77tCEqc0QLIm2R9pMFAUhbAHAUtQ/f0rf3yI9BFfOcZ9M90M=
Received: from BN9PR03CA0594.namprd03.prod.outlook.com (2603:10b6:408:10d::29)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:48 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::34) by BN9PR03CA0594.outlook.office365.com
 (2603:10b6:408:10d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 07:13:45 -0800
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:42 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 12/16] drm/amd/display: bypass post csc for additional color
 spaces in dal
Date: Tue, 3 Feb 2026 23:01:54 +0800
Message-ID: <20260203151229.3673042-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: c71eff18-cecf-43d7-c034-08de6336d4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CHK+rbnHYGjtcvFkYKF2uSynMDvbj5R2jSmpO1Hb6MGbN+Er5+cLFFq+wHoe?=
 =?us-ascii?Q?M+D/uTWxs16MkZWqIVFFb0bCUfpsTruLWwVlMLeEQFQLee6xJ9IR4NYpEEiR?=
 =?us-ascii?Q?K+C2WzbJ6504t7TkEQZQnbBk0XpAIZwWUFRBzsylr2B1HmXGqtrbJkc/FPT7?=
 =?us-ascii?Q?wNqSI+oA4nPeIDl/JEmnXQmyS+CjKhKPqgpxXEQX2IkRPamre3HAApJheq0y?=
 =?us-ascii?Q?esraeI4SP8qebSqKHkoc5ovdaoCIEIITRjN+ZfFQKU1hmdp54gKqQAJGxDA/?=
 =?us-ascii?Q?eZ5veAmRXEzro21mvPhZjCtG7bjWil75xzy3RN2UMGdPBTGtqGKaZc0DPFPr?=
 =?us-ascii?Q?2uSFcdGMyJsHJlqzFJqmq6qxCmbpPFZuqnyncuR7p5hS8xt/tGEkDKiE07NB?=
 =?us-ascii?Q?RNhqWogq3cgOw/1w1ewBW97ukCOpYB+/1OnXPdjum6jGBnX8nGle9ug6xGjB?=
 =?us-ascii?Q?VxurghPDKygwCumsVK4Bgb1xnz5HRRbZVXrgF0RgCrBTb/ft0/VsJ+1EpWqQ?=
 =?us-ascii?Q?0WQQYhiRDqju3rWK3kMSrmdB8qa6XWfY4aIF9VYPZteFZq0YRwy1zKluajdq?=
 =?us-ascii?Q?byq+8vBWv17Ub9qHqdZgTv4UHrTEEq0cEeVKSit8sj9B7RUTB43yWTYKYlIe?=
 =?us-ascii?Q?b3qJCoCQwoZiz1C4Qzj0CGaoVgeU6IJMph8wCUQUFBOPEjZ1HTBgu+5Vj6HK?=
 =?us-ascii?Q?tRA+mkeRM/ImiB5wYHgeZwNS+HF8aDlTvgEDYdrcPL+iF4WKUxgkVkEjfoo4?=
 =?us-ascii?Q?oj/JJfUqxWnyPBbe4biDLUEJVwUesmUvmEH/17Hszy4VYbAXbAJ1ieHCJBnB?=
 =?us-ascii?Q?IlAbPPNjhluFWUwLUOwDEZ9didRmWNKm7Jjv2AOXmxgmRN2MYl/Z3RJklEyO?=
 =?us-ascii?Q?TkUN7XyaoEFpYUdhWG5P1jEPHZdZI7Ce+eMPhiWfnpa52LgDjcYw0cF3r2VJ?=
 =?us-ascii?Q?JHRPnRRBIJcW4t8J0OeuyXbOtqgwEb9NOxuxwzH7C/l9AElIbNQ9lsKFlRYh?=
 =?us-ascii?Q?RoehZOhFyHp2jRozkUk8v0u7j+UoZ8yzknG84BIRXVDySLiJv97lnr/TNSJi?=
 =?us-ascii?Q?CD5h6zAyS3DbI2dJA5E81ZAas4Rp9FGejMDhYtS9uCI834dHV7ymDqhmeGbC?=
 =?us-ascii?Q?bYNCGE+KxJohrquqMizMZwJWkV4RKFMaTgf+moaSDSmkTNMGYDj8JoA9bTpw?=
 =?us-ascii?Q?69jFGZclKCkF3vlQLNXWY/SmDvuHX46Xml+pY0GwJTanssMCl2WJJsWzQO1k?=
 =?us-ascii?Q?6hfGbsm5u624mcka7kKsJzBC+MRkBXVXSMAebkkYNsIehHNUBqHdDf8IG5OW?=
 =?us-ascii?Q?FSbkIgIc2DUQiely6RvXL2dAf7QrCyKfHIS4ReIXKULwgUUHxk5aXdZ9oZRo?=
 =?us-ascii?Q?zRWggRPPV7AXZGqAiIsaI+mRhfSmFQL/w7Yiy0PHXVrwtUnXsGpiEYGZE+vM?=
 =?us-ascii?Q?mazx3OW0FTjF5jo3Mow4zxfVOCm5EPDToCifMNjWWxWs8OLs4tBMogKIx/vB?=
 =?us-ascii?Q?+3UXrVF7+r4dDKIV1FqunvlpmjojaOk5n5DeF9YdsR7fHSWpOhwWRTwoM4bi?=
 =?us-ascii?Q?d6jOu1NpbKTFkjLagAoaTKp2FugcRk5+3JTMSvl1eO1XzEJ1Bznj8GyhKW5P?=
 =?us-ascii?Q?nlSXwS8aVWv4Mrb6eg2hmxu2YMd3GZbdqYEkLR4/zipOHkqSqS0DqPgDq+rD?=
 =?us-ascii?Q?o2g/kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: goMkaSxIhio5HQiWvsaKSZ//p5o1KxsbDCuJ6QjcCOVJtYjIdqKFZAh0bT4DKDzDqLICNSSIa96SrWeank6oog7boGlnHI3ny+XXwQqu5OsFGhbajklSUjLTDdvGiQHu2/f7LuA0HDZvBlv/YDvWFWAlyqSy/ag0T2mWWH6mXtPNst6tl1nYkXoVDu8vn7/cbVpN9y4s7ndAw3hdtR391Vb8cMSA4xHSb4Kp/+YpKI3Ei8Sf7w3pM41uZpjG2k1+BuK4lvHBCDEjcIqEpjks+EmZHRcKFgFrxQebka2/E0Lh0+xmdRG3RKR1mivG/7i3F50Fy8fLbfB0SIHwFYfJRIOI1+J4cJx6hY6yFbBXZP8YcTfHOhD9eXXY0suY6t9tXmLzBPNrOrWLnAZDKHBwPoDEVEf4OOE0IRqLAL0WJ44n7p3QRxVtwjeCyW5ct0m4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:48.4167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71eff18-cecf-43d7-c034-08de6336d4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
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

From: Clay King <clayking@amd.com>

[Why]
For RGB BT2020 full and limited color spaces, overlay adjustments were
applied twice (once by MM and once by DAL). This results in incorrect
colours and a noticeable difference between mpo and non-mpo cases.

[How]
Add RGB BT2020 full and limited color spaces to list that bypasses post
csc adjustment.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  | 21 ++++++++++++++++---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  4 ++++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |  6 +++---
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index ef4a16117181..c7923531da83 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -376,10 +376,10 @@ void dpp3_cnv_setup (
 
 		tbl_entry.color_space = input_color_space;
 
-		if (color_space >= COLOR_SPACE_YCBCR601)
-			select = INPUT_CSC_SELECT_ICSC;
-		else
+		if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
 			select = INPUT_CSC_SELECT_BYPASS;
+		else
+			select = INPUT_CSC_SELECT_ICSC;
 
 		dpp3_program_post_csc(dpp_base, color_space, select,
 				      &tbl_entry);
@@ -1541,3 +1541,18 @@ bool dpp3_construct(
 	return true;
 }
 
+bool dpp3_should_bypass_post_csc_for_colorspace(enum dc_color_space dc_color_space)
+{
+	switch (dc_color_space) {
+	case COLOR_SPACE_UNKNOWN:
+	case COLOR_SPACE_SRGB:
+	case COLOR_SPACE_XR_RGB:
+	case COLOR_SPACE_SRGB_LIMITED:
+	case COLOR_SPACE_MSREF_SCRGB:
+	case COLOR_SPACE_2020_RGB_FULLRANGE:
+	case COLOR_SPACE_2020_RGB_LIMITEDRANGE:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index d4a70b4379ea..6a61b99d6a79 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -644,4 +644,8 @@ void dpp3_program_cm_dealpha(
 
 void dpp3_cm_get_gamut_remap(struct dpp *dpp_base,
 			     struct dpp_grph_csc_adjustment *adjust);
+
+bool dpp3_should_bypass_post_csc_for_colorspace(
+		enum dc_color_space dc_color_space);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
index 96c2c853de42..2d6a646462e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp.c
@@ -206,10 +206,10 @@ void dpp401_dpp_setup(
 
 		tbl_entry.color_space = input_color_space;
 
-		if (color_space >= COLOR_SPACE_YCBCR601)
-			select = INPUT_CSC_SELECT_ICSC;
-		else
+		if (dpp3_should_bypass_post_csc_for_colorspace(color_space))
 			select = INPUT_CSC_SELECT_BYPASS;
+		else
+			select = INPUT_CSC_SELECT_ICSC;
 
 		dpp3_program_post_csc(dpp_base, color_space, select,
 			&tbl_entry);
-- 
2.43.0


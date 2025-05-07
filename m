Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1AEC3ABBC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 02:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F6D10E736;
	Wed,  7 May 2025 02:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ConTJnrt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC5510E736
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 02:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2zFruduqTAJcTyHSoTnk3uTkE2seYVOC0ENGuK0q9kwyhMES+ogObfCKpjM+i3jFfCcWc1JnmdpUnEgxl1QbwBhCapMPbueaQCC7tIRadP4qnqO2zku8LMqoIB7emcc1KC5pejpUMscN84WhI6Kc4PtTJhkcgldsTNpu7DjqNBr+eL3opbafbfNk36vm4WnUQooaVY/FhjJ4iCbAIWs50O92cMpOrfpXwLoszLsfoorKVGoAAKCS+II52JvomOYKcDB28cenXOAcQScaEeqJ0pF7/hrbTuFAm7y1Kj/QZEBHWHeEG35OfB47ycQv2j4j091/eVKakzlypxNZg6+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pECpBa5ZBzGV1FSs1Ar7wdWehR8wsWQ8d4OvOFfTxVE=;
 b=bDfecakGX+qlAWziePvXN7BU88n28U8M80pOagpYZyajROd0znDSC5O4bkvqUcUmC1N0aSh9tKf/S+9coJyc/axwtbt0vHEbc6P9Ub//Jq1M9AaayoWjUhH30yYy/hKDZePYmSy81QsA18dPuf5nqDG7b+WpJtKt9aAljJatI3sTnZm9Hs7LGVI5UKlUVHExyigOh3qn4fxCCmug8UyGMZcLOatu3tAv4Z1edgPtWq9mniZHPm2elQw1B/PXtbRn9a4TzSTZgRgtGPlxPT9pYQY7l65APLdHMHxITzssjlKSNJaGtbblbILrY+i12bCSyNkSWL0mAIgqTtEQi6ZGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pECpBa5ZBzGV1FSs1Ar7wdWehR8wsWQ8d4OvOFfTxVE=;
 b=ConTJnrtNER2GNzhCorZwTumgv1VL63QGll+7SpUscsg5rp/QcqyGCaBwPWTv5StkfMCZEwepmrl/vQwrdatMF9wrCDYxtjeUM+O33+iwJHuwg/d6NQoE2f4LYUT1ALX/2SBfyL/A2gQ+9ZtM1UpmiqKjQZ/vUnUc9bIaeveiic=
Received: from BYAPR08CA0056.namprd08.prod.outlook.com (2603:10b6:a03:117::33)
 by SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 02:43:55 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::56) by BYAPR08CA0056.outlook.office365.com
 (2603:10b6:a03:117::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 7 May 2025 02:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 02:43:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 21:43:53 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 6 May 2025 21:43:50 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/14] drm/amd/display: disable EASF narrow filter sharpening
Date: Wed, 7 May 2025 10:34:54 +0800
Message-ID: <20250507024242.1928299-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507024242.1928299-1-ray.wu@amd.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a261c74-079e-4e15-3fe3-08dd8d1102a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9BVwAfbByIk/WzY40EcY3jjoVN522jIL9L08a1xv82xymIRGNyLNPJxiFwTd?=
 =?us-ascii?Q?IMJeO2Od/wFCo24bfKw9tST1ScU25gIIrtQSaOOCyvY9bvIN+Tx+vtTtgGIM?=
 =?us-ascii?Q?op1eBA7L17eyHaroDUhrhTnozmRtYXJ4sDxscqKffQ1OJJ4lO5BvyNsPFirw?=
 =?us-ascii?Q?dpQRhsyCUie8qIuCluYFbXq8yQOecIem7LeWfJaZK567tC3gUeGby85BwEed?=
 =?us-ascii?Q?3SOWfWZ2CGDXZ4GxwFfF7hDk8jkF6hUAtkdgzqOAGTNB2A134DwPvZinM4jR?=
 =?us-ascii?Q?DjHY4HUr48Pm1G7cCGES88brgdn4/F91YGGC/0WlvN1BEo3E+61576zp0Xfw?=
 =?us-ascii?Q?npBhJYMciYQe/Pb7szunsBssPXhFPQQz3YdcEV1zXdb7geWYJPbq0+o1U13I?=
 =?us-ascii?Q?g/7bjSKv8im1JrO0aCqNzAXh672p3ztMnYDe+ZrPhfcUFRPV9RD4E2JsycmX?=
 =?us-ascii?Q?Fr9xR8HiAFdaAuP7oYV4SJhEDQiQNb3ipJjy1viTUQjx8Dlj1URL9SWx9UyB?=
 =?us-ascii?Q?oBVnlpB3ZwSXyZAKZR3+Z0oQ21Ky1wuwFrG8hd/RX7ezx7WX4FXL/K9Nufbs?=
 =?us-ascii?Q?HQucINppVZhzUJqtlFZD67xsXoQFuvn+8211EYm/Jv057yT3OllgstGf337j?=
 =?us-ascii?Q?qYFPIplbqGo8VfN0ovEI3IsYtI/2CeLAK5HJCcrAMmi8b3rZA+XvuVhAqIQ7?=
 =?us-ascii?Q?FkUXfOzJ0NS3WBoBp/eSrgx+kEn4RjpDA0fpnkYV1MpnNDsP/4pWrDFzm6Wf?=
 =?us-ascii?Q?5RdrcKizOTU0S9acCERsl3P/o7cJBUDWuHJJLYmwLqC8Rc2TY8Zbpy03VN+c?=
 =?us-ascii?Q?AXvClu8/i/IUSTO5QLLX2JcFyXsEg/qtpigGuI6hi/i+lVGOo2/62FomLgrP?=
 =?us-ascii?Q?l4H7aA416IE2XdXBgVX5aZCurcmvFHNp7oS2uGx2HO66U+X3+cvV/jbJyvp2?=
 =?us-ascii?Q?54pHDW/f/NBCnNFRr04W+hsDE3XHP7R1d/JI/j2usWaekrVowmxQpS8vqave?=
 =?us-ascii?Q?3sgiE7K7buk5XvQ3A6h1TrjNF1oUTxEDWTuPwDzM//NZhwgAUWhStjTWJYNc?=
 =?us-ascii?Q?lbnGpDBbJwNVRgF1aeLSxRXwEeHvZ/hBJDT/YTvxUX800Kjv/xiBGkiCPzgw?=
 =?us-ascii?Q?LwoMvgroL78lErGykt6xKPRN07/6Xq1CnhXgswavd754cbqSyf4TvJFH/Fne?=
 =?us-ascii?Q?/ZU1Ok6V24Ub1xESE7zcjvkVqMPr5yBaCp1v/H88UWHKJSVzZUSn80rYH6TN?=
 =?us-ascii?Q?/2kko/jhSo/ksXT3XFT6W2SPCxgGYN7TZOf+PZajTEXH7Pqwf6TFOqasZ/Vi?=
 =?us-ascii?Q?HDtRMzRFOxr4BRBSy/+OMHb7Ch2dKCKg+uC3s1BDv0MaU8kxTdHNY42yiU8w?=
 =?us-ascii?Q?ql9AF0VFlrcplz0JbgqrSsyXDYuoSx5U4sqjavOGbQqf7dgUN1lW9XvYsLQb?=
 =?us-ascii?Q?RSZtFL7xDqVEA5cJ5nEqMmMoDBAInmQOa+AeBh8aB+PMAXzro725swspLSYD?=
 =?us-ascii?Q?dUWtXutjUK2wM88AU96OOl5ilh4z41FBdKWM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 02:43:55.3277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a261c74-079e-4e15-3fe3-08dd8d1102a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
Default should be 1 to disable EASF narrow filter sharpening.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 002eb926cca4..e0008c5f08ad 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1299,7 +1299,7 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 	if (enable_easf_v) {
 		dscl_prog_data->easf_v_en = true;
 		dscl_prog_data->easf_v_ring = 0;
-		dscl_prog_data->easf_v_sharp_factor = 0;
+		dscl_prog_data->easf_v_sharp_factor = 1;
 		dscl_prog_data->easf_v_bf1_en = 1;	// 1-bit, BF1 calculation enable, 0=disable, 1=enable
 		dscl_prog_data->easf_v_bf2_mode = 0xF;	// 4-bit, BF2 calculation mode
 		/* 2-bit, BF3 chroma mode correction calculation mode */
@@ -1463,7 +1463,7 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 	if (enable_easf_h) {
 		dscl_prog_data->easf_h_en = true;
 		dscl_prog_data->easf_h_ring = 0;
-		dscl_prog_data->easf_h_sharp_factor = 0;
+		dscl_prog_data->easf_h_sharp_factor = 1;
 		dscl_prog_data->easf_h_bf1_en =
 			1;	// 1-bit, BF1 calculation enable, 0=disable, 1=enable
 		dscl_prog_data->easf_h_bf2_mode =
-- 
2.43.0


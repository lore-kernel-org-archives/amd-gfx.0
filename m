Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96505D36138
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A30410E612;
	Tue,  5 Nov 2024 20:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3zeAxbPW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E284F10E612
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whzDqs1ydv7SIDalklJY/QUa6wTEpRtx7ehkCEotMxKK7sDRnkH9hmeeEBw5/w+p4zHKKg3m7NmQjlKuZ+sDtZHi+s+cnJa7zI9hWQ5/NzcEF1sBseuTryYeBUtPAP4FiVYGLXdWHNUF1hiRJYu+UkMO6rLpNulyC4WMO98qccIKn7KDbOGmOPxwpSXNg8R2WMsJiRBYqxQACUoV1j+AA+2P9rx6B3Qa2MhrW4UjY6+1rOvwgLw0B1M5wNAo1CL1wC2CrHbUJEIev72MGl+bxo7canyv7u6gKpcFJNqRV6baAieuUI0S9Kt5Wob/LXhbgY6u4F1I4Wj28wkpDvsn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+r5zkKdcfrVopF2vSRow4czNP6p4owdkvGEuW65vMPA=;
 b=RiFleRrXWavuXs99hf0BwOUGH4yu7/Lp79rHEtQkk6pAgbXSclhEASfv7bo4sQpA3vuUq8PLdRhKA9Q9XetOvZl79VDpSrFcpZddNyu6bRyLzN7aX7xiKVocyXTFHsmKhWS8G/iw3Vf2ZCpkY0Yl4QZRDgY/o9STDBZ5WOWpCLgy5X++OWwJqLolQ2/nsQ5ZGAgj42DhjySQylJ/YQl+3bKACS+8/j3FT967h2mFbDpig+LrE9W1LHOSYno3RYrj5vcupI+JNJWLk41azMdZud2CZ8/j1eS07XL3C45fJ0hhPY56NF4JoEvxZi80x+2IMMtHRV7rRRdd6uh3MLcPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+r5zkKdcfrVopF2vSRow4czNP6p4owdkvGEuW65vMPA=;
 b=3zeAxbPWXXvuwfZI3VTaCyF1g5eBhnY7sI9iz7PhJ5SmqFrySYohrDt2XhXdBDl8F1C7Bh7W+BQl7VBKJuWOA/Qf6hsTTV1LhKuuFofM9judPqUIFe9LvhryFHPr9C2rfuUv50hi7NBMgdG9A1fkeL8BjTwh3ivTHwXNS0jVP6Q=
Received: from BL0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:91::39)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 20:24:56 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::89) by BL0PR05CA0029.outlook.office365.com
 (2603:10b6:208:91::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:56 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:51 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 14/16] drm/amd/display: Remove unused code
Date: Tue, 5 Nov 2024 15:22:15 -0500
Message-ID: <20241105202341.154036-15-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 72995076-2aba-492c-71b6-08dcfdd7e9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nO0VgaZrjhm1m30JSPMe94obzXCsu4yJK90to1thJo2YFB09XcydHFB7WBUl?=
 =?us-ascii?Q?x/OjRRSW+B37U4ySXT3VkulQndUO/s/VUo4lWI7d74ImOxqLbdTp4POflXA0?=
 =?us-ascii?Q?Qisrx89Y+6UJdxvCjjVm+CBoK3gWrFr4gq9oeW+6D7zSlkIvJmz4A3CDLjzo?=
 =?us-ascii?Q?CY6lcbDwCA2X//ZPSGtVtbzebUGQWV3ugIu9S7BSRR57/vC0Si7woCYbqNyn?=
 =?us-ascii?Q?2YoLcfRx4LRUavh5kon1w/RyG8dA7xt3pP4r8B3FIplylhh6tVu6wiO4BBYY?=
 =?us-ascii?Q?JK6pWZYb1phY1Xof+zjvJ5kGoRHPOiME65al8P3tgFek29GTjEOPhNXoDgBH?=
 =?us-ascii?Q?6cbXZhrKhdqEiuhu4PDCl0f+3oNxWXyHEoYsc8XL0KMH86EKDbGk/9HiJ41R?=
 =?us-ascii?Q?ZCj6ro1TMdM/5OO9hhbmBfh+brvYdRwiyJl0IAjmbt9sFKdKH4p1Ied16eyj?=
 =?us-ascii?Q?F2zVHMxcFNJHG+Aem4GHKnHsL0bQnaxAjb5VcCT7/1cA5gA9e/PJJBiHWDEi?=
 =?us-ascii?Q?eSF7U19KKPcEihhfE3EFt9owRVOwfZBhnx1FH/ResraaxorLS9WgUjYkkHFF?=
 =?us-ascii?Q?y5LM2WG4D4f99jWKMcX9ns0u0SZQ2NFrzQNGnrE79iBPZBx5pDLMV2FbW4dT?=
 =?us-ascii?Q?TvNyAafcTeW5cPXpHa7+967/fnkrZ7Lns/Gt4VFE8REnVDjyrKjBvO1JNpOg?=
 =?us-ascii?Q?bbsSNcgzbV3gAQSEBRmThEEVqHVL1DyQ3Y/Rm2d8MggqLnjJGdNzeiUOe1EC?=
 =?us-ascii?Q?7T3Ej3ZVCl6b420OqWaljRmIf39Pr3rQjfVEN8snpBUKcDY2X++1d4XyouJ5?=
 =?us-ascii?Q?b4pyJh1NluIJYfH8oAMJ0oT2fNrgV+l6WZKLwMbfw1GVQDdnnRhKccQIezkE?=
 =?us-ascii?Q?sBa1yw/AOahyke71EAvvhK0AFkWN24KOchZZv/QpfBbduJZZlJCZ3x4RGmwv?=
 =?us-ascii?Q?rfkyba6AyUZ1M5x/6bLiKiPRXAq/+oQ9nMzn8Z38mtpi6vjNf2jWBqiv+xbq?=
 =?us-ascii?Q?U/CffBfU/2wBWZobel46LtZI4SkzehGXNPVgE7KqYNOBKoDwwn5Sc+YrhSRZ?=
 =?us-ascii?Q?vQ0uRpDA1rivaKw42g29itUlams7mmNoAn3uWudbDH13Q2ZFTpsK9R1eH5Im?=
 =?us-ascii?Q?VkR7zEypyxxkIFXQ54+QkplyRdxpl8dcnRS4JwIKamlNuEY4Wz7VvGvNElm3?=
 =?us-ascii?Q?ocTYLSkRG/z6yYQ3bIXxNo5mFFKlawAPIClyNGtLjqtboGnkXK7z3eeV13PQ?=
 =?us-ascii?Q?s6jCbt8O3RN71qrmuPiGfiI61SP74IqZa1Q2XYQW158jb1HZHrEAQKGfscNr?=
 =?us-ascii?Q?xBSXRQTOcWXAbyDz2W3IADswqBuTxhyItbLPjyAijXstpwN0mOruP7XUWbZS?=
 =?us-ascii?Q?jW+BIVLzBeAhEJ4gmr1XyTx6uuOV1SsBc98vE73EKL4CzGl+AQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:56.1640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72995076-2aba-492c-71b6-08dcfdd7e9d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit removes a legacy debug_defaults_diags struct.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../amd/display/dc/resource/dcn10/dcn10_resource.c  | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 4f1bd71b9ad9..770a380cc03d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -559,17 +559,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.using_dml2 = false,
 };
 
-static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = false,
-		.force_abm_enable = false,
-		.clock_trace = true,
-		.disable_stutter = true,
-		.disable_pplib_clock_request = true,
-		.disable_pplib_wm_range = true,
-		.underflow_assert_delay_us = 0xFFFFFFFF,
-		.enable_legacy_fast_update = true,
-};
-
 static void dcn10_dpp_destroy(struct dpp **dpp)
 {
 	kfree(TO_DCN10_DPP(*dpp));
@@ -1398,8 +1387,6 @@ static bool dcn10_resource_construct(
 
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
-	else
-		dc->debug = debug_defaults_diags;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.46.1


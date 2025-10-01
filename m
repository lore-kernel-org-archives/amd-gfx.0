Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9401CCA472
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 21:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D35210E161;
	Wed,  1 Oct 2025 21:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+qCCd/P";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAEE10E161
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 21:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryihe2D/TH4OfUsDb8gaAf7YKyrtxe181PsNar6ALehQ1Hm3WDoirFUsVdTJLl5YIFWS0FVChv2DcHF3P1vpSwtV18VZDNy3Pbka344K+V4096dJ0SbRJNzJI8xCrnWUt6JGjMd8kPe4Tcabp+nR6cAMJmhsRKlzKpwEnXXP0DHd/CLvB/nkrCSNGaUpoBTYdbH2utbsV089t44ysJyq+Q62Qk6xT5pEovSAQngtVvNde29mdYxBFIUBIUx/+DUgzsv+xVYvHIR+87ut2DKWEDDp4VjXPWY3uE+8csSR7/GKf13JihzJoV/d5KGxImH0xHtcLHQ+2VCV6o2B5o7yFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpXYhuGSjzT025PRHXMdYRVi7iAualrlFrz11r4LLZk=;
 b=PBLIEfWI2yJIFsHDRS+xcmLYXPUN/9qZ8neWmPLvr6RLGT2JS/DGjUwLS2j6X8OGBzwoWRv1ehxstt6QEYqkbCKnHQXiaabKd8yedBSFqOM+EGuOwqAP3gOy+CVa/1D7oGVcBnk/hMtK3kk5rm/UOXWkAO9p8sWNDjrkqp2wADaWVLMfrkyMnb+Jh58/Mszn71ONrcz/NPBAP2zLU3sHCSY/5y/wIrC+G09wiiMsE2dEOVRJyQ3/sZNfpi74bxkSJfMcsr+pLWoecRjg4fo/d+lzhIzP0gc0uDeq8w+Y28LBpneG7bXhKrchxkHsnXx+qY6clNt/JuUX05UPQaP4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpXYhuGSjzT025PRHXMdYRVi7iAualrlFrz11r4LLZk=;
 b=f+qCCd/P/ExpN0qexQlmJmWuuOhiIB2JgqO+F5R5ddnUhC1Gxu9PBWDRpUNwVHSQnDXFljvw0p9LFkek09pCqReOcp7ADAadzYI5/airAzQM5F7bJq6EEI0gtTv5Kz5LgsyL6Ofh6ntF597r9YZ6xGBXq+z9yj4kv3Jm7jnKg9k=
Received: from SA1P222CA0095.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::26)
 by BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 21:27:50 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::9e) by SA1P222CA0095.outlook.office365.com
 (2603:10b6:806:35e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 21:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:27:49 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:27:48 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 2/7] drm/amd/display: Remove comparing uint32_t to zero
Date: Wed, 1 Oct 2025 15:24:07 -0600
Message-ID: <20251001212700.1458245-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|BL4PR12MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ec21eb-d069-4b01-0b02-08de01315f5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NzmaTLzeG4dZzfaF5mzl2XB0W8yL24Ht2mGFmE6rP3AxEb1jM5oMn2HXfQ4T?=
 =?us-ascii?Q?gnnGVpd1IC870Nn7+avMqE+q1x1tK/q2uToPcVzVp5hQ1rVOVe68ZHfqGoM6?=
 =?us-ascii?Q?4q8FVjxwy9J36Dmj7kVSwoYYjC3el6FEyHfvfhsBMsUOtyLE0vQItwkAgSOz?=
 =?us-ascii?Q?XfqX6biu0NNQuSUM2+qNRH5iHJKMKkwF5asRx1HzQOl3m+Rpzqs2dcakJV3o?=
 =?us-ascii?Q?IViLlMtbmxRVk1IU6xw+5Hm9g3BgDmVvlaDNyZrEi8Kx+fz+MsoMyAjVFAAP?=
 =?us-ascii?Q?zWyKXSGdB1QlzCB+p7TD1LnWcNdhOjvOz9OtIsWWIIknYsj8BZD9yA4b4mFl?=
 =?us-ascii?Q?Sxt42wS4CIuZyOJ+sBUFhknTiQbMjheGuMvM2d7jYLjzHHaHYVsVV8GfVq5a?=
 =?us-ascii?Q?EWLGL9gzKOSZB6Azwsm6FFQjS2dthE8lGAi6/dKc3bmjiP4gZFt5HFWBMAfE?=
 =?us-ascii?Q?JYSFwSTcH2Hb56aOzF6U5q9DqguSrX92mRcxvnZKL04Ja0UGWtxxLo3K9O5A?=
 =?us-ascii?Q?osWZkrHuyXMz1XlqMofKEJvadHJO01+MSQnlL5IPeN4vTU3gWj9NRS0JoUpE?=
 =?us-ascii?Q?bFCJD42VF4TWgBBODSifYd4CvaxbJCs18mwyqA0q4lKMHrGMhjQ/RNP1Pcgc?=
 =?us-ascii?Q?nTImId99pYO7EdisCMYsnSA9ZEwJ7cJsom5EsSMZWtuHCOIf6WgNM2ie2mBf?=
 =?us-ascii?Q?bXoXtdKEsesuB3rul6ixeZIb8nTyuddHzTwJKKb1wM9PGQmCGTGGSNS3T1/0?=
 =?us-ascii?Q?OpUyIQf6yLXIM6on92ma3Rc6aVwpGg2KfbR68f+Mw7zCT1UMxpMIqErQwft8?=
 =?us-ascii?Q?lKKieTt7cr0gHznlK4UHHGQL2IDP8v6Z+Thbi21Bqdz7bre9MLnKobhVtGU1?=
 =?us-ascii?Q?i4M1kncomnsqtjStiU4iyQAU6pHO8HLJ8KbE1almjIS5OYjl9h8dazowZuLz?=
 =?us-ascii?Q?6kdHltZIMmNoR09Fc7CW6gQBldbKkGvd57Nhy8R8CNyFGWJPIvFEwehgHtMO?=
 =?us-ascii?Q?6HeGH5nMHMR2Z5DwxMRKWdIaKXUpwhRCTQy8QIopcCXlisWic8qKfcMGDMnj?=
 =?us-ascii?Q?/OmYwDt0PC3vbT6lWNFQYzOwMqkRr6CY+TWgktBvdXX7k0M1vkL/x4kKqgow?=
 =?us-ascii?Q?vStGbAhe1vKovhjIlak7pO+MNwND4yAncU3f+b0GAbkE2AqahPokTAXTXMwF?=
 =?us-ascii?Q?abOOi3Iv+m2rNhOWqtDI/x7n5HYqaaZBExEZaDIm0blff2RC+xvlmCeyI03b?=
 =?us-ascii?Q?0a3SEq6i6uHf1V9HACPmQSaS8LcgrEvidicv50oyxhWXf5EIcFI9lLngVQjd?=
 =?us-ascii?Q?I5T8zmLk0TVRGbMZABuKItyEevJ5ffMa9P6dC+4hF4Zq2u7zHF5W4fihh4iL?=
 =?us-ascii?Q?glzAaLnavrZ8mkTEoPgBqAbLoJ29zOwyuAKleKbO1aUZFAvr1CGyuYmvJWsj?=
 =?us-ascii?Q?HkwDbaEfsRxKl6Psy3hIq7euQk/b/9Y3JSMPrphW70OD+v1Xs8LKwiJfZZEr?=
 =?us-ascii?Q?BQ7vorkhFPb4TJE1sNEfQBZJ5CDJg/BJVCo2TtNIRDWL9Ot+EDaOXWiPL0Cd?=
 =?us-ascii?Q?enGC2GabiJkfmbfKyYE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:27:49.7315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ec21eb-d069-4b01-0b02-08de01315f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483
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

[WHAT]
These *bypass are uint32_t and they will never be less than zero.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c    | 8 ++++----
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 9e63fa72101c..db687a13174d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -509,16 +509,16 @@ void dcn314_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_b
 	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
 
 	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dppclk_bypass < 0 || regs_and_bypass->dppclk_bypass > 4)
+	if (regs_and_bypass->dppclk_bypass > 4)
 		regs_and_bypass->dppclk_bypass = 0;
 	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dcfclk_bypass < 0 || regs_and_bypass->dcfclk_bypass > 4)
+	if (regs_and_bypass->dcfclk_bypass > 4)
 		regs_and_bypass->dcfclk_bypass = 0;
 	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dispclk_bypass < 0 || regs_and_bypass->dispclk_bypass > 4)
+	if (regs_and_bypass->dispclk_bypass > 4)
 		regs_and_bypass->dispclk_bypass = 0;
 	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dprefclk_bypass < 0 || regs_and_bypass->dprefclk_bypass > 4)
+	if (regs_and_bypass->dprefclk_bypass > 4)
 		regs_and_bypass->dprefclk_bypass = 0;
 
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 1eb04772f5da..35d20a663d67 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -635,16 +635,16 @@ static void dcn35_save_clk_registers(struct clk_state_registers_and_bypass *regs
 	regs_and_bypass->dtbclk = internal.CLK1_CLK4_CURRENT_CNT / 10;
 
 	regs_and_bypass->dppclk_bypass = internal.CLK1_CLK1_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dppclk_bypass < 0 || regs_and_bypass->dppclk_bypass > 4)
+	if (regs_and_bypass->dppclk_bypass > 4)
 		regs_and_bypass->dppclk_bypass = 0;
 	regs_and_bypass->dcfclk_bypass = internal.CLK1_CLK3_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dcfclk_bypass < 0 || regs_and_bypass->dcfclk_bypass > 4)
+	if (regs_and_bypass->dcfclk_bypass > 4)
 		regs_and_bypass->dcfclk_bypass = 0;
 	regs_and_bypass->dispclk_bypass = internal.CLK1_CLK0_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dispclk_bypass < 0 || regs_and_bypass->dispclk_bypass > 4)
+	if (regs_and_bypass->dispclk_bypass > 4)
 		regs_and_bypass->dispclk_bypass = 0;
 	regs_and_bypass->dprefclk_bypass = internal.CLK1_CLK2_BYPASS_CNTL & 0x0007;
-	if (regs_and_bypass->dprefclk_bypass < 0 || regs_and_bypass->dprefclk_bypass > 4)
+	if (regs_and_bypass->dprefclk_bypass > 4)
 		regs_and_bypass->dprefclk_bypass = 0;
 
 	if (clk_mgr->base.base.ctx->dc->debug.pstate_enabled) {
-- 
2.43.0


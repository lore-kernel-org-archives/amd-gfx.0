Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C966BCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 04:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8E710E108;
	Tue, 19 May 2026 04:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GxLNEgZ0";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4128410E108
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 04:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZYukkhtjvY2O829D83XHSFXj8a7vsHOgwDYiUWtMQ//uZ5NdpclrDOjH+elRQc9e/t21oi+fEZvcgoDaSOmhKfl2plr1/Au/OHcpGDFe5EaCM0ne6GwrCwu8l/HZ2nMtVt3u1gjV9+bxGF+bz3fGw0X5huOQqS5uRU/QDpxBtmhzPz/qCrYBH/XoB31370aogStZCnDE/q880k02magdSGW2JjCq94FNN7EiOVsexMGbXb0D90TVYJyEaTNDQR/d4f4jmL9SMg9lETAMjo+WWECwvfYOIOgIrN9v0dHDFAFyr2KBqUgHHWtPbFRSCUK3CG6READF45tkC966FABSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0UYhNEMHYlKHHIHqyeEHH3sZ3r/FoQ+HboLySENg8U=;
 b=La5z6P3+lWzxdA57zxCNFE076DGMUQ1zinY4JcWCKvxQVA7QOL4eusSx+5FOWg7LZ8pHlJPlHFKqJmehCrZRP1H9a3FVVr3nAGoG4UbpznDLnQaTTDq7zz3y56iMoYSK7YSQACVWRplzr7lhGe/ob1sACKQxQsKQyyWkOwNQILjEJEhOs9P3dJWb1vwRzW3lNBT171BJ24YB8zBllbnSQ68SqGeXmu4nCjWS/2dqFwJxW9zUMYNWjDg0ouVl1Mw5S/kBrxfy5rS2Hds624eq/HwL8avWC0iAd1zrSZRHFlNylcxrMkELYX/XkCSCA++nYeeln+tEZn8qI8GB6KuN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0UYhNEMHYlKHHIHqyeEHH3sZ3r/FoQ+HboLySENg8U=;
 b=GxLNEgZ0ewd6Yr6NeYpzvi3E2cg06TTfP3AHE5g8o87wMVwgYC9urmMN2EtmxkL/BDGnU3AvXkv3CozTlyhKivBtQduosf0eIg6vQs3RCbRWcrRhZqmP058sO7AB8XzAbYbZxk0mkTxuQvbAm8svccUKfx+UOvdxB1OI4Clwobg=
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 04:18:37 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::28) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Tue, 19
 May 2026 04:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 04:18:36 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 23:18:34 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu13 power limit default/cap calculation
Date: Tue, 19 May 2026 12:18:22 +0800
Message-ID: <20260519041822.552663-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 620d0156-c95f-4d8a-f0c9-08deb55db28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|13003099007|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 3zgW2/twqEoOAsPBnaSlRstOJWmujTSYrawbRUbdi3XKzuSvp39MjmVpslDRk2BRMNhclc9GvHJHaQB+7sXSfvDtV7mymH9VmIRkR+5abtbo7KTdiHh04p+/1DZtThtOf7Z0f6UmCaw7GL17rR1dDk1P0BazSPoykqQN1Sv1WMYC7dteqQFMwdua9hrSy4Q8WaKyHr8tBKZ9GIfEMYux6yUhxncI+EGafwgGsJ5OqPM2cQmNAyoUjRhoSM+rjutDygyMfHLoxOPVrSZQrOg1avHcVtYcvAy26xdTC4O/M+Y3kELTR/i2/yQqS8XPim7RmUOFI8gImqULYSQ4BXMTmz3PuUmcGVVW4aWrnPCiL6eQh9cAjq4nq952h45K2C1pQNVyQj7TzcJ712mOBuEz5bB0rwRN0iBX7xeY4eC7hiSW5MOpmCayHChCinL/g8y1bQ2nEkaVgX8B0Pprb3qR7kfxRa1Ih7TjAb0XC2pKJLu6N0ag578ZR1uV4XAoPRx6410sNODbG0P7uH4uB8XgqkloFEIwsw+e6nhlSi7MH9UOYkQmxamLIxmaQbw3hjG/laOu/Uo9xKwdktO7pj07rDxrzKnzSd+Khcy6SvFDIrowqyniot4q97AE59nycZamT8spk4hbkOqKr5+EOo7gkTQh7JoqECDJ0KhqMOXFjirCXPURbPMLfl5XTMieTsaD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(13003099007)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BLXULHsRvr7cGy33F7pxRJix0MKDL+QQVjyCWhBU4mrkov2aJJn6FQ0Aert4it6V/6hu//2froAfCbvh4O8+WoFcIEOZtMMEaegcz7Pwrc6KdNyGuv0ToUXlFBOTWJP+iFlnpy2mc1FEHeVmzCZJNL3woZBSwfpBnPpYdIuN18XW5R9gX3hGZ2q5GOVAfw3CY0811ubl87ZRudhndRHLgeKnN8yxd9S0+7cMPfqxNb1ol7pNl6gO2F5F+xHpN4G4DOtp2DVsJfEuu9aUayDJnulDYk9Xh+toc67H+6I4xzldfRe9E38VyjAtu2NovtF8tqedUFe3IhvVVeNbmeQIHUL7A9wWyB+/XyoXJs+4FmKgtw97C86OlfZWEBPm9i4uiuIzZlFedcytULUFcSBLfTlW/AoO0n98SFX4Kiar0d4pxSdND5Dz0f+Su2Cfy68O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 04:18:36.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620d0156-c95f-4d8a-f0c9-08deb55db28b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899
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

smu_v13_0_0_get_power_limit() and smu_v13_0_7_get_power_limit() mix
runtime power_limit with PP table limits when reporting default/min/max.

When current power limit query succeeds, default_power_limit was set to the
runtime value instead of the PP table default, and min/max could be derived
from inconsistent bases (MsgLimits/runtime), leading to incorrect cap info.

Use SocketPowerLimitAc/Dc as the PP default base (pp_limit), keep
current_power_limit as runtime value, and derive min/max from pp_limit with
OD percentages.

closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5227

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 32 +++++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 32 +++++++++++--------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 30d9cfac0d89..9e74a5c4be43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2391,28 +2391,32 @@ static int smu_v13_0_0_enable_mgpu_fan_boost(struct smu_context *smu)
 }
 
 static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
-						uint32_t *current_power_limit,
-						uint32_t *default_power_limit,
-						uint32_t *max_power_limit,
-						uint32_t *min_power_limit)
+				       uint32_t *current_power_limit,
+				       uint32_t *default_power_limit,
+				       uint32_t *max_power_limit,
+				       uint32_t *min_power_limit)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_13_0_0_powerplay_table *powerplay_table =
 		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
-	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-
-	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
-		power_limit = smu->adev->pm.ac_power ?
+	uint32_t pp_limit = smu->adev->pm.ac_power ?
 			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
 			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+	uint32_t power_limit = 0, od_percent_upper = 0, od_percent_lower = 0;
+	int ret;
+
+	if (current_power_limit) {
+		ret = smu_v13_0_get_current_power_limit(smu, &power_limit);
+		if (ret)
+			power_limit = pp_limit;
 
-	if (current_power_limit)
 		*current_power_limit = power_limit;
+	}
+
 	if (default_power_limit)
-		*default_power_limit = power_limit;
+		*default_power_limit = pp_limit;
 
 	if (powerplay_table) {
 		if (smu->od_enabled &&
@@ -2426,15 +2430,15 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
-					od_percent_upper, od_percent_lower, power_limit);
+		od_percent_upper, od_percent_lower, pp_limit);
 
 	if (max_power_limit) {
-		*max_power_limit = msg_limit * (100 + od_percent_upper);
+		*max_power_limit = pp_limit * (100 + od_percent_upper);
 		*max_power_limit /= 100;
 	}
 
 	if (min_power_limit) {
-		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit = pp_limit * (100 - od_percent_lower);
 		*min_power_limit /= 100;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d253ce367476..481908913dde 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2373,28 +2373,32 @@ static int smu_v13_0_7_enable_mgpu_fan_boost(struct smu_context *smu)
 }
 
 static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
-						uint32_t *current_power_limit,
-						uint32_t *default_power_limit,
-						uint32_t *max_power_limit,
-						uint32_t *min_power_limit)
+				       uint32_t *current_power_limit,
+				       uint32_t *default_power_limit,
+				       uint32_t *max_power_limit,
+				       uint32_t *min_power_limit)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_13_0_7_powerplay_table *powerplay_table =
 		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	SkuTable_t *skutable = &pptable->SkuTable;
-	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
-	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
-
-	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
-		power_limit = smu->adev->pm.ac_power ?
+	uint32_t pp_limit = smu->adev->pm.ac_power ?
 			      skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
 			      skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+	uint32_t power_limit = 0, od_percent_upper = 0, od_percent_lower = 0;
+	int ret;
+
+	if (current_power_limit) {
+		ret = smu_v13_0_get_current_power_limit(smu, &power_limit);
+		if (ret)
+			power_limit = pp_limit;
 
-	if (current_power_limit)
 		*current_power_limit = power_limit;
+	}
+
 	if (default_power_limit)
-		*default_power_limit = power_limit;
+		*default_power_limit = pp_limit;
 
 	if (powerplay_table) {
 		if (smu->od_enabled &&
@@ -2408,15 +2412,15 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
 	}
 
 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
-					od_percent_upper, od_percent_lower, power_limit);
+		od_percent_upper, od_percent_lower, pp_limit);
 
 	if (max_power_limit) {
-		*max_power_limit = msg_limit * (100 + od_percent_upper);
+		*max_power_limit = pp_limit * (100 + od_percent_upper);
 		*max_power_limit /= 100;
 	}
 
 	if (min_power_limit) {
-		*min_power_limit = power_limit * (100 - od_percent_lower);
+		*min_power_limit = pp_limit * (100 - od_percent_lower);
 		*min_power_limit /= 100;
 	}
 
-- 
2.47.3


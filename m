Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BDAC369D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 14:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B7F10E115;
	Fri, 18 Apr 2025 14:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMGZwA6z";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930D410E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 14:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS8yafWnImEVDNW1eUfEjK99y41EtKhjTs+NbScmiHuZDwNW7PyDfYy5Aa9WTrVJdxGqwZwrt+CR8FVFY5C5Vajrtbe/21kMlBeRGXNGsCkgqEAMmnFMphMg+Xl1u1jomFzoukpL3ELDPmn7yV3qoptO9P/QWLLFTr+QAVjAi105At3oHNPjQyIv9vd8r3zj1FM+ZCm+Q7rSC1ouGIQnrOwSxt6OBYeGePg79X45606LrPajppWrOQxECmFJVYhJ2nEpVGGqTrzX6qIDu/DKiHsb1bssLex9SjhlneD3EJkjreqd8W0icRuRA0qYstTQ2T3+vjkzKosTqVza9o6+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjJjXiA6bYXU4l2KqJ9cEUFYTm5cAlnXztFhvmfjK4Q=;
 b=iY3mR3Vtxm7iG2DIdEl7XqfeEoGKLg6sNKGRh3y4SekM3TP5H2XBa4kOtTTYzEC+pbZRY8xKt6hlUM5pcl8MQEDsqIrce7l0OKpJCdhSxxscN7/KFEXVMw/JA7aGmmVhs9OVzFY9E7Elt6tnUt5FujA68Q24tU/6oXZf9T6BkJHTWUDywMWATDKciw2TYI+CmQThk9s6RRjQVpVp82u2Y/Hq0mDs/1q8mjiQBHf/G0c1vJCzqAhx0vUgqmPuYeB9AaKpiTisJcAX1XKBo+E+142NkM7u6VvAFVN4JLHU/PBcojoDy068Jixm6UDCbbfQ56S+eH6N5Lh4lWGj1XO7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjJjXiA6bYXU4l2KqJ9cEUFYTm5cAlnXztFhvmfjK4Q=;
 b=QMGZwA6zCnxrbAu1Z7GCmEWLL4xkcfmI2enOarOaZyj5vk/ikKrITWp/4EdLQR0pPIH8Shi+p51SyU32NCKdqNp3hY6LjdKkprDh49aG7fIn7QZlxF70PA4Q7bAYrM8AICdfIymkzHN8rhAycB4Zx0MPKSHBLXs/vweXOWPYSfY=
Received: from PH8P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::28)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 14:06:55 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::8e) by PH8P221CA0028.outlook.office365.com
 (2603:10b6:510:2d8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Fri,
 18 Apr 2025 14:06:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 14:06:54 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 09:06:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v3 4/7] drm/amd/pm: Use common function to fetch static
 metrics table
Date: Fri, 18 Apr 2025 22:06:30 +0800
Message-ID: <20250418140633.420887-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250418140633.420887-1-asad.kamal@amd.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5658e000-8d8c-4da7-ced8-08dd7e824672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tVhAM0MoVzYmMwiFMO3jTVUGojHjonyBGQYCeGBmOpU3g5UWEqiAOupFvG26?=
 =?us-ascii?Q?PjLHIR4MAGRdUWamyNOJX04YbwoiuOsDFTIR8GZ92f95ZUTDpQU+i4MBX0si?=
 =?us-ascii?Q?kFhCaCgNBKnl9goaJRRJ8KDCO7Bt8sooQxFQ7D41Dln5zqwas/DOw2bV8X/5?=
 =?us-ascii?Q?aZgt2LNNLk2rmuqlZrjPsvvHCUjvjMnSxxPc0hodSTOAFnBCGx2/e0EnYN11?=
 =?us-ascii?Q?zbrNLNJO7W+szTH1U7Qn1Npw7/yLD5F1jgeT6Gwo0/xz0WEqP9TnxRr2MZIn?=
 =?us-ascii?Q?4v8EyA1jYKHb+GFGfk1bZRO7A+FwWv80B01lJqPy01PhaoXLsY04AtYf6WUN?=
 =?us-ascii?Q?i40jcKNxhAwj54g5T/laUFiBNhPgNNBIDBiqPNLIBKyHNQi3t1sz6dFli+Vr?=
 =?us-ascii?Q?Ol1N9XfSpwDKp7o1MMISFiGQ7Ia6aJPohTrE0T5jZHOPAR4zXZIYVg8L97NT?=
 =?us-ascii?Q?Ce7yoIIJH5VJjDGl33yGlLRtB9TKlcYGXkGrAQ3ijego8QdwRw9jqFWZuTmb?=
 =?us-ascii?Q?IFsmRCuuTSzrqfbyNSkqgwMoPYUbryz0wq8qdDDq4Ja4kFv285cDWCS9GNqy?=
 =?us-ascii?Q?wAfk2Xgv5ilp02ZkN9b/dsWK267SQoYu7skUtUIKUnupwhZpuiqjInNTCjQS?=
 =?us-ascii?Q?XCF5z+PjhTwpW2P4XHJ2JTBVBU4XYfGxIyqETpXa9Wft/3jWgrL2hISsKKDZ?=
 =?us-ascii?Q?O/OYER8eTpnn6Gz04jxPjTINPNFRSvDjXOW/7omI7SYlFuYNJV5xDLF1GXih?=
 =?us-ascii?Q?tYBw/gzLwSRbC6bx1VnohXXopvj4Ikf3qvo0Bl4pv1cb7/d25N4IZNa3r1Qc?=
 =?us-ascii?Q?cQrIHo7AI5Rbz9xEDWO7v5GIQmR7CxcdstXz0M+QztA/YhjMaFDm1o9QLLkG?=
 =?us-ascii?Q?3pjWSf07DPGdglhr1vNJhnaieqSZMsZGqNbKr951Z54HiKjRjOD2CpL5uPKW?=
 =?us-ascii?Q?BfaWz+6seALYRieZZMSlE4tR71LR+gvEEj1VzscWv2zcFcCJh1m2Y66sWn45?=
 =?us-ascii?Q?0UWijH7pT4/4f52E7NswdHUWd9NW5NS90sHv5ZAn4JRkJRBuTrNUI8dVEpGw?=
 =?us-ascii?Q?BAQDr8ueQk43dhy4WKfFtPhw5nfsktV5Jsn1w/YYYfFG4GHyYIUFNuv+wSxc?=
 =?us-ascii?Q?U0El92v9W9rD9NJ8jdJP9nvWsq9/B2stT0HYs5ZN+077GYLw2CWPSa9TCUO+?=
 =?us-ascii?Q?IX0wrxVvOafF4kTIZsOWb2CzcWrKgVvX451tGSVHMDqYgljqNv5K7ha7nbNO?=
 =?us-ascii?Q?aaim8rHjSmTZSFKbmGkqRpFXu0nAq5QdDK+zjdZet8wEt9UlXB/KIYTJfuy7?=
 =?us-ascii?Q?OqJM+4P0BKpIvuoObA5r62uDTV4NGIFNgwa4ecoZLgD7GY1AonuAoZjxa4Ri?=
 =?us-ascii?Q?D7Lkn8FLxNyZMr6xb/o9P/mevmvMPsdTx7YYrCNObiumRRl90BfbLydYVgvo?=
 =?us-ascii?Q?E8UaQWYrIZJPcxzsE2vwtUobsmxkqrdx1ltb4cNrVHXs1jN1Z9i2+cxaAVOb?=
 =?us-ascii?Q?4KLpzgsh05MNAz1bgjFUKMVX2G4PjuQ04vJO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 14:06:54.7849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5658e000-8d8c-4da7-ced8-08dd7e824672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
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

Use common function to fetch static metrics table for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 22 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |  1 +
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 5d4437e413cc..533d58e57d05 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -187,26 +187,6 @@ int smu_v13_0_12_get_max_metrics_size(void)
 	return max(sizeof(StaticMetricsTable_t), sizeof(MetricsTable_t));
 }
 
-static int smu_v13_0_12_get_static_metrics_table(struct smu_context *smu)
-{
-	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
-	struct smu_table *table = &smu_table->driver_table;
-	int ret;
-
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetStaticMetricsTable, NULL);
-	if (ret) {
-		dev_info(smu->adev->dev,
-			 "Failed to export static metrics table!\n");
-		return ret;
-	}
-
-	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
-	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
-
-	return 0;
-}
-
 int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -217,7 +197,7 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
 	int ret, i;
 
 	if (!pptable->Init) {
-		ret = smu_v13_0_12_get_static_metrics_table(smu);
+		ret = smu_v13_0_6_get_static_metrics_table(smu);
 		if (ret)
 			return ret;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 06bfe2488d4e..8d1bef169812 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -739,7 +739,7 @@ static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
 	return pm_metrics->common_header.structure_size;
 }
 
-static int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
+int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 2a8f42dbd9f5..c7a07aa5ef14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -71,5 +71,6 @@ enum smu_v13_0_6_caps {
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
 bool smu_v13_0_6_cap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);
+int smu_v13_0_6_get_static_metrics_table(struct smu_context *smu);
 
 #endif
-- 
2.46.0


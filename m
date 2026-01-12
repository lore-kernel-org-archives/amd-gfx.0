Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50103D26D97
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D620010E0AB;
	Mon, 12 Jan 2026 10:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xrr49C5p";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F144B10E0AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:13:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXfeTwr/p8M0LAgHgr3bDRDFcdMH0WFiiX8S9RWm9R36uEy35a8CVhM36S+fgV0KJ0R/MzcPZQwJf/hbqAi4HJ33deI7ypNg5V30jDaVJzKYjIcf2JGDpHcj7BUYeXx14g8E+jKB1QKR4gF1wr71GK2m+0i4MnigWr91aXXejz8F2Ak5Sj866oCMfWjKtV5S4oSvM6/UeTf3488J7cTdMqhqrL6YOst6wznOqnpFoJShHykMJyytNVXa+WVZhn3H9D7TufiMt/FPVx1pHe+pb1VIn7jLuGTnU8dDGnu5uah/WCxRGFYNv0DXGLp8/o4epNgdOE7N5ydhIiIs8Y+txA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqY7dAJBc86JAzqXtKRvg+2hchqJcntxPo9ci0/Cq4s=;
 b=Z58Ei2LHZDRw2rqToX28WqAWfWXAwhIdX3mWbkEm2U6Nnm533RceYUBqtEQPT1Q3eElCtoQnWegXGCz0FryOutmLvJ3TSUTuUxUuNLonskBzI1ddLRTlt9xDWJOvqr8mdrJjzNWNpWsnJ7DA2ZReOlnTUqXoDOZPGbiI07CdmMpV+g1yrDIUi8bA0iuJnZWw86rgE0jTQpVPwa49QXU2EBs3vy0u22Jfv3A1D1ceCF8Ktz/2Cr1CwYVlidlWEYIQ2kfG9SWpiUZALwHnC9GgpPoeA6gdkDd8TP5Pi1o9kZmWqdjECVtLjiuLE7fV+w282oSCNcGOYjnhS4GhRMSlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqY7dAJBc86JAzqXtKRvg+2hchqJcntxPo9ci0/Cq4s=;
 b=Xrr49C5pTrpGPi9rzdrBeGzOt/VM1giLZtR4Tmsri/hdeCV2NsDENbBVg/FVQMR3ibhCi9M/pYKnvMFKta1001fwvbgyxTAYL3IYMg5LMExqF3BpDyCTBr14CK52VYzOnTCvb51FwVaurP5RtOjvxLZ1Wq2PqCFAorNrz56yKks=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:13:05 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9b) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 10:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:13:03 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 04:13:01 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: fix issue of missing '*' on pp_dpm_xxx nodes
Date: Mon, 12 Jan 2026 18:12:47 +0800
Message-ID: <20260112101247.2654442-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bc2a02-3aa1-4350-44ca-08de51c32c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uYoNgmB+M2sps44Sx1C3SouZ01ujVNUPlM8ZeVgfYZ2AGv2hfTIOATHs7fkb?=
 =?us-ascii?Q?6kGb1GX/G4OgrpjCK5xg7sz5jfxAK2W+7vhLG+FxKtq8J7uc9QkTCtK4V1Re?=
 =?us-ascii?Q?+Lw2Yq3xsS83EXY9t/dkW6nXW32oN3qg+kOb9uXnGsg3LbRC5m9+QmCSFZRH?=
 =?us-ascii?Q?ozSq5zPwa77lnPoTpCrHQUaYNluURP/agOhJXpg92itPa2/PgZx2thmA39wu?=
 =?us-ascii?Q?1yCJp/cPN6tWE8ynHmWII6K728lop6FqROqKhj1GQaIisdc4/+s771XYpbRd?=
 =?us-ascii?Q?I2U1036ZhPkYI18NVlu3w39LHDxLEKconWsQG84G9nnwnfah4AsqAcNpk/dD?=
 =?us-ascii?Q?CPOSceNpF0z+zCO18EzJ/kWEuRu+AM/QvGb6P58wvHb4JFyMSnr58WVkqjUZ?=
 =?us-ascii?Q?AHOR/Zfqg+alEHRzzW3FaCIqKbkXzoaM3I8mlbtq/5+p1W+ygxphJ/k7GzeM?=
 =?us-ascii?Q?N4aZlUykK4V+9oSHoZMn9iicKR5LMWABtXnAj5LDg86Yy3EZEtRAwJPDDALE?=
 =?us-ascii?Q?IgInHNVZMIUjqmOitgYh/4P5aH8rRBydXkcKW86qLzGjqA78kkzdhuJhv+Z9?=
 =?us-ascii?Q?FPIG+HnBoToM8/XNw+0V1wy3daHq98sxEgA8QLRnqQUfoKbOnCQLh+HMO1F6?=
 =?us-ascii?Q?n4p9LEG7QN8FgS+7+BRnxJyH41hXaKaMfJ+itfu5FPQ1Lo4+mRbpP78zceo5?=
 =?us-ascii?Q?E3CZTgxFM3tx0l14vVLH7PrRP5cnWJfLfBVDBkXdaD08ifcb2mX36wlepYnJ?=
 =?us-ascii?Q?9BfMGyHcUNnxT6o2Aje6WETcrqXhyyc2sny43LggYUW5biTV8KYlSqYgk/4M?=
 =?us-ascii?Q?xPnjuOsZDrYku+fidXm92AS0El72aCBnABJBA1Wbedudsi9fw24zOYEk9OWE?=
 =?us-ascii?Q?4BuGg+sF8MNHEaPj6IuHoQyAN05GVe5UxBr/Sc9es76g+I2GD4B38LP1pzip?=
 =?us-ascii?Q?Tm1enmx0WVIjNjmrF/TtD2VL+KVdAIP+QtwO3UqYi8JkpgUp1gcPPJCVJLS5?=
 =?us-ascii?Q?4k/RbsI754Q02KK0advriou+f01nBUNqNYICGGQLZcr42eHSL85plEh6CcEi?=
 =?us-ascii?Q?hKd+2L9jBGC36inz8fm/c+Xe1uI0ftDhTAD5YiPLYVlTUb+ky/1rZsfpn/lU?=
 =?us-ascii?Q?ooGPnTpzbH+KHs20/NNhqkVCf0cjQ3WhDNieNofR5Sy0gSRF8LgX0+PGiLZ4?=
 =?us-ascii?Q?+wwqNucHsODGgcjwOXqSJ5AVKJIVZTF4mErupc5lthyWQCKsUaJ9yWJjW42h?=
 =?us-ascii?Q?mhCJtp+FRDSBNicW9Koq9x021uTY/Lme6+YpPQzSnWH7N8gm4hvDHCiTbOMV?=
 =?us-ascii?Q?NRrt6AYzweAz6Tn2Ej2FdgmJgXlPCEd62wmuqfVaq8YujTyCM3WJVTD6fRRa?=
 =?us-ascii?Q?JO6tDd0bqszXHg/3ZqY+JKzeCnMchm86SajiFdJDv/Yvhvt4TUt5D5wS+sCw?=
 =?us-ascii?Q?XFTReupszxTjiY+4KjEqkwW5LGnsMZM02WYdXFbOrjNXD063i7WritFPjUb+?=
 =?us-ascii?Q?qR2w7PQ17LMW4S2XLnJpXRLzFuJxjcz57O7F/J3fvu2NqL6c9J/YKGP4hssq?=
 =?us-ascii?Q?Rlf7LRLIb8H7RcSL9MI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:13:03.9908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bc2a02-3aa1-4350-44ca-08de51c32c8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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

refine the code to fix '*' missing on pp_dpm_xxx series node.

e.g.: missing '*' on navi10 pp_dpm_sclk
$ cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 300Mhz
1: 1930Mhz (the symbol of '*' is missing)

Fixes: d259c895d622 ("drm/amd/pm: Add a helper to show dpm table")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 31 +++++++++++++-------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index e0a508653b6a..60fc730bf81d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1210,11 +1210,11 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 				 struct smu_dpm_table *dpm_table,
 				 uint32_t cur_clk, char *buf, int *offset)
 {
-	uint32_t min_clk, level_index, count;
-	uint32_t freq_values[3] = { 0 };
+	uint32_t min_clk, max_clk, level_index, count;
+	uint32_t freq_values[3];
+	int size, lvl, i;
 	bool is_fine_grained;
 	bool is_deep_sleep;
-	int size, lvl, i;
 	bool freq_match;
 
 	if (!dpm_table || !buf)
@@ -1225,6 +1225,7 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 	count = dpm_table->count;
 	is_fine_grained = dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED;
 	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
+	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
 
 	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
 	is_deep_sleep = cur_clk < min_clk / 2;
@@ -1245,22 +1246,22 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 					      freq_match ? "*" : "");
 		}
 	} else {
+		count = 2;
 		freq_values[0] = min_clk;
-		freq_values[2] = SMU_DPM_TABLE_MAX(dpm_table);
-		freq_values[1] = cur_clk;
+		freq_values[1] = max_clk;
 
-		lvl = -1;
 		if (!is_deep_sleep) {
-			lvl = 1;
-			if (smu_cmn_freqs_match(cur_clk, freq_values[0]))
+			if (smu_cmn_freqs_match(cur_clk, min_clk)) {
 				lvl = 0;
-			else if (smu_cmn_freqs_match(cur_clk, freq_values[2]))
-				lvl = 2;
-		}
-		count = 3;
-		if (lvl != 1) {
-			count = 2;
-			freq_values[1] = freq_values[2];
+			} else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
+				lvl = 1;
+			} else {
+				/* NOTE: use index '1' to show current clock value */
+				lvl = 1;
+				count = 3;
+				freq_values[1] = cur_clk;
+				freq_values[2] = max_clk;
+			}
 		}
 
 		for (i = 0; i < count; i++) {
-- 
2.34.1


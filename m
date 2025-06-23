Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B8CC77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD36410E1E1;
	Mon, 23 Jun 2025 09:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xUPi+X9t";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6609F10E1D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpnNZp7r03F23eRiRaezvqvdg/9x1DXyy+z3QjjNzL9aEQ/+I6yx27tO9e4ogR/diNUTnXfQghz9pMPmDYF1zV/oQN9KexNe0zdupIb+V7wp00zNJFbYTBVDS3iGWE631YM4S8JFyPokbzROJ1Pzt1gyUlIyLeFRFVAG3umu/PDysF+jcHNPDlfNWR19hTdXLRgGSxQ+sCaru/Bu1tbBt+Gg9YDi0auhN1fJXHuK0qtx3m9kt/jGjd7sOX4NuNmq726vDvf7I6Uz5tiDpUFD8ly15UKBt5ljZ/1TbZBeL5rFhZf997whOUCWB0Rbeq58Sh/vzv8yL8LnJAmvwCBomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzL85oRwbd06jyVBbx1r0aDnMhzQ4dKMZ87pElJPc4c=;
 b=FHDwcdjd+LscMnh2QBndtddboH+g43ztLxCR67tvS3A/8fUEqp3daDcBowSvRrZWYS88/tFOqnbQi1Dr0UG8j5AFvyspDMnlPmwOLoj62CmmtdOBiD2y/QnpV8mLPhQJ5O+rh6MW/B1fSjLKLRGl4Hd3PFnuz8tsfvNcgpdhn5d0lEwddE2inISyvPK1plamn8N/huKX3uXLeUqkMngqb55IMEzf18JXaRw4ify/NVKAh3w1yTGqQ63FSDJCwer9fyuSbpkO2R8HO2ObCclXFxHBF/vm6M8Yq5sSfTS59wIvKR3heorGOjB2K0VDVEfGbCjVSa1DeRVVehhJizgyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzL85oRwbd06jyVBbx1r0aDnMhzQ4dKMZ87pElJPc4c=;
 b=xUPi+X9ti89KRnXhv5DLkOhWxQQCzWqWAPIR2cWSalZuBC803f//NE13T8KoL7QtIt23/WbwnFsmllG3n/NK9eBwMvae84Y4CLCKUtkmPv/Io4nv5T3MNXaSHGsQZKHUTT08X7QMAhW2wZ2KmV7kiPWeF72h1fbcdkJ5VU1VdWg=
Received: from SJ0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:2c2::6)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Mon, 23 Jun 2025 09:04:50 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::c0) by SJ0PR13CA0031.outlook.office365.com
 (2603:10b6:a03:2c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 09:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.1 via Frontend Transport; Mon, 23 Jun 2025 09:04:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:04:47 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Mon, 23 Jun 2025 04:04:46 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: revise the pcie dpm parameters
Date: Mon, 23 Jun 2025 17:04:39 +0800
Message-ID: <20250623090439.959876-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS7PR12MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e871a1-2380-4585-bc79-08ddb235027f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/4vlK26ba9NcN2ARQ7QkAKHhxqHrxqTS3bEinT6ebYQPpSnpkOB8l8ybVIWq?=
 =?us-ascii?Q?p5E82Y1azqWtJjdXkFaYxL0fBb44YktQz9aZwLKSHhvh0GkULyBPnS284p/t?=
 =?us-ascii?Q?w42oSbaKJDkBgnXRXIR2MkPqdsTkYCdfUE0CCQ/NkJUH/7x+E7IySYIlbbs2?=
 =?us-ascii?Q?htHzrty+vpirQ92WCdGnCrUvDzKycDTOVhjuyF+KBs/rFG/FeGj3xH123ZQm?=
 =?us-ascii?Q?7Wv08kZRfNo1VgpI4KilX9+A/RNFnwP1iXTovQhLwkzIwDlSZx1xP/U2JvF7?=
 =?us-ascii?Q?nYb1Co0RNsFycxd867Avo6Tl+01mXKjihAOY33iE7TqX0COybjgsCtoaTZnc?=
 =?us-ascii?Q?+0eTycqzxWaEWvhxG+aBIX+wHgGqUUcSMNHydzoCIB0kOlsSpbEjB6Z+Tr9w?=
 =?us-ascii?Q?4uHk21k7aU7F2VW5OH7YEk58AFgGt9qxpgPG2nEBHrPmS1WPE+OjhGdUU9c3?=
 =?us-ascii?Q?qpdIAIps+KvHrK5xHgRPwrXmc3vbDLSFN7JMDKO7owM0+zcA+Ud1aVv4VrjJ?=
 =?us-ascii?Q?jR2yHs87ldfdOFJ8N5oWbvLOxrSljssiDoSKqyZLLQIMAwaLQRW1/Jg19raI?=
 =?us-ascii?Q?PfW9L1g1eDISQW0Av4s9dLdqWunz4BdC11QekBqHOzprNzLQlmMLNqmWk7dQ?=
 =?us-ascii?Q?NE1Je0UmBSE+3f4yWTlC6RArhlBZqCjPMLxNCHoqlDJWT3YMO88CV5ApPtRO?=
 =?us-ascii?Q?JeV/OmeOX4POJkl8dLDkoLZOSEyBDmbgsJ8fDBD/OeBhhfzKxzLqHadw1JdG?=
 =?us-ascii?Q?A16VjzCQXUxlkUHVtzpQLs9I7YdICi9b4kZFHNipg2QvBa7RABffqHQPllnz?=
 =?us-ascii?Q?aDaa+HwUet25zjaH4ty4u3PxQ+Y80QuDuQWmQ9FH8QB+x1shp+sB3V6nXsNO?=
 =?us-ascii?Q?mWH7LKNHVvVLMQf4wuREvZyIvu1+Gbhvcq8Fqqphc/VePgKqSzyDBaCzZtM8?=
 =?us-ascii?Q?Q3pm4q2Gxm1jr0IKjeO5lVjqVZARyrJnFDJICzBGB02xQN2jebnIftIX4xTM?=
 =?us-ascii?Q?EAZj2DwIijcuiQwWLIlo4+o14ZHAR7iG5rTwMv8h7HkkZkbsign3xzssjVAq?=
 =?us-ascii?Q?VFrw/m7XWQkEv82MRCrxJdWBKiL4p2oRC+4cT4EHIy16GBa7mitbhVACBUey?=
 =?us-ascii?Q?IppJGkSAcsLJsWS9zwT20H1O1xoe5aVs8d5SH0rg2lutpJoPkJ9aCvj24Ek3?=
 =?us-ascii?Q?BQh3EQY8QyyLTLKa2wMjmQ/bmOlYMqvBqkI90m+MsYbAQBLvASZg0EGiOib+?=
 =?us-ascii?Q?YKDjNEsoW/KFR7JgeP7V0cRV1yntatZ5s3RZ4ix2MUZQxmYo2Xtfs6i1J+Ij?=
 =?us-ascii?Q?X1/QCBjUHZWDrBD1xJnnyazFCJbkfKYPZRxS0kS3ycsSPKQCq6iLs6IlLXsr?=
 =?us-ascii?Q?o0xlnuvLlJNeQBvnR9j9xTe/D1dJaTgyhH0+QHlR+BrZimidH7YHTRh3mjAx?=
 =?us-ascii?Q?K/mw1W/lD1muPEleY+kD3IAHhIqjir7L9cs4PnvecCgZih7twmlUDlH9lakf?=
 =?us-ascii?Q?O7zpCJz2kzVtRxbZA3s/XXI4r9lTuV5BVt5+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:04:50.0083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e871a1-2380-4585-bc79-08ddb235027f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
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

revise the pcie dpm parameters

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c      | 8 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 ++++--
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index d7d5ec247624..aac202d0c30e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2456,8 +2456,12 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
 			pptable->PcieLaneCount[i] > pcie_width_cap) {
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
+			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
+									pptable->PcieGenSpeed[i] > pcie_gen_cap ?
+									pcie_gen_cap : pptable->PcieGenSpeed[i];
+			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
+									pptable->PcieLaneCount[i] > pcie_width_cap ?
+									pcie_width_cap : pptable->PcieLaneCount[i];
 			smu_pcie_arg = i << 16;
 			smu_pcie_arg |= pcie_gen_cap << 8;
 			smu_pcie_arg |= pcie_width_cap;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 257082c03865..e084ed99ec0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3193,8 +3193,10 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 		for (i = 0; i < num_of_levels; i++) {
 			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
 				pcie_table->pcie_lane[i] > pcie_width_cap) {
-				pcie_table->pcie_gen[i] = pcie_gen_cap;
-				pcie_table->pcie_lane[i] = pcie_width_cap;
+				pcie_table->pcie_gen[i] = pcie_table->pcie_gen[i] > pcie_gen_cap ?
+										  pcie_gen_cap : pcie_table->pcie_gen[i];
+				pcie_table->pcie_lane[i] = pcie_table->pcie_lane[i] > pcie_width_cap ?
+										   pcie_width_cap : pcie_table->pcie_lane[i];
 				smu_pcie_arg = i << 16;
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index e96364856e74..c96fa5e49ed6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2781,8 +2781,10 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 		for (i = 0; i < num_of_levels; i++) {
 			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
 				pcie_table->pcie_lane[i] > pcie_width_cap) {
-				pcie_table->pcie_gen[i] = pcie_gen_cap;
-				pcie_table->pcie_lane[i] = pcie_width_cap;
+				pcie_table->pcie_gen[i] = pcie_table->pcie_gen[i] > pcie_gen_cap ?
+										  pcie_gen_cap : pcie_table->pcie_gen[i];
+				pcie_table->pcie_lane[i] = pcie_table->pcie_lane[i] > pcie_width_cap ?
+										   pcie_width_cap : pcie_table->pcie_lane[i];
 				smu_pcie_arg = i << 16;
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 581a4e59130a..3aea32baea3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1518,8 +1518,10 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 		for (i = 0; i < num_of_levels; i++) {
 			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
 				pcie_table->pcie_lane[i] > pcie_width_cap) {
-				pcie_table->pcie_gen[i] = pcie_gen_cap;
-				pcie_table->pcie_lane[i] = pcie_width_cap;
+				pcie_table->pcie_gen[i] = pcie_table->pcie_gen[i] > pcie_gen_cap ?
+										  pcie_gen_cap : pcie_table->pcie_gen[i];
+				pcie_table->pcie_lane[i] = pcie_table->pcie_lane[i] > pcie_width_cap ?
+										   pcie_width_cap : pcie_table->pcie_lane[i];
 				smu_pcie_arg = i << 16;
 				smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
 				smu_pcie_arg |= pcie_table->pcie_lane[i];
-- 
2.34.1


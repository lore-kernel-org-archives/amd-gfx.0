Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F9AC87FD1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 11:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCDE10E3CF;
	Wed,  6 Aug 2025 11:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KIDtyM8y";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D592610E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 11:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLSLocPw+i3m8uLYKAD/0QIYLtemcak8xRZqzQNu3YN0xYVhDasQwuEXtTZRHFuMv8GuyJYD6wz/kIwUx+mL+DNItSlpf1ndDT09QVlEgThX5WCAEi+QHo2tzC4vgMyiYdG/srsZXdW613M/u07fyD7rJQGccn8UntJnMJ121FSoL00FMkj+Nrbpnd0ZLKtlMfyEVYT6KgiQ+qOTT2kVorlEcVyzPmlApnVOlTUSgzBJBSeW8YlKZQrJqF3Gu7T2+7HWVVrk6WC9pSed/LA88k0IKf0f7OXz1ZhFo5QIFH/q4gcXBEllx89YOuqMW9hF8uO7afLK3/6v/7EongZtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYcRIPYU4kdE551sYDPtKYTG07LkYTo9wdkpGxVjFJw=;
 b=g/S0G0EHMJ3zsDd5/EStkUBVCTIUZ3KDQRoxny2/46VKAo9nTF7Nor1IGUCSVu9IsvDMlZ/TEmh6GB9ON60DG3szqB5QTHE9l+aob0CYP3jWXsx+x0kK9pNdZFtVm55BglHi57F7XBMrix2mDJ1ByNVYX0Tj5l4wCXlB9bYozn9D0Q8/GTuAh3VxnjHAUXsmUxswL+qdlBfw2sepBVbBNKeQ93qbMXHeUUq/tBBgsoRa3bZvu5/XIUfg3uk0vqxuBXwx72zqYCWxz9fTMgMGNUkuo5IArWnlq7TJtBcZIOj8Fplxvs7CbI+23rt7dfh5EwqOp0NygGxt4zLiFdmI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYcRIPYU4kdE551sYDPtKYTG07LkYTo9wdkpGxVjFJw=;
 b=KIDtyM8yaB5Y1zcUeNdIC0a4J0IBqhgGekYl1BDZfZ0aJA0XYlXBdBAZ+T5tBRt08xWeo1e3r8IbYtYZEsKmMs5LJADbTcww8m2UlBd4DkVWBRpe9gBr0j5SKwENUj6Bj1zW4CLqfh1fJQrXjB+jPHZfPDg2U7/H+UWEz6INgbE=
Received: from CH0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:610:119::18)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 11:22:33 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::b9) by CH0PR03CA0383.outlook.office365.com
 (2603:10b6:610:119::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 11:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 11:22:33 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 06:22:31 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Remove cache logic from SMUv13.0.12
Date: Wed, 6 Aug 2025 16:51:54 +0530
Message-ID: <20250806112214.1804907-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ce2908-ca93-45ad-fb0e-08ddd4db89dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOSR4hTIhXgTs2qghbGqiK9J78ebsmlJsgbjsloq+73OzqMctvm/0/0Gq1Ma?=
 =?us-ascii?Q?qtdzhNZmjvrHCMjbJpk/TnTQJhGN3VcdLyo+9BPuLnTo0HHAl4loY+SP7vmZ?=
 =?us-ascii?Q?0qVWt4HeqxILWe+rffrtVu9Rn0CS29B5s+RLraDTxilNe9EyZx/UtSDoNvf5?=
 =?us-ascii?Q?PCpmTmEgEu+aBtQE/saA+7ZoSgXdMOO7HmXVOzs6C7w4axbE/VTr/kCHbeSj?=
 =?us-ascii?Q?8zyaQc2Nlgws/3grzqbWCFnY78LXR5rmXEm2kGnBr2M/TA/Xg9+ck1RRloqb?=
 =?us-ascii?Q?W4e2HJ2inEhWRnqeDdlcpvJG4OOsiYAr7/1B4LcHzE2RUs0yCosgOV/yNMoR?=
 =?us-ascii?Q?wJdo9KzpNseRK53wzcNgrnz6nucIjw/YgrUsInDoxjelsOcw2hnq811EIscb?=
 =?us-ascii?Q?s6RWFn3xwTW8RIv6JDX6YOJ3wPLyJEInjL/Gu/KuS8V5iv2Rcay863RVVEIc?=
 =?us-ascii?Q?55YZtY6MHr7H8Onrc5E3Acdzz6K0CgFY5r3AdAu6hWuKPsFGnHM71De2DRqo?=
 =?us-ascii?Q?WzShnA21VyB4TYVKxYyYHZolTSX+zarvxAhhCjBS0Umkn4kqZEjtR10XaTzs?=
 =?us-ascii?Q?m9B+HmVNmvdUSsCoiLE+2547+3NWET5llqappngLnAGCv5fuF7KeIttNayoc?=
 =?us-ascii?Q?4MQQMKfudfpnXmmq24XX67ecVVmi74ZOTD+Pcj7SdARh9p6+BqD5BCFoL+JQ?=
 =?us-ascii?Q?GnNbg6jluZlOJav7WNtkcRor4BfpuM6PuqH/XCHcxbpCUpATAHjzQxXXhUvr?=
 =?us-ascii?Q?ylMR4nvUgi3hSNnLfMgDhRYstl7dQNwc7Mm+8mPP+e7JESVjR7/fj1ji1uZ+?=
 =?us-ascii?Q?iIBNetxMc3rOJ6SHReaz1yu8jlSEM4I6DF4BMW/LqGBS81tsmDsZocRIVKX2?=
 =?us-ascii?Q?vQvC6sSMBcoW33gptSO7gzi4W/PHpJOHyivqbFJEJaTVIZx48XXqlhzF320G?=
 =?us-ascii?Q?bpq7M6lqh0l4wAFN0ccBz7f1CqcWXM0AMbl8s8I8GIsA2XPN48VkDAvcsN1v?=
 =?us-ascii?Q?FMdnIgiiA3Oe+QVfJbqhK9gmWzn0AMQoEYZ3BptzW5lX/SyUKYaCPFzbkaOc?=
 =?us-ascii?Q?oJj//1elP/OtsqMDCcKOvo9OMOLeUKT3iZvonNyxosbTrqhv+bn2AQ/cJRnH?=
 =?us-ascii?Q?dXJBL1kSNZn50dTeGdhpPFuY65sHmKh6C+0eLdviKNW1JHfzBl0bDf0ALplU?=
 =?us-ascii?Q?el3wwRu+7U0tpYTj3nf2JIIZnkKayeXVqT2g9QCSUJONHjlviIk6B8BkUSRl?=
 =?us-ascii?Q?sh/6uGNe67CUZthZS3Gt3d6gGQJ/GN5TNsyd4nglfsiYO8nnwtHd63Rnkk4u?=
 =?us-ascii?Q?d9ob2oF7WWju0L3O76wL6Vdv+DdtyJC10ISCSGjDE2YP5bMXgSbkkpEexev5?=
 =?us-ascii?Q?/dkePG1nzA7ojoocnFa+HHRDRblPsce06hQ0XWoerUaKzUMRaiHOjF6KJCDH?=
 =?us-ascii?Q?OoqR5XSxV/PfJkhKZpwmHay6v1wkmwLJec9Ivt6xcaCfeq0lvcO3dVxk5bsV?=
 =?us-ascii?Q?Dm61OCXJpm+MbA8JRUTrhesUcgt/4teZIGYB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:22:33.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ce2908-ca93-45ad-fb0e-08ddd4db89dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681
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

Remove caching logic of temperature metrics from SMUv13.0.12. The
caching logic needs to be moved to a higher level.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 30 +++++++------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 920f60da9c5c..aa427fa8ddd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -83,7 +83,6 @@ const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] =
 	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PIT_BIT,			FEATURE_PIT),
 };
 
-// clang-format off
 const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -361,31 +360,24 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu, void *metrics_table,
-						 bool bypass_cache)
+static int smu_v13_0_12_get_system_metrics_table(struct smu_context *smu,
+						 void *metrics_table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	uint32_t table_size = smu_table->tables[SMU_TABLE_SMU_METRICS].size;
 	struct smu_table *table = &smu_table->driver_table;
 	int ret;
 
-	if (bypass_cache || !smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time ||
-	    time_after(jiffies,
-		       smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time +
-		       msecs_to_jiffies(1))) {
-		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
-		if (ret) {
-			dev_info(smu->adev->dev,
-				 "Failed to export system metrics table!\n");
-			return ret;
-		}
-
-		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
-		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
-
-		smu_table->tables[SMU_TABLE_TEMP_METRICS].metrics_time = jiffies;
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSystemMetricsTable, NULL);
+	if (ret) {
+		dev_info(smu->adev->dev,
+			 "Failed to export system metrics table!\n");
+		return ret;
 	}
 
+	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
+
 	if (metrics_table)
 		memcpy(metrics_table, smu_table->metrics_table, sizeof(SystemMetricsTable_t));
 
@@ -544,7 +536,7 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 	else if (type  == SMU_TEMP_METRIC_BASEBOARD)
 		smu_cmn_init_baseboard_temp_metrics(baseboard_temp_metrics, 1, 0);
 
-	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics, false);
+	ret = smu_v13_0_12_get_system_metrics_table(smu, metrics);
 	if (ret) {
 		kfree(metrics);
 		return ret;
-- 
2.49.0


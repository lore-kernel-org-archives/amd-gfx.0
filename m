Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F117C369B4
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD92C10E7B2;
	Tue, 15 Apr 2025 14:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8QObEI0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0472610E7AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9oZiOXZFmJ8ZmRY+ZAx8NWR/pgxmC21G3R3m5VVdmvDUqTgj9CzzAWhNns6tGykaHod55OrtJhmoxHKuIG6TQW6eBfBY503eJs3vNenH/An7slcohGhjRQVjIkByS5+zqVLT/B66gT9EWrStKy54ZHQQZdGR4SqY/uAwU4UudagebYpW8m0PshswrDAIhRbGBUFrsgwG7nMzuDfbB3QG8Ap1CVE8PoR4h+fgrfjd8PrqMSE517apTwvgufUb++dVkJgyVUswX+AOl2YQNFudOjH6jzdyfojNoFMtH1bAhlbS12+M57V0dq3TXfYcPCdTuAIp8s8RVQkmMbFEBZueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5nDY8tFdAI4Eq+RnvqkUkKcaZUCvYPzE/aft4tieXo=;
 b=CaLYbEBHJeBVIc38IDhNhlbxe0BTcMoiJe6Yxgo15/ueeNfLpf01eGf8ANI4603u7Rypodh2mZsr7Voc+cUS/KtB7lVR4VgBS4fkDPNNbSHjjOzIplpOulfzQCtDQHi5LMO8sqpbczBTCkAXjubj5KT4gfS+hNMutTGTNCUP6nbENUi1GGaf3seXOfXUeTd0SsEz/TvZQ7VRD+vXCkUk+C2WCE9fQ/5QSz9P+sWwyYo3Paw3zicRSgJPuTy4GkSQbEB30PastUgJzr2diHpWmWMJUBqaZ55RgASmzVpjq47dEJ9kXVfTdnFpyywBAY9kFMiU7Hr2wanxaQn8ggMueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5nDY8tFdAI4Eq+RnvqkUkKcaZUCvYPzE/aft4tieXo=;
 b=L8QObEI0EpVWS/j/LL9FRmNnvvZVf4rnMgUb9GCSFqQL9zu/LK0wo1K3QNFGIhB9YJerWg4pw8+PXajJ2RCuAFa3cOU2cDCnGGWjssEd8VolJlyfWf2GTV1FIA/uN7tAbh8R3WwqXwTAdJmWX+d7Yv+9kM4rm61xEOjc0O7MH5A=
Received: from SJ0PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:2c0::35)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 14:35:51 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::42) by SJ0PR13CA0030.outlook.office365.com
 (2603:10b6:a03:2c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Tue,
 15 Apr 2025 14:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:35:51 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:35:47 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 4/7] drm/amd/pm: Use common function to fetch static metrics
 table
Date: Tue, 15 Apr 2025 22:35:18 +0800
Message-ID: <20250415143521.367895-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250415143521.367895-1-asad.kamal@amd.com>
References: <20250415143521.367895-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 12286a16-9f62-4d6a-bebb-08dd7c2ad248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJQsEzkRvhO2JigqUB3naHmpsFbjhJRz+YUKnAPJDr1fgGhxgn9JXcpAq9YU?=
 =?us-ascii?Q?Vp9WEJ2zNbhR+9j4+ePWrJeHySXexGPsy16Mp7V15cU/xm+qDO63rnVALzz0?=
 =?us-ascii?Q?lo0apJNInCDWq7jBj7WSK6sUwbCsTW7dwFW2pNtuXpuvwrLsn5YFYKDVOg2b?=
 =?us-ascii?Q?Us1fT+k8lS+BQvArBJcB2b0bTSJ3M2mqfaQEWR+TV57GM+BQdqf3FzFdKK8H?=
 =?us-ascii?Q?mgbdSjxRXT4Ym19G/GIEeLWVmBHZyUZdemlq8IxuooUOoJRSR3WRvXfdYK6i?=
 =?us-ascii?Q?ZFeWvO8DHwBQjATPdYwBPGjrl3Vie/67izCIRw6hjHCk8H+Cfqf33pSEbYLD?=
 =?us-ascii?Q?bfMvj7QrfOJSrJ6uwQ0EcqHJRShqCv2hP3WNOVu5Jxn79iLeV8zFDp+rm7Ip?=
 =?us-ascii?Q?4Ar3cdnh6BW7NNczTAAk+1o9N+gLeZJIsQdYM7HkT/y6Qbl6y4YRjbHEJyfT?=
 =?us-ascii?Q?V7UMcW7TwT+koG0m/pRGA304uuIll2lp4uSnXi2QJWCXgy5S8h3KurP8OfWx?=
 =?us-ascii?Q?dM/OQtM7Dz3xexD6FxkLLayGVFaK286Nhv+79N0n/BF4YWEpNPLaWb8PE31O?=
 =?us-ascii?Q?n3DEnBlq2o85AKmoNl8/nQ1bqefsL5/myc/gAIRUf1EtO2QxxFoluCHj29am?=
 =?us-ascii?Q?KisVLE0c+z4eFNWGgZA+MSy9RND8h1HgEH275MrbrB5sF91NN1PtIueRA+9i?=
 =?us-ascii?Q?DDkBZyVRvDSP5A0DWUkhSuNQIRlaVI0KtAgAJJsVl40aRXwK6hmWlSyfNtoH?=
 =?us-ascii?Q?Ux2HTg/r4O3kTLKvWqtnGBebUpCm8aV3XOrwMc38zzfnAxU9TbhbzB8WMGD7?=
 =?us-ascii?Q?mpzikGs07loWz02lGc0bo0gA+my8Z8Wp+0LFAFzxk3PFArL4fjV626ZlprMH?=
 =?us-ascii?Q?qenMLSBjuOxWuOF4jJHZPoGtkGBSpJxD5Q7GUjOHQz8wsqIAqyQq9lC4RF6Z?=
 =?us-ascii?Q?k9lYjGJ5Ka9vplbWuhhc33gIigRi6SdttiHGclzdC1oQfbYCnGXpcCEHux1D?=
 =?us-ascii?Q?pw0m6Czjw8kPG3zzr/wkq8lCmNG78T89bOO5ertPiMV/nnd+uCuo9tiKGEld?=
 =?us-ascii?Q?4SPF4xbwzzevoZ2AfPg1oVWXWsFmO87wm6dC7dUGengpB18bcmgR2sDhoU9k?=
 =?us-ascii?Q?QzDEudDmEWuBo8avOZuFb1be0e8r6eqY7Ct6A7vICaSdwHS8FHQAA9bwd0mt?=
 =?us-ascii?Q?eUp7kDWLanucXyXz6JB4bOqLixR0LnBFhJCB862rVAw9SwnWuX1NdvxLf43J?=
 =?us-ascii?Q?/Qqe4ocz7KA7xU7q6uJypKLmYXUPgQd6YBd2mjgw+EFYTcoO8Y/P9dQYAcoE?=
 =?us-ascii?Q?tAxRVnCFUpKQ4AZlZ/33z3ThT2PamLAO7wKMjJDzKg4w6+aydoCHSefj7mnv?=
 =?us-ascii?Q?UgRTO3+uKbIFWfAJD/G+AySB1Y1U6uo6CA1ghWGFbHbSih/extcleVuzqy5I?=
 =?us-ascii?Q?CVdzyB9uKFNpzkN7NhRCYTPeaIgn2Er8zBe+YMp1N9oyewD1R5Ap1zCvllM7?=
 =?us-ascii?Q?VE/ie+KjpHtgs0bT7X2ZsSMtIIHnk8bG20+P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:35:51.3525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12286a16-9f62-4d6a-bebb-08dd7c2ad248
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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
index 94fa31fc5eba..3fef50df85e7 100644
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


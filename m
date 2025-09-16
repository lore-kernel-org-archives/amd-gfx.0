Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB8BCAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED87910E741;
	Tue, 16 Sep 2025 09:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JLtX3sVz";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86EE10E741
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqsPlnS1K+M2YJEJL3goATpW/CJ1s0BDGtYYNJfbVVkW887PN07fpAm2WtZiPgNNGCpjsqnFKQKzsX1+nRjVR96l+82lX7BDpDXlu79BJ/uTQNsrYQHObGKOfmdYdSnl1BCgvEiGagh2S/nNZysPycOZ7FHCKUm++N4w19kfHlRyArbGm6lyGONHQFFPQc9ZBck/T6moD/sT4CGQoRMbcdnamzXtG6LqYmLWzL5F5IzNlP+FQM02AcXF6s9Jk23JPVnLKEGqGrPx3Av1Xofmv5GkQjwDF+Qa6ffQSQLxrH2rYxyD7h7wTGbR/Bvh7KSaN0qwkFVmRP5c8pSgEmU8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVv20wFgUF59sgx8Xq1LmtPVlpr7eoTufKYdDWXeE7A=;
 b=IY3HEht1ntFi4nalXwQhlMmFb6xl1Ne9V8D+jbY0mfDkLxC4X6PaCLztIpZS7mnlTDcgvvpwhHcwPDNc1LmTzSOgBtNFiSFs92yIjYDg7OholFV4I6vP0At7dYu0ZUU3oLriO6cZwucyJEkbcVnkP7qTrWcu0a26akye52khhBUdjy3Whoa3jr7Phla+MuK+F0mHHUiwwWpIiXkg0uqZz4F84RLqXSG06lWvK7xpPjzF4rRQmnpwSDr2U0NO3eNN4HIj7Hx5qMrwPvT2wqEoUhg04GLEpiVB65UKptmsIM9J/4gCEj4y3scXaUgcm5vF48r6cd7C1e1M2iDJWLmOwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVv20wFgUF59sgx8Xq1LmtPVlpr7eoTufKYdDWXeE7A=;
 b=JLtX3sVzOUTXJBdJ9+lY5kCvdVEj7/1jRA35EaL+5uDy52AFBSkh8WqIfIZRS2K9bD/3n9CxDyjM414IKxBquzKQcERpikEzgKS6F+dYvs3ZRXxinpZD82+B5ih0C4/Fs06K0aDJVQI67+QrkEj2TIE+ekvMv3c77VQXc2kizKo=
Received: from CY5PR15CA0007.namprd15.prod.outlook.com (2603:10b6:930:14::13)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 09:05:47 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::a0) by CY5PR15CA0007.outlook.office365.com
 (2603:10b6:930:14::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 09:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 09:05:47 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 02:05:42 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 2/6] drm/amd/pm: Update pmfw headers for smu_v13_0_12
Date: Tue, 16 Sep 2025 17:05:23 +0800
Message-ID: <20250916090527.2727930-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250916090527.2727930-1-asad.kamal@amd.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfd4ca1-55d7-4622-24c7-08ddf5003999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rfH9XE+R8FhiExsjTcu9TxGh0cAHsPhz7V4bR8QlVUuDY48JjfQ+7DoAddqf?=
 =?us-ascii?Q?19XqR6H2eDEQBtL7UrxA1AeBcFoZJdr2BTQTfrYlPyY1/LA9MtVNKL7PVTTX?=
 =?us-ascii?Q?ETyFUlmBmA50THnHgbuUrH9NaFM2pte9Y/Pscf/EXGpQAYMbwnnfRDM41F0Y?=
 =?us-ascii?Q?4WKi0rTmSJ84t7jentes7FvCLph4qFIjdLWbluZUrpdrlXzuFAtssniiaowH?=
 =?us-ascii?Q?ymG1yra3vU5ddMxdK8X2bAalRARQMtNvY3M+GpqMIM4rMt3GgGOsaEUH/Sh5?=
 =?us-ascii?Q?RWyFkQ7kmiADcvegTCeiBHYWEykBxgS4qNLeWCznnVV2u9lBrIjDoLRQQ5IP?=
 =?us-ascii?Q?HVWq9PhMIkzcc65/YrhJfQplMHKRiose8DNfDP6VifYK+uy6P1s1V01nC3Qn?=
 =?us-ascii?Q?ije2Uxe4MAw49X6AF3Dv1b7EKiCsLRpCIRcY3TSjwfC7McSmV5zhh/YVkbY2?=
 =?us-ascii?Q?KjQk8OPGj4Xr/t3p1bBFhcx9qr9p9WjZM01Y4fEUw46OyIrz9R6yL+bxsFxi?=
 =?us-ascii?Q?wOAA0hAwg6QHq6Iu5NbJdIJh4zaqVorbI4AZuqm1BH2IdjSCiugGzdFhjHrT?=
 =?us-ascii?Q?p2QulLxjp9IiflWbWHo3PXR6csXZLkFAMo/nW3PEBWW6qKdYs//sZvsJyOQJ?=
 =?us-ascii?Q?k1p4wT5teDzMDOxcr+5mdxjp07f94X51EBEHp3GLNwxLz1bxcUyfZ5VuXaSw?=
 =?us-ascii?Q?Jx5rrugmMjEQjFOv1GIMhfNYf09izfrG3qZ8rT7/Dc/S4aFjpIJ0nB51cD1n?=
 =?us-ascii?Q?fD6BWEr48TywP9EnCNFJ+37GhXO3JXNSNN8ciRgGdRkaobrhF9goBWr0aF0b?=
 =?us-ascii?Q?OSUL0Hj8+1zjoSNWpZxBVRd2Q77NWbGdPy4R81g8Du3i/hVRfjydk0MxugEN?=
 =?us-ascii?Q?/zLgkGJZCaRhJV5LLqYTgtlfU4uyRsVJR1w4EydEYgsQwW5JHp7Tlii7W+uZ?=
 =?us-ascii?Q?twvpquCaszni6KglQTnsD264Q4KkuluH4mZl4E+H6vJJIFfCz4kHhGNnMeJ/?=
 =?us-ascii?Q?FEfwcVImN35HUyayiMBvxnzpng6ObfTdZzrRqxKObNNVuj+SDJKCSrAiyoyz?=
 =?us-ascii?Q?vmFSQ1GaRWjVqd4cc/QfDOkcJAdVZOLzLcdyYPyD/3U8e+AaTsC8Bcszd6ie?=
 =?us-ascii?Q?CTHt4gn4JLG5FEpLJD3pA78rgBcM8hsgeS59/OSfQp1Kb0T+YI3I3x9AP7/f?=
 =?us-ascii?Q?7F13AQaSK2t6wOMPAjavVPxjqIGhLTQOxmj0mht9R53WzPc6CuM7t7QRmS+d?=
 =?us-ascii?Q?uqCDmWnCI8XHSLh+oVOJTMKAokzdkdfj0/mFINhTZW0N/6C1OCusAQUilsQo?=
 =?us-ascii?Q?PDqb7/sp5tuN4x3ekRy2wdpDVDzjt8kvzKFhG9WFBPFC2M3WjfQK/JxCwWww?=
 =?us-ascii?Q?YSwWb6/jmbVEKdoah7E9PKOWgN3wIH5RplLdgGbGbNwp9Zgled/Qv/ZbG6Id?=
 =?us-ascii?Q?EiUnm+vud6lRKE9fv6fIM2QL9Hwj4YYOVb26K/bDEI3ELkuIN9NmYPyBdH6P?=
 =?us-ascii?Q?LbjK8ufriKPbSvVR9GByiKLO048mbFXGcs5p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:05:47.0755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd4ca1-55d7-4622-24c7-08ddf5003999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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

Update pmfw headers for smu_v13_0_12 to include node power limit

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index 1c407a8e96ee..bf6aa9620911 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -191,7 +191,7 @@ typedef enum {
 
 #define SMU_METRICS_TABLE_VERSION 0x14
 
-#define SMU_SYSTEM_METRICS_TABLE_VERSION 0x0
+#define SMU_SYSTEM_METRICS_TABLE_VERSION 0x1
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccumulationCounter;
@@ -304,7 +304,12 @@ typedef struct {
   int16_t  SystemTemperatures[SYSTEM_TEMP_MAX_ENTRIES];     // Signed integer temperature value in Celsius, unused fields are set to 0xFFFF
   int16_t  NodeTemperatures[NODE_TEMP_MAX_TEMP_ENTRIES];    // Signed integer temperature value in Celsius, unused fields are set to 0xFFFF
   int16_t  VrTemperatures[SVI_MAX_TEMP_ENTRIES];            // Signed integer temperature value in Celsius
-  int16_t  spare[3];
+  int16_t  spare[7];
+
+  //NPM: NODE POWER MANAGEMENT
+  uint32_t NodePowerLimit;
+  uint32_t NodePower;
+  uint32_t GlobalPPTResidencyAcc;
 } SystemMetricsTable_t;
 #pragma pack(pop)
 
@@ -359,6 +364,9 @@ typedef struct {
 
   // General info
   uint32_t pldmVersion[2];
+
+  //Node Power Limit
+  uint32_t MaxNodePowerLimit;
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
-- 
2.46.0


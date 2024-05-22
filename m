Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73460C25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 05:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D463E10E12D;
	Wed, 22 May 2024 05:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/kDqPLK";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164FC10E12D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 05:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECOpHyGBlhYR0mxH3SBmgBPrTKnDEzDkDq2QZUJO+IdG+2r8+8k/oGJCvNHKI2yzh4AOoP6v3neqcK8cLNXQwNzGTsLNl32iKs2FEWlv1sub6cVEXCCFr2M2/g/xy/y3U6V+Zo83NExlszQHLGjKtLxEsC6paDxEFG0IYK8nhfXq7pen1ZpVwc7n/MN2USiwzxEx8ihRyeKiRJHzdVBFYtu/e/ol/+XWpAvF9RbMyjNoEvQziiSf64TmpxGunA7I68D+Y3QQ/CmRyY8YxD47qN6UokiOWNX6zELGOzulhKic7T+oe8KebJRngPszgdfP4yN/DD2HDcndJZstvFXihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snP9dd3fnIutPZAiVAVac1XpGZkFANfmtCVlmvWmqZY=;
 b=jQOR946SJLnv9pI3L4mD1kqMvaZIbn6X0HqHWoSFb/RlExzn/urck6F035S9/qJbAaKgMEtOrP2ntWD6q+iA0b4iGaJ3IFjEjSRPJbwaY6cgn7gZ7SlYn4aV56rFOqGZ35l4wrIUPcIM3Dc78CUr21bNGIcj0y00hNOqrCFVC96KFgA+ttyNrXn7rKx45McTCYVggqqxhv4i1HOF0LVPu4u23Hi6KDrH1IvCXiC3M9UINt5S9zegHoxkakg8Qhg9FUBdkQh9OVbIbzt8VZyxdD3iluBHrAO1c6Ary+6dOHiVgGOv9rkISN5qE7nkS5aVZri5a1FAu7rj7RyYMBcYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snP9dd3fnIutPZAiVAVac1XpGZkFANfmtCVlmvWmqZY=;
 b=l/kDqPLKsC4OXDPDfHSb7GREQEJUDmTcDVZqp1gnFXkhl0+u8mU86DXGDOCtJHpgGE/zlXrZ5l03IYfKZARwhcCu8eZioDAp1zDV+b0TXhj3YYfJJzvMJWkTZV2yakG03hfNlgmn5ny46PzRlFjUfIxqGAer0p//OLbnrzT6PHI=
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Wed, 22 May
 2024 05:35:53 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::9) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17 via Frontend
 Transport; Wed, 22 May 2024 05:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 05:35:52 +0000
Received: from shane-u20.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 00:35:50 -0500
From: Shane Xiao <shane.xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <felix.kuehling@amd.com>
CC: <hawking.zhang@amd.com>, <aaron.liu@amd.com>,
 <sreekant.somasekharan@amd.com>, Shane Xiao <shane.xiao@amd.com>, longlyao
 <Longlong.Yao@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_GFX12
Date: Wed, 22 May 2024 13:35:30 +0800
Message-ID: <20240522053532.2896100-1-shane.xiao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: d36a2e21-021d-4f5f-951b-08dc7a210bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GdAsAxjl6USXSDsvrvleGL6HWDABcCIR42q8Qw6vDO3/BF7v6P3TvOZLbZvq?=
 =?us-ascii?Q?tiquv0MnIpcLQxttAiSScNjmoRL4PbN9lu5VDxCV8x5mMvhOrxYikRPel+Qg?=
 =?us-ascii?Q?o+uLmn0vRQhKaqjOeiSduhgR+x2I0H/jSGoC0d7rOY3QrvehCwNabbhnWO3k?=
 =?us-ascii?Q?ccJt9RgNPh3nE7MskDnsJeGFOVfGT23l0tUUVmX7Z7aU4uwWFA/QB01zhFCn?=
 =?us-ascii?Q?2jyhTrX4VjfZlPQP7ZN6WdAYA5IosC+Yqb5yJwAVQ+BW7tu8LTXfz6AXno6z?=
 =?us-ascii?Q?vGl02KPJVKH38niaD1/Bu6Xd1gTPM+0QJ1n0rvOlsI+7vwDkXtITAzLl7r0U?=
 =?us-ascii?Q?K7chsFicf9KsHroYsNiQDIHlVLo2bUxSus4jVKXBlZoPbzlwFQLpAS3G1m+S?=
 =?us-ascii?Q?FhLHEEmMhDUz6BO32deW7wYaXsXA47lmuqjqAON25NUP+f2t0VlrPLIXCg0P?=
 =?us-ascii?Q?Mp0o8uAWFKqAVQ7W5mtdnFejnTCr6aIecQAuJtojpjYyOKI2nKufF1jgofji?=
 =?us-ascii?Q?O9fZTLexS/wP5gYTG2MP/7A+kqiCHM+o2Cr3MTgogCt4P9sM7N1bLVEXHISn?=
 =?us-ascii?Q?49g9eoAX8GcFC8dHJFnDuHMJQ+Yrz6ImFwIzim1IRvnfVe17NUAKtTQq/1qf?=
 =?us-ascii?Q?SEAfNCQ3ds89gozS1EmLLS4Pea4baDsdWqtkFocrQX6wrHfzSoNY70zOaOFl?=
 =?us-ascii?Q?gQ0Bgs05LPTdEfQ3qP47USWfC8D+btdM2tgHtuOESJsjyhay8OP5ZWC22Bq0?=
 =?us-ascii?Q?EBZ0eePcdw5R0LW4pF4bnUtx4No617bIGnXxGOU4jMn5pDbgsYNYfrueO/ZA?=
 =?us-ascii?Q?3skgKih7ooZ8vbqT0SZpfucaaqBaydlSuLg24zG3vcARe2nkRBdg6RGJEjMt?=
 =?us-ascii?Q?r6E8KLDr7MMqajthDhrOlMuXrnskug71kRhH3nnKyEidPww06QY7dciEPHRS?=
 =?us-ascii?Q?R7DKFjB1IddOjvZOPyzojPPJvRi33hYTFEN/vdHIh+j5LLutT9+bQTbCc96P?=
 =?us-ascii?Q?MstY7RhKk45nb+p5FtzDtE4CRo4HfwtGSfKMJxuEQY2tdaK8G3nizORTfYnJ?=
 =?us-ascii?Q?O2PP46vrR0lrsWQjv3lG4AKAdqnWUwxa/Ex0qVFmQQKa/n2wLgopWZItFtZV?=
 =?us-ascii?Q?CgygilmvtNgMC9U7MMw/gtsv2O5FHUNhptbcLBZsJTCgMfxa1pq7IMaAl4po?=
 =?us-ascii?Q?QyUguX9I9tWg20eOV5zaAPVuCALAtne7O3vBQCsA3Ks71BWSXkje5EveJuex?=
 =?us-ascii?Q?scNi1cPtHOssx50YnuDlCyMO6pS8I8Ch1rzDXiX3YJj0eJGshop6yVKJUhmh?=
 =?us-ascii?Q?wY4wmVFC1a4W+P3ZCoRqmS4cRsGuOjhOfZkBPzRWJ8Pn1/NwkLdwktuqKQLW?=
 =?us-ascii?Q?+b9YapI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 05:35:52.7890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36a2e21-021d-4f5f-951b-08dc7a210bad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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

This patch changes the implementation of AMDGPU_PTE_MTYPE_GFX12,
clear the bits before setting the new one.
This fixed the potential issue that GFX12 setting memory to NC.

v2: Clear mtype field before setting the new one (Alex)
v3: Fix typo (Felix)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: longlyao <Longlong.Yao@amd.com>
Signed-off-by: Shane Xiao <shane.xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 19 +++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 312a408b80d3..b5f81e7e6356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -116,8 +116,11 @@ struct amdgpu_mem_stats;
 #define AMDGPU_PTE_PRT_FLAG(adev)	\
 	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PTE_PRT_GFX12 : AMDGPU_PTE_PRT)
 
-#define AMDGPU_PTE_MTYPE_GFX12(a)	((uint64_t)(a) << 54)
-#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12(3ULL)
+#define AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype)	((uint64_t)(mtype) << 54)
+#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12_SHIFT(3ULL)
+#define AMDGPU_PTE_MTYPE_GFX12(flags, mtype)	\
+	((flags) & ((~AMDGPU_PTE_MTYPE_GFX12_MASK)) |	\
+	  AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
 
 #define AMDGPU_PTE_IS_PTE		(1ULL << 63)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e2c6ec3cc4f3..c723d36deac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -461,17 +461,17 @@ static uint64_t gmc_v12_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
 {
 	switch (flags) {
 	case AMDGPU_VM_MTYPE_DEFAULT:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
 	case AMDGPU_VM_MTYPE_NC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
 	case AMDGPU_VM_MTYPE_WC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_WC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_WC);
 	case AMDGPU_VM_MTYPE_CC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_CC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_CC);
 	case AMDGPU_VM_MTYPE_UC:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_UC);
 	default:
-		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
 	}
 }
 
@@ -524,8 +524,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 
 	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
 			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
-			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 
 	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
@@ -534,7 +533,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 
 	/* WA for HW bug */
 	if (is_system || ((bo_adev != adev) && coherent))
-		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
 
 }
 
@@ -707,7 +706,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 		return r;
 
 	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
-	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC) |
+	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC) |
 				    AMDGPU_PTE_EXECUTABLE |
 				    AMDGPU_PTE_IS_PTE;
 
-- 
2.25.1


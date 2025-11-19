Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A88CF34CC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0658610E654;
	Wed, 19 Nov 2025 15:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lBbI294d";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75DA610E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1AqF1JH6/K1doaiD5RLrQwIFBANt91LPeXF3Pk+HlVcfmcro4IUEtEZid04VVNynknDoUr+uBkLlQoan5znUH92CMdn5tJLxaGHQpPIGQA8mLiPZlZTglNtfdLoWq3bWK80HH17VzdqRyj2a9bdNhNF4NjRd7EGbRTFpGmrltPPTD0l0YVcecJqSs5blJ8sGGJ3WGgiCnCaTB3/03EkhVF7dBgBr/caTb6xWLpt+ZCsM1AXtPF2qI0s1cS8JAmQRp/6F90+JY+YRVKl4CAuOf6In46Q8cOJ/+9uTLhrOUqSLkEZA9Lvoi3VsX21YoVAzKTjZZ8sstL2bvH57hjArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGKZWn1gxS2i3/5xpa7tTvO97gp3NjvFpmMtvsIC4eU=;
 b=wLDfIpHmW3wKq9kOPRVxq/yrFkdkPcw92hZL7YRAdNGNT7Gp0wMsXDfoctRGJGSbnr6Ptkb44VUqr1q4EHPibm3lCqAGdnC2aTowwFczCi1aTxx53fq0PmNAtjoibEzvO+vHCAnnQHL3Iwu/olp8xe7h0lzaqZmooLw2s8rZNGYVXo6kcGaRHe83qkS8xhgssgjH/JJCp9mFRzJMlOCuzbca9RgjEUjs+iIU4lCYfVZjMdV+DnbBR5+mPF5LjhCuqrclhkfwDN+Y213Elzat7p1OH+f1/8vScxnNm+JjgGhnVadyshO8eRkgNqMA+SROmjA3cQ+ZSXIXJ5BI5YTeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGKZWn1gxS2i3/5xpa7tTvO97gp3NjvFpmMtvsIC4eU=;
 b=lBbI294dv3eSnRX/NLW1FzlvmeySGfN6KMzJpV70ZSZGZTKEsrH3dOueySNd56VoenYpkg5uqEoyayPxassQm+SdjN1dObM6ktMhw2uv063pl3zGCCmmH7qMx8f7rhYiFytHAGHUdPPiXntxlfSJWfqQhVkkT7BAnLUWQSf5GY4=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 15:06:18 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::8f) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 15:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 15:06:18 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 07:06:16 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdkfd: Fix PTE clearing during SVM unmap on GFX 12.1
Date: Wed, 19 Nov 2025 10:05:59 -0500
Message-ID: <20251119150600.3663611-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119150600.3663611-1-alexander.deucher@amd.com>
References: <20251119150600.3663611-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: df51a70e-3ee2-4d0a-2b5d-08de277d3165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gRZHWIIGeVAOFaa92fpH/vfQR/6Ji+HJ+1l+ALCDLTYkrPD793rF1sFZN33R?=
 =?us-ascii?Q?ET9bx3/DXeucBYGdMvv0crkwdnTi+SmJRWmkKae6ct9amUR/Hqk3XplZ2gST?=
 =?us-ascii?Q?n/4c00022+RjclRoEruCIGwzARqnrMH753/fAMZN6a7e9CZRB8X7f+gfb8fh?=
 =?us-ascii?Q?Fh97FOu+yXovj1oSO1WE+99iGTxieIgCAMhxWQdn+kOSz8xeuSp1tN6EVyxs?=
 =?us-ascii?Q?d7yO6c7mA57so7qsX8IrA7AGIOpTfyQ09IcGpt0Hj++V48qZsEjD8l4wpdMR?=
 =?us-ascii?Q?K6mCNHo5UGm2SiG1eOHUKihF9MSCRBCkoSXNhbXdY5BOq47GwYjvqu5Aq0tC?=
 =?us-ascii?Q?7OZjEKOY0ab0I4EAoLu5EBzzow/RKE+jRo0N9V49z1Qt1uLDrGGiNL7bqJMw?=
 =?us-ascii?Q?6npg7h8gPe6+jFvfcp5EPUghQ3pQkS65ULw+audC3nL++8I9SIWzDV0oEcNF?=
 =?us-ascii?Q?nj7H6y85JEUI/iET77cdr8TjnNn5LH+ASm4hBs8n2+ZDJX8e8PLwoDDc/Bxo?=
 =?us-ascii?Q?EdrRz1rc1ghGDoxRxRdsaHiAhfeVmL+tZ+0DNwQBd4xet9ZqwiIc1jZyHMaF?=
 =?us-ascii?Q?E0VXSkH2+kUBT/oVHNRN2NKXGv62jhhhDykzcqyDyc6xWw9gGDCrBI7vYmr4?=
 =?us-ascii?Q?83HXnDxL9A4FTtzauu9sJXBe1R8bzIf46znkebZGyX4NpQcVOzjlyEZ5nZgT?=
 =?us-ascii?Q?4Diwu5eRHymhnJ6baLAR2fwRTtJEavrMrvFSeFD+RZ+5pAT/04wveO0SknXh?=
 =?us-ascii?Q?iqgbPbDFcaB0G9VjF9yDTtIXA/RumL0bMXEyY3zCJGFRhlC1n1iLht8cK1yR?=
 =?us-ascii?Q?OrGNoeMmmnI51s6eOQSKtLcIzoZUXbFXU9djOTIqNynh+rX8/ZSQTspqxU+t?=
 =?us-ascii?Q?0rAgxpJtWYpVAe76y20PuyeMxcZUxNz4Zzy/8A2kvbMHUiGE6xJJB9/9+Mkx?=
 =?us-ascii?Q?y2+rNQxHwzDGCr2lU7Fg+NZXLGBthT8vfxbEUxZzncnI1+z3wQnsR6qZv1C8?=
 =?us-ascii?Q?spLgOw4vN0xZAPnN2c51K5nHMzypZ6aCm2dyDpBcOb81ed9vF7BSyPAYc8DB?=
 =?us-ascii?Q?KGxYVOIEvxAehPleSp7hKTCBR7THlDPQpSIQ2P6ooqADKzZ2gKhu30MWHfsQ?=
 =?us-ascii?Q?Bqy6tk8VN1ErGZBRx0oDt2zq+RnDupqpj3aIniiz0Xkvo3N4frpunfXVFo/U?=
 =?us-ascii?Q?ULZXb192guErL820D6Glg9uTgUN/Z7+6+BbtPLstVT4Sgypr/sYqLgvl7Ixh?=
 =?us-ascii?Q?ZxBWJbwADi+AFIgGCD9CWDyPS8lynuKbKgsrOl9VbBGLU7FLgyze6leB1nlf?=
 =?us-ascii?Q?ArhvtEtQTnSmYheyIuG8QXTrPJXWzBdCmIxtIeBWzYSiA0/2+ZfRLnDkGaXv?=
 =?us-ascii?Q?HGVOmMV76J2Y5LUA7oy2uEZ8VafPx1Klnyfif0exB7aRlMfmVVAb+5Y01osN?=
 =?us-ascii?Q?3ovMB08NKuIZdRN+1ZiiR8fECS1Ti6V/zoisTUXteoK7NBwLmrrUekIMsAqU?=
 =?us-ascii?Q?RzgXRy31zTO4LN6Q/y7knIb6m3r9JhYZ4zWGF3YaS8rpspxJBYvjtV835uAz?=
 =?us-ascii?Q?+U8Vtzd0uVJbBn0DRZs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 15:06:18.5867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df51a70e-3ee2-4d0a-2b5d-08de277d3165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
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

From: Mukul Joshi <mukul.joshi@amd.com>

During migration from VRAM to RAM, when PTE is cleared, reset
the PTE to always ensure that PTE.P=1 is set on GFX 12.1. If
PTE.P is not set, it can lead to TF faults.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 97c2270f278fd..24a698702da75 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1313,7 +1313,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			 uint64_t start, uint64_t last,
 			 struct dma_fence **fence)
 {
-	uint64_t init_pte_value = 0;
+	uint64_t init_pte_value = adev->gmc.init_pte_flags;
 
 	pr_debug("[0x%llx 0x%llx]\n", start, last);
 
-- 
2.51.1


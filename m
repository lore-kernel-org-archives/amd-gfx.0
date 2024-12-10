Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A0AE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 18:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16ED10E94E;
	Tue, 10 Dec 2024 18:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aE4M+qzA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1764010E94E
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 18:19:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCSeOI4XVw4y9jLbm3PeNnEh6Ih0hhc0eIwpuTOkQwmZ2ZlU5VCuPuYDEuMXrl5Kuq9NpBGDHycfaFLH/m5iuA5ppwr9fPyd03ih2wz2a8Bcxxj99+THhmbfJlkDGpSKFMYvr3kN9qAprFrnfVqmX79H3hEffSlQQe+uyzx9nbv08YkivY5WHR3Rhmo+9DkY4UxGWqZBSXr4RQOU3imfSGWCBDZZR35/SUqGvazM9yBzYZcOJysAw/u3uOxBSRgKq8zvgjo5Lv8Z29CMG6a/NQ0BqgJ0f01tns+Bpihu8o+c57JJD3nphyBNR7ww1w/aVEJJ3VKkrAbRc9OQjMqYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFt+R4ltU3VO1/LSN0zxcrp1SlemIl36c+w6/1Y8fjg=;
 b=SRclYIAL2Fxs8IO1EH5BzXmMNAhcsZeHjOHFgvP4bWEuSx2Z+q7FZW82kEijd2iF+ffiwpsHNPG03y5QmmIGd0B0i0vlVy6IJOVJog/H9jWi1qJuvRzOZVmvQcZSV6GdSA+KHZRlj3MQ8zWkQXr+ab52EFZQT4BkEyp26mZDebvJgeFffz7Sszrmz3oaGy5J6BtgCyCExpiaO+Wu6m2GWP1wnkktEtMUto3vvjFFMvhEuL/ht/HGHeGyxpzfQQJ7vP9r+nUQi8teLaQuHrUveEvJf0M9wKF3KwXaW/JbYJJhLH7ldtbwYFY0fyWW/R/CCnIfSvmtquubjfEKXokH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFt+R4ltU3VO1/LSN0zxcrp1SlemIl36c+w6/1Y8fjg=;
 b=aE4M+qzAI85J7zoWkgEb+ykG62IRuvK2V69r7MIS5RZAucTEiEqopu+EhoVJBS4mlGjIDiqGth1JW2OSBvYNeBE2q39DIRuqH6x4NRcI6p0kjfrCArBo8ae9j024PrYc+/zR9ra2TVbcHv2ZtLg4bF/eC2m9HYZZs4jAz31dmJ8=
Received: from BN0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:408:ea::21)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 18:19:07 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::12) by BN0PR04CA0076.outlook.office365.com
 (2603:10b6:408:ea::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 18:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:19:07 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 12:19:06 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexandru.tudor@amd.com>,
 <andrew.martin@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Failed to check various return code
Date: Tue, 10 Dec 2024 13:18:46 -0500
Message-ID: <20241210181847.2952314-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: ac6a67b5-3988-45d0-a05f-08dd194722d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H5gyzHy9c3gqBBSVOIJowAMAJkicS22H67Eh/DGMo3n9opAzqbKXS7+pRrqB?=
 =?us-ascii?Q?xAo4R7TSpbpIa16gJ7BsHFv0QNEu21XTbyEIx2n7fUK6e43GnM7vlDF9+MC2?=
 =?us-ascii?Q?0ueor8IruaxUo6tu+Zl5Hw6s0oEO5YAMvPTXiImUySwXK5R09j54UBDZheU5?=
 =?us-ascii?Q?paBmTRmKCzJpa4cyKCdTtdAJ8IZKNvM83+NZhhn3b+yxFIQn6XbOgFajYCFy?=
 =?us-ascii?Q?tal+4eWXYILbR4RdUn1zMa6Z9irQZeexpRns8k74LFKutyTesiL0MZUFuKpT?=
 =?us-ascii?Q?GYDHhFXjk1Dzz4oamsl4qB314CAvZ2i27SPSghm0Xx66qHuwAXyp4HOLPGKk?=
 =?us-ascii?Q?W/f2Mg01ODc7AkSEwFb+rgGTWwISG/wGC0qHz59VewGF0R53qNAQTTbGKmJk?=
 =?us-ascii?Q?NX92gj0rmmniPL0CiXZ28yViRo0TKtVwh15L23s47VI98j5wfLOIzfwAoMIW?=
 =?us-ascii?Q?F5hCkU1iXBe3vqaTJkF/9ujPc9VAF4SFBJ7W6odoXYAGLvj2Pcztsd1l60x0?=
 =?us-ascii?Q?QytWdQv0ncYw9ZZ5Sa1eYXGYARap4eUUIrxDmObTPGdR5g223F5ym2LR7yOG?=
 =?us-ascii?Q?yHrso9XwoE5HLm27oJ+baHdemjBY6RKoVHk2rxTJPjGS7xKFSRFWhKJl4AyP?=
 =?us-ascii?Q?uj3B5osTC0sD9jfY5ZuErrNetH2dgNKveKLG6OTbh2MZ6ejjM60clzbT+q1Q?=
 =?us-ascii?Q?QsFfnpCGhajmZgIT6i10Qhze+oItmnFvEWv9dpQtx5GzhJckrdeAXA/blAOY?=
 =?us-ascii?Q?pwbjxt7N6nivdxett4oAu3LeHMAq3B7KkMTbQsPwRmaelxw2vJtn7i9pZ5Rh?=
 =?us-ascii?Q?20vTwPoOrSC6ieJr/5dhsbc9vjioumdmWLepWNy9PYuq4+Ty/TMjPWdPYNs3?=
 =?us-ascii?Q?wrHEWvcEQ9IGBRGW+Gbe7uFTwdxc0xMBm7QxyCao2iRZENtUqb7YoYGtbtto?=
 =?us-ascii?Q?6t6HKjnedRtz23lQw43pXuVDd8WlvZyUpH4+CKMWubZHF+S1Lk9ekncSmaO1?=
 =?us-ascii?Q?SggepPsf5fgNfR6oPSccRCrckt86yt2UubAS1woVc5fHk7W2cbmOU7dC+wPM?=
 =?us-ascii?Q?ccPmDntqw9tKdiiyBgO+quzMWY6qRP8Tc5ZXsqDCPucvRNvto6k+VJPHTxgk?=
 =?us-ascii?Q?l0lHVpwlQvgDwcjwZt99jD5/EZvGDd3sAXieQLLqYv2H2j+vJeqB8fO28YrW?=
 =?us-ascii?Q?BtDT0oDlCHfxPwNhm6jqWpQdwkE5ZPI9c0mVfhd4W2DOHQHqZ0KGxSt3WHT6?=
 =?us-ascii?Q?63nAQKTM+2IBgNIHQCTuE2prNEyeefmZltnUOG/MyQ1t1m9Zd2n5rG/0+193?=
 =?us-ascii?Q?w5J9Zau5qz6+1iANJ6ZMkEUoli/OCZMJYNYtdh1Ytj1xa+SKyhkJyBcJqp+r?=
 =?us-ascii?Q?s2QKyAIwi4pNWk0ghgAuxqwK50OpnzXrab1HcoXEb1DjmhjbhQmZQA1rlmVZ?=
 =?us-ascii?Q?oHAe9KTmdc/sP1y6h7vsNaAgCS/s2DAu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:19:07.3167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac6a67b5-3988-45d0-a05f-08dd194722d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 503051352922..de30143ea51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,7 +368,7 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(*bo, true);
+	(void)amdgpu_bo_reserve(*bo, true);
 	amdgpu_bo_kunmap(*bo);
 	amdgpu_bo_unpin(*bo);
 	amdgpu_bo_unreserve(*bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..1e998f972c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -730,7 +730,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
 		return;
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	(void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 
 	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
 	sg_free_table(ttm->sg);
@@ -779,7 +779,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
 	}
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	(void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 
 	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
 				DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -989,7 +989,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		if (!attachment[i])
 			continue;
 		if (attachment[i]->bo_va) {
-			amdgpu_bo_reserve(bo[i], true);
+			(void)amdgpu_bo_reserve(bo[i], true);
 			if (--attachment[i]->bo_va->ref_count == 0)
 				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
 			amdgpu_bo_unreserve(bo[i]);
@@ -1259,11 +1259,11 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 		return -EBUSY;
 	}
 
-	amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
+	(void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
 
-	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
-	amdgpu_sync_fence(sync, bo_va->last_pt_update);
+	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update);
 
 	return 0;
 }
@@ -2352,7 +2352,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
-	amdgpu_bo_reserve(bo, true);
+	(void)amdgpu_bo_reserve(bo, true);
 	amdgpu_bo_kunmap(bo);
 	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
-- 
2.43.0


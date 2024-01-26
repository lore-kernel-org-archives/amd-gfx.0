Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BBC47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 14:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 417C410FB30;
	Fri, 26 Jan 2024 14:39:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D6EA10FAF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 14:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfZ+tpGz6tHymD9kmg5rwQyM4HPa+lHVgFuD16CPJai+5k5Y4wbusJfReg1KJ6WHOs7i7oSlwyR0x5hbnoMcsNsU1w7UUi41uOLaXlZyRUtKHeG1JSZe/RkTCsPexswVFruzfSeak8QJ0Kz8TvaxPGN/J2IY87ZXtikoqG8U91FeNS1n7nS7F+W6eaMYZqtjQGhs/7j5drtar8Kx4RarRlY5wv+Ap97cxzhp1yGOzYM2okg0Z+QKigFyObiyWH4Pi/7IFVMgLMaisKskCSrwHMMgK6vIcQO4nEzmLfUEVmt06i+oCsEVin8B/bP6dAx/jWo97B7/QywEb0XAiUVZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hveu+twF9vb1h/6ZMckPOn91fvDjzd8uxY/IsxKqGaQ=;
 b=oOOQn3h3B1UHTd7vazOi1vcAHt/Lovr3mNxF7qg/CEZFKVdEmPzTThtezU28lTcB3JmD8rwMj3G23Z9i0LLjSvueMKMcrMiroQGfKng0V9BqAu4S8Uw+t0fenRB+7UXQg3AvsyB4pWAuUhtzV2Mohlj/9jwdQK2+ZA9EedzIi5r5MhiDwUVSQWK93fak9JCOIX0hMvy6EB5FWaPC3zbLfOJsHI8kRsnZro5kD7vkpz+QGd1S4Fchflk4ELa13hKN5+2ACGvt2pnFFNts2z6mIguwGAyGaHBRbo9TcqXik7gz7yL/OpoBeeDdBb2EECJwVyRsKYZqpkQtxhgijLd6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hveu+twF9vb1h/6ZMckPOn91fvDjzd8uxY/IsxKqGaQ=;
 b=kT/dFbA+TxwdU6YiXCET3ZzrWOMHXrT57/TR3Dvb4F5Iw1+1+nfJPdDA8gAYHrfjpzodC1sNgfA78ME7UZTZ4GiuPTNmdcDeRInCHlG7JXGqaO5MBNC2f7VV/EgOTCA3gqqkRYc+ZQ2t4g4due/XCCuzQH6lzBf/K8X+5aaMJAs=
Received: from SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::22)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Fri, 26 Jan
 2024 14:38:54 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ab) by SA1P222CA0163.outlook.office365.com
 (2603:10b6:806:3c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 14:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 14:38:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 08:38:52 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Limit the maximum fragment to granularity size
Date: Fri, 26 Jan 2024 09:38:30 -0500
Message-ID: <20240126143830.30586-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d1d0bc-8169-4e14-d27b-08dc1e7c853c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJJN2ok5peWFLKU8Y+za6Yo3FQitjWbUvyFROvICh7Qq7KHDEy7PRpLc0QZW1jrQM5mNlyxZVcqDWgCvaMwBGlObbpQU9RjlosS1Kq3pXXZDwVkjXNUku7Y9h4gzxxJkWqR7+qjB6dFl/2PLbFgpEv76nwuF0WVNFMyYR4SwKj6PT6fAJWVTnPB5mg8gzi789WKnKqRid+EqZg9E/DFkvYKBNAj5Qp06zOImQcdugEVqUjgT/+glOm1i0jw7SSbXIg4i6Tr/VYExOC+hx1sViwD0Zow28R15tfJ5tyHtLONsqGt1HsUAURPXlxNPic45sGj68s6LZoZBp0xiAeDkdEfNNfyKP7iFnV6XSOrKDd+wO65VjS/KDjf4nfTdU62mbecPO30K+SWN1Jfgl0v2Ozmbz9P1fVc5AMR+BLKRoFXYDl6UISxaeBlfeoWq8YAPaIi1S/f57v3z9THh6Tv3wIvUEcOkRExWanpgj7PK6IbUDc5XjgLpoH8O2d8/az2+PjRsqExP9OrfTJM/R1jIUTOM9iGfvxykiaF957oD4Z8EnJHbaDHajbKA+1IrPOVlHcpzL4ZS+b3r4/OT9Aco2Ob6tAvqTPd7GjqlYA/0PeJeuFWVYKMiKxgArM9PxfJUGk8Ys5eNWsnSq6drCm9fz5006QZaqChiEy+GV9XJhoYVFHXzketsFG3dzydn5qPN+T8+Rs0Bcp38kuyPVcgFrkvbu69KZRxk3rUDE0b6s8n8c2muNfVM/PgEGhgWhvd2CDvgPr3vpx9q7I69JGoi6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(54906003)(40480700001)(7696005)(6916009)(1076003)(40460700003)(70206006)(316002)(2616005)(5660300002)(70586007)(26005)(16526019)(336012)(426003)(478600001)(6666004)(8936002)(83380400001)(8676002)(4326008)(36756003)(2906002)(81166007)(356005)(36860700001)(47076005)(86362001)(82740400003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:38:53.9276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d1d0bc-8169-4e14-d27b-08dc1e7c853c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

svm range support partial migration and mapping update, for size 4MB
virtual address 4MB alignment and physical address continuous range, if
mapping to GPU with fs=10, after updating mapping of the first 2MB,
if the second 2MB mapping fs=10 in cache TLB, this causes the first 2MB
access to the stale mapping.

Limit the maximum fragment size to granularity size, 2MB by default,
with the mapping and unmapping based on gramularity size, to solve this
issue.

The change is only for SVM map/unmap range, no change for gfx and legacy
API path.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 22 ++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  9 +++++----
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ed4a8c5d26d7..a2bef94cb959 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -897,6 +897,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
+ * @frag_size: max map fragment size
  *
  * Fill in the page table entries between @start and @last.
  *
@@ -908,7 +909,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence)
+			   struct dma_fence **fence, unsigned int frag_size)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
@@ -1016,7 +1017,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		}
 
 		tmp = start + num_entries;
-		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
+		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags, frag_size);
 		if (r)
 			goto error_free;
 
@@ -1197,7 +1198,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 					   !uncached, resv, mapping->start, mapping->last,
 					   update_flags, mapping->offset,
 					   vram_base, mem, pages_addr,
-					   last_update);
+					   last_update, 0);
 		if (r)
 			return r;
 	}
@@ -1392,7 +1393,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
 					   resv, mapping->start, mapping->last,
 					   init_pte_value, 0, 0, NULL, NULL,
-					   &f);
+					   &f, 0);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2733,7 +2734,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
-				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
+				   NULL, addr, addr, flags, value, 0, NULL, NULL,
+				   NULL, 0);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 666698a57192..b34466b5086f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -465,7 +465,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence);
+			   struct dma_fence **fence, unsigned int frag_size);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
@@ -531,7 +531,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry);
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
-			  uint64_t dst, uint64_t flags);
+			  uint64_t dst, uint64_t flags, unsigned int frag_size);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..4647f700f1c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -860,12 +860,14 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
  * @flags: hw mapping flags
  * @frag: resulting fragment size
  * @frag_end: end of this fragment
+ * @frag_size: max map fragment size
  *
  * Returns the first possible fragment for the start and end address.
  */
 static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
 				   uint64_t start, uint64_t end, uint64_t flags,
-				   unsigned int *frag, uint64_t *frag_end)
+				   unsigned int *frag, uint64_t *frag_end,
+				   unsigned int frag_size)
 {
 	/**
 	 * The MC L1 TLB supports variable sized pages, based on a fragment
@@ -893,7 +895,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
 	if (params->adev->asic_type < CHIP_VEGA10)
 		max_frag = params->adev->vm_manager.fragment_size;
 	else
-		max_frag = 31;
+		max_frag = frag_size ? frag_size : 31;
 
 	/* system pages are non continuously */
 	if (params->pages_addr) {
@@ -904,12 +906,10 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
 
 	/* This intentionally wraps around if no bit is set */
 	*frag = min_t(unsigned int, ffs(start) - 1, fls64(end - start) - 1);
-	if (*frag >= max_frag) {
+	if (*frag >= max_frag)
 		*frag = max_frag;
-		*frag_end = end & ~((1ULL << max_frag) - 1);
-	} else {
-		*frag_end = start + (1 << *frag);
-	}
+
+	*frag_end = start + (1 << *frag);
 }
 
 /**
@@ -920,6 +920,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
  * @end: end of GPU address range
  * @dst: destination address to map to, the next dst inside the function
  * @flags: mapping flags
+ * @frag_size: max map fragment size
  *
  * Update the page tables in the range @start - @end.
  *
@@ -928,7 +929,7 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
  */
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
-			  uint64_t dst, uint64_t flags)
+			  uint64_t dst, uint64_t flags, unsigned int frag_size)
 {
 	struct amdgpu_device *adev = params->adev;
 	struct amdgpu_vm_pt_cursor cursor;
@@ -938,7 +939,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 
 	/* figure out the initial fragment */
 	amdgpu_vm_pte_fragment(params, frag_start, end, flags, &frag,
-			       &frag_end);
+			       &frag_end, frag_size);
 
 	/* walk over the address space and update the PTs */
 	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
@@ -1040,7 +1041,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			if (frag_start >= frag_end) {
 				/* figure out the next fragment */
 				amdgpu_vm_pte_fragment(params, frag_start, end,
-						       flags, &frag, &frag_end);
+						       flags, &frag, &frag_end,
+						       frag_size);
 				if (frag < shift)
 					break;
 			}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed35a490fd9e..d71b2c8bf51a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1488,7 +1488,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 static int
 svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			 uint64_t start, uint64_t last,
-			 struct dma_fence **fence)
+			 struct dma_fence **fence, unsigned int frag_size)
 {
 	uint64_t init_pte_value = 0;
 
@@ -1496,7 +1496,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
 				      last, init_pte_value, 0, 0, NULL, NULL,
-				      fence);
+				      fence, frag_size);
 }
 
 /**
@@ -1579,7 +1579,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 
 		r = svm_range_unmap_from_gpu(pdd->dev->adev,
 					     drm_priv_to_vm(pdd->drm_priv),
-					     start, last, &fence);
+					     start, last, &fence, prange->granularity);
 		if (r)
 			break;
 
@@ -1647,7 +1647,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
 					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					   NULL, dma_addr, &vm->last_update);
+					   NULL, dma_addr, &vm->last_update,
+					   prange->granularity);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
-- 
2.35.1


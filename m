Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E35D374AD
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE4D10EBCF;
	Fri,  5 Dec 2025 21:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCe1O6wP";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AA410EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwpCxvC6L3u3Aw3KW0EYgb0hz+nsShB3fBvKiAnC1NG+qA030pYy/i/WY+tM3UnazAvUv6iqdXVcmBzuOmZqptyGVKvPtFuSBn4oH3PS/bo79DGfOD6+zYszRAAxcVk9dEE3lUD2sQhSIWYDQQbGRQ/+rzJqdwP6zrZnRFMmdpzK5XN+y9DVIjJ9DLWWzFRFo2C07DojOzkNpjv5n7hLi1nlu5XeKCbHPaHCeoD4KJyhjHqBGQgdn8ju9OZmWn3Ox3y9qxM72ADGbv5pl8XRDAVuusgu47OQC3sneSdCUbalTQn4scE3JtjdAJMyg44pmLLwtMuiK+Zzt3etOWJMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Au8NNL9MEwWBZs/t82RuS3iAz/32Pa82Cp5NuJeoU=;
 b=d+dJ19Jtrb4g371KoKktJh5Rwt1Q5PsSLDZYMvSGoXP6jDDv4NTM+HJDL7V9UWdY2tBsO7UJSG9xWb2u8FvIgML5n47Y0MTJMudV2KxEU6Vkmw36q5+YbOVE3leRjUCOdnY2vuSDc/f8oFyjhoxZ4s/sCaAI8HFjyJ9T9Us2EphaAVVSPXnNMF84nA0ogLVdhknbB0dBXgGS5KE2SeM9qIVgPoN8Mu3mLFKAqTqkK7gTaNiL/buygM9a+r99pxTcduTL8IKVOrsfLdP7/saPiQ3HqiGVFNLZqCpoyIYLyTchgTjwlMNBEFTWgxV8Pi62TxEJCJG9gSVbibiru6ezXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Au8NNL9MEwWBZs/t82RuS3iAz/32Pa82Cp5NuJeoU=;
 b=yCe1O6wPsIwn9zsppVAVV4VJ5PHgpXG1YQGQgQkB9TN3xMr1Hq2CvR7ayJc4JzT/9LdPyKHngUR6K4aPbPkaviGbNMB4eiodo/Mvrc03sXMoreVafwZouE6Q91eM7oCrsfXAPJ15qH5PeKwpOxtJJ8zK9tRyaoMsiU8Z3Satbpo=
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:50:20 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::c6) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 21:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:50:19 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:50:19 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 5/5] drm/amdkfd: Map VRAM MQD on GART
Date: Fri, 5 Dec 2025 16:49:22 -0500
Message-ID: <20251205214922.1095629-6-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205214922.1095629-1-Philip.Yang@amd.com>
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 92946d27-4064-4278-bd4e-08de344848dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oJxDVL7yXxqMMtuA8FXpxuRVGHWdBEQOK+TL2Dzf/rERvfZDWzb7opDyigCY?=
 =?us-ascii?Q?26XpFBSxHq+MGZSsXcZN3Y7L35LoaHXNxcmIG5cOQTCgkkkQFa+aUNmzCM35?=
 =?us-ascii?Q?lnSner6j/Y15iV/5v23Z1wD3NZ9zVq74Q4X9ToWh2IWvoMbQJ9xBehmVeIgf?=
 =?us-ascii?Q?JWjzNSLzE/NXZbFyaUrz5OGCvMc53ruikP6623QK12atVDufMDkDmeMM18hy?=
 =?us-ascii?Q?mKBMMF2kNIlGAD+0CXCkbasXgAMExpUlPx1BRCaqt9spLy778zYNCqKycJfb?=
 =?us-ascii?Q?sQt/hwsvlQHqM13/pA2azh8SuNDPcc0BlvAq5wmj6ysPmwslyKQwp7SwLJQz?=
 =?us-ascii?Q?nhkCpoEH2SerFmEi1AyrETgRpmuoxgKgmoUekNgg5g6ZU5+Ib/NHDp3PVYDj?=
 =?us-ascii?Q?7YrVHwkaWdMthLg+qMieJp+yV/mZR+cEhQ46bjIBmsiEnZjonwmU+dCuUe0f?=
 =?us-ascii?Q?Owj/uQqlaIraJaVU0dMgB9jkQio2mohr5vc149PfvGhBaJN8lfavxVMxdhEM?=
 =?us-ascii?Q?nr37CwOr5Q5RguFihIkfkstzwQj6lrfreFsRn9xeZZ5wR5Ig4Rt8opnFkhYv?=
 =?us-ascii?Q?h2Z8576vUGmGSBTWRcBwOekBkKuOWRQL3khsV0RYIYN5118MC9giQ4l3tHa1?=
 =?us-ascii?Q?rzpczwgQ0xKMPd+GT5uBhTcBC+sdzcMem7ksibto2LgfLEAnZ6iTr6tPQuRn?=
 =?us-ascii?Q?1zpB0/8HzcVUGo4jGzdJJbk/HAfDpaNyGXx3YPPOLRv6xQN2iSZagt0zPY/e?=
 =?us-ascii?Q?q/5Uo3mOLKpAwF5ojylVbdkVMA/eCQ2rzhfn7Clsxz85mSqmJHzLsBp7WEIJ?=
 =?us-ascii?Q?+T9JsWKybjcTn9GyKOGwQ5qvJ9xxPYQP2QjdHr7dgrkl56OU2+S+couOYQFO?=
 =?us-ascii?Q?DfwaGKF+cshbdFFrQNtRazN6LJv622C+65O8bxqdHq9IaeaxgeXQz1PqubI8?=
 =?us-ascii?Q?T+wSEco26oPw1tWEOg0HNtprijqoOK7V7oHCSsCqqwwne5zDnJNJhrvumI7+?=
 =?us-ascii?Q?mdg7mOPej8N1qN7hbZGt5KGj1gt8hm43x4rkhp7TrdS4s55JT18nAHNiBLpD?=
 =?us-ascii?Q?pHrovbtafb/LXdYKasyJxoaciiAp1gzH/fM32zjq2w1FR5YoyY7gnLxeeuv2?=
 =?us-ascii?Q?ssXe9KSeuW6RqyqzABVg3394TFhEzOb59VRmrFfq/VA/9KiANt/H2Jx3dQzo?=
 =?us-ascii?Q?N313746JRSLsTeOvxNGX3/VxCRf9hSMXaw1x8ZF6a5pGd/yLEUZJcFOMAj3T?=
 =?us-ascii?Q?6Mei2ebvRjSH55lKqgSdPDa8BWdPBJLTG9/o066M5yo4d8DdQfB8c1k/i1Lp?=
 =?us-ascii?Q?P9ahPl1c1skTDAiPLuxyVQh7/5fCbo+BBYBx7/i8Pg5/z06jOCADbbSbCD4p?=
 =?us-ascii?Q?O70PpsHDXy63tqXDW5W/FRrvFNDky7F85JNEXgDX763GS22fp34KquelvcfM?=
 =?us-ascii?Q?55ErzDbu08I6S4U92KWcj4PpQYELxdhRmPPuxLlR3/+2IZ0qGKr1aXJqzNLl?=
 =?us-ascii?Q?ntMO4Qb14B7KPKiaRp0eb5yqudWSKyyfoVWg/aS1gn4liX8Kxc+X26IBzPVn?=
 =?us-ascii?Q?FgGdrVIu4rNh9BE829U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:50:19.7488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92946d27-4064-4278-bd4e-08de344848dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
to GART as mtype RW caching, to reduce queue switch latency.

Add helper amdgpu_ttm_alloc/free_gart_entries.
Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
to GART mapping.

Add GART drm mm_node to kfd mem obj to free the GART entries after
MQD is freed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 103 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   8 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 5 files changed, 122 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4f8bc7f35cdc..fc6f4daa9b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	}
 }
 
+static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
+				struct ttm_buffer_object *tbo,
+				struct drm_mm_node *mm_node,
+				uint64_t flags)
+{
+	uint64_t total_pages;
+	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
+	uint64_t page_idx, pages_per_xcc;
+	uint64_t ctrl_flags = flags;
+	int i;
+
+	total_pages = tbo->resource->size >> PAGE_SHIFT;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
+
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
+	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
+		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
+		u64 start_page = mm_node->start + page_idx;
+
+		pa += adev->vm_manager.vram_base_offset;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
+					   flags, NULL);
+
+		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
+					   start_page + 1,
+					   pages_per_xcc - 1,
+					   ctrl_flags, NULL);
+	}
+}
+s
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
@@ -1017,6 +1053,73 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	return 0;
 }
 
+int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
+				  struct drm_mm_node *mm_node,
+				  u64 num_pages)
+{
+	struct ttm_resource_manager *man;
+	struct amdgpu_gtt_mgr *mgr;
+	int r;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
+
+	spin_lock(&mgr->lock);
+	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
+					0, 0, 0,
+					adev->gmc.gart_size >> PAGE_SHIFT,
+					DRM_MM_INSERT_BEST);
+	spin_unlock(&mgr->lock);
+	return r;
+}
+
+void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
+				  struct drm_mm_node *mm_node)
+{
+	struct ttm_resource_manager *man;
+	struct amdgpu_gtt_mgr *mgr;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
+
+	spin_lock(&mgr->lock);
+	if (drm_mm_node_allocated(mm_node))
+		drm_mm_remove_node(mm_node);
+	spin_unlock(&mgr->lock);
+}
+
+/*
+ * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
+ *
+ * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
+ */
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr)
+{
+	struct ttm_buffer_object *bo = &abo->tbo;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	uint64_t flags;
+	int r;
+
+	/* Only for valid VRAM bo resource */
+	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
+		return 0;
+
+	r = amdgpu_ttm_alloc_gart_entries(adev, mm_node,
+					  amdgpu_bo_ngpu_pages(abo));
+	if (r)
+		return r;
+
+	/* compute PTE flags for this buffer object */
+	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
+	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
+	amdgpu_gart_invalidate_tlb(adev);
+
+	*gpu_addr = mm_node->start << PAGE_SHIFT;
+	return 0;
+}
+
 /*
  * amdgpu_ttm_recover_gart - Rebind GTT pages
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 72488124aa59..cb6123358843 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -185,6 +185,14 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		       u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr);
+int amdgpu_ttm_alloc_gart_entries(struct amdgpu_device *adev,
+				  struct drm_mm_node *mm_node,
+				  u64 num_pages);
+void amdgpu_ttm_free_gart_entries(struct amdgpu_device *adev,
+				  struct drm_mm_node *mm_node);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index f78b249e1a41..00e1e5b30a3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->mem) {
+		amdgpu_ttm_free_gart_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
 		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
 		kfree(mqd_mem_obj);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 14123e1a9716..5828220056bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			kfree(mqd_mem_obj);
 			return NULL;
 		}
+
+		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
+						       &mqd_mem_obj->mm_node,
+						       &(mqd_mem_obj->gpu_addr));
+		if (retval) {
+			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
+			kfree(mqd_mem_obj);
+			return NULL;
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
 				&mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 29419b3249cf..fdde907836fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -252,6 +252,7 @@ struct kfd_mem_obj {
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	void *mem;
+	struct drm_mm_node mm_node;
 };
 
 struct kfd_vmid_info {
-- 
2.50.1


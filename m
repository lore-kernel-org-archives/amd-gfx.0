Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3ED3B9B0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 23:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D32C10E640;
	Tue,  9 Dec 2025 23:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zgq5I91K";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960B810E640
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sti3LeNXcraKzTiAghtqldRlRG4ozCOQXsmqnkhgvRB/Q9Jx+vArbimHc/VH3xDYGfHnZmiSdHFpMkcYe8ktS19w4hUqIteLFnhPY2Wciv/ZdsEDbHtMmhIWIrGTtCiXn7KrHmFFOp+T+GZmmXxHCUAEDz6drbcC3CsYOMGwHvnm3zl9392TxS/pMEhUVEELrU3NjB2MsIJRH19b3JoAWsD5zt/Ru8DJQoVBWxefeqErAO/iwHM7AEVhL8GoCznSzQJFw0+0XrbehHOH9SlsrNsz54dBvhRQ4fTZl7k5mRswX/QtXf5IR2vi2+bsstEULoJCE2/SzG3QvMgG1Bf+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTRNsuohfjr2YwzJrKzseoKcmqAKu9lCeauSwG4sRZY=;
 b=pgbd704173l4NAeMviGJ1D4ta1BLXsPL8t7SfrKlN7IQv7ZwBwXqI9bALOJBVehkemTQG0bxuKN04jr3sj1okDHY3ajUUgE0x0kH3Sxxv1f982apt5+OARf7njLVkgAqNPWZtCYM4eq1B3gciJ//ktiY9fOq7wBUI5ikpIQevqYaHWw44c84U2yj/8vTbSdy1zmH4h5rhdWiaH6mm/U31phZti3465SfKHReTFx8+/1e9e62lLlUY0r6nIVHsiBYI1pTpiXJBJv1dvDvEYK4YnYuZXfoA0MjBMESR18hi5gTMTF96/PtDN0jncRXPsJqWTklUEyY8z6XUo5RsgceIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTRNsuohfjr2YwzJrKzseoKcmqAKu9lCeauSwG4sRZY=;
 b=Zgq5I91KYK1GEVy8AiASgKLiW+ljXXrRBMKN4WV8iCozYMFqh4VMu406qWdoMyGwZtZReH/5R/syxDuxeWSR8HBRn0H1vN2+2goU0+SrTCr9mxd/6gxvBCmhkzvoTupRFuO0Kn/iRWWsOQ5om9jdBL+taF5Uy5m4F416U7FOXzo=
Received: from CH0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:610:e5::10)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 23:44:06 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::bf) by CH0PR03CA0245.outlook.office365.com
 (2603:10b6:610:e5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:06 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:05 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 6/6] drm/amdkfd: Map VRAM MQD on GART
Date: Tue, 9 Dec 2025 18:43:28 -0500
Message-ID: <20251209234328.625670-7-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209234328.625670-1-Philip.Yang@amd.com>
References: <20251209234328.625670-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1a6097-3830-4507-bf57-08de377cd767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vsQTfzL+kv5WUzjzwu99yEg4IEqF5u7VIsdzKVtO5ma6ZeCOCvzY2X9vXXjt?=
 =?us-ascii?Q?mCbRtFXiQteLtXb6UwKVr6cPU/92dOLIC6rULUGAdXgAOi3oXxqg+3dT4PK+?=
 =?us-ascii?Q?0x0uUBntloTjs7/IFkR75JKfMApFu+hpKiM1XeYsqHCpwkP+Ri6iSsqTbkHM?=
 =?us-ascii?Q?ottQeZKA/I7JsW6XFdfr+GgF3nS4f9kJEdNcEBnWQSOEkTnDCiMGH+bqjhtM?=
 =?us-ascii?Q?D88fVhfoQ2q7laKjIL6RmeeIm5h/ex+O8I95xZx1aJ4gj6VDheYv4LpMCAh6?=
 =?us-ascii?Q?ais7fkuKouF+tQpn12fXFt1kvWPWYZDYDADVlA2O6wXsD7I1RrPkMRD5irt+?=
 =?us-ascii?Q?DB8+QmZex6yDo5UtFIk2UOrb9VjhDASsG8lNMmJ+cjSz26JSZynF4ZjkSvTL?=
 =?us-ascii?Q?YqL9IoweQiH9lfa2qGw+thgvAi0yT2TD0C2ERBI+B2bKIkFW8H2B2yhHsetI?=
 =?us-ascii?Q?Ljx5fx5VhF9PLWpoRY0+4O0tzCaFWgMPtj/L0DY7RgNbSetRe2NSlC7La7dE?=
 =?us-ascii?Q?KUy6FuYKyurQi5cNf4Cun25Y/3fx52048OccgUDfIZvmt73ubzKNey3fhXZD?=
 =?us-ascii?Q?Z6YjAG3Om1JZINtmgkiSM0+SFiP6KAUakC6l3fnW3C58fViRWUK0NN0RE29/?=
 =?us-ascii?Q?bqMxGpvZC8mpyCzSpHxH521FKzoBirTZIXaRyKYi4VtNmRQzm2laYUPZ+KqZ?=
 =?us-ascii?Q?Cp1wPaeSzJ9JKwT1ICKS0FbwYiK0g1idF7SBnO869U5yS9WVk8Opv1aFaLNh?=
 =?us-ascii?Q?NrVoSoovn+4Lp8o04Pi5p0nHEW9DJ1mbo/9amm3ooKJg3g9rtd8cfBXhrD7g?=
 =?us-ascii?Q?0RTlp3KHX/2fvsBcnwnlxpQ7BWYnLs0uAcImxwUrOk+ljlx3hI9fcu2EPGuC?=
 =?us-ascii?Q?fI9dqkHnC8sDYKPneMWLnypDqJKMkNIzm+ojVtvpa6dS9Cu0CcdGPZWP+AVC?=
 =?us-ascii?Q?nDiJios529iFgdO2QvLDWJg7HIpZ6tgzwT90ezgK4iqC2LHkMib7aVrx+gxF?=
 =?us-ascii?Q?JGxLz/jqqzXlL76WTOaV0JHBbMfyUIV6R7Vuu6YVU+yDJVLjnxl6dvOwF4A0?=
 =?us-ascii?Q?jLxvGOxzJiGIIdeAxMBQFjV/P2UNatx1n8OfooUS5IgF22pw77nD31i9XS01?=
 =?us-ascii?Q?Lsezhje2U/8COlDvXBBWvrM0NPLqiUHfhVKOSbhac5vlkI9hUfqmp9UGIKxq?=
 =?us-ascii?Q?SKKt8vtWEIhLEJTH2fcFewZpN/pDwnMXQdBLfrDz8oEszNmdfiUmn3VLLd8c?=
 =?us-ascii?Q?qpi0Jg4qpYeiR504YMg7aGfCe3lodRFFrhZrWpO6xRcvP+HVHVvbose/W3wf?=
 =?us-ascii?Q?KmneH0lMVj8LaFpiQfFU+heFBnynIRyzgIhR6BxBkFdRdCSO40rGJQtCdtQK?=
 =?us-ascii?Q?YWtVtgJruNJOlRsjUoYLj7D9FGlD28PGLN4KSmkDYDZQ5/wnJQQ24iOLtaZL?=
 =?us-ascii?Q?Z1+HIUNw3VhYF7GmsuWIRWr5HUw2VtLy2oQL9+1DqDBnjmtS0lKSpqmfYMB4?=
 =?us-ascii?Q?VRvNADuPR8teuhx7+6eTuCs97kC3nZ2VzpyyUq9G0Lg4K1oyXTplYx8E9UDU?=
 =?us-ascii?Q?aE61itJrZcSUBFgswh4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:06.1831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a6097-3830-4507-bf57-08de377cd767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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
to GART as mtype RW caching, to reduce queue switch latency

Add GART mm_node to kfd mem obj to free the GART entries after
MQD mem obj is freed.

Use resource cursor to handle VRAM resource which maybe on multiple
blocks and use cursor_gart to handle GART entries.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 89 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 5 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4f8bc7f35cdc..ae4f60aeed14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -880,6 +880,62 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
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
+	struct amdgpu_res_cursor cursor_gart;
+	struct amdgpu_res_cursor cursor;
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
+	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
+	amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
+
+	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
+		u64 start_page;
+		u64 npages, n;
+		u64 pa;
+
+		start_page = cursor_gart.start;
+		pa = cursor.start + adev->vm_manager.vram_base_offset;
+		n = 1;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+					   flags, NULL);
+
+		npages = pages_per_xcc - 1;
+		while (npages) {
+			amdgpu_res_next(&cursor_gart, n);
+			amdgpu_res_next(&cursor, n * PAGE_SIZE);
+
+			start_page = cursor_gart.start;
+			pa = cursor.start + adev->vm_manager.vram_base_offset;
+			n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, npages);
+
+			amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+						   ctrl_flags, NULL);
+
+			npages -= n;
+		}
+		amdgpu_res_next(&cursor_gart, n);
+		amdgpu_res_next(&cursor, n * PAGE_SIZE);
+	}
+}
+
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
@@ -1017,6 +1073,39 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	return 0;
 }
 
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
+	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
+					 amdgpu_bo_ngpu_pages(abo),
+					 0, 0, 0);
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
index 28511e66d364..a8b8a541e21b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *node,
 				 u64 num_pages, u64 alignment,
@@ -192,6 +191,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		       u64 k_job_id);
 
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
+				  struct drm_mm_node *mm_node,
+				  u64 *gpu_addr);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index f78b249e1a41..edb72f4ef82d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->mem) {
+		amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
+					    &mqd_mem_obj->mm_node);
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


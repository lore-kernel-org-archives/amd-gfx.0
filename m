Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C4D0D170
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 19:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727C710E2CF;
	Wed,  7 Jan 2026 19:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LtCdInvM";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65FC10E606
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 19:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnZJGRHu7lGR4l2hwG/hTklS1EYEIasFOLGvzRPc7ZzXZ6seMd0vTbVUvf7OSnvObzxLqV4TDFNmyU8tkt47uhd0JfhCPWb9eLJ5/xAnRyL0xNXMZTrAQ295JAAmUKQ+VoD9cy/i24Ivw441fLUkdGmMX1N1JPRApFZYcmkaIg4yvWj3HK1wQ3z69pWIfY2+ndm22lHciYdCBlTNhqf785ao8VlXCy2CHWYQFBC7GQjhEYr9tLmSb6vXKvaVfDWVesE62M0AJ0Vtb89ApAzdcOYyQP8CAf80APwnoAqwYlnrJ8rO99TtkGgHS+fm5Wp3TS+eHUigAIySIGw94kdlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vesqvr0mKA7ZHjb9qmZx2oR0IDRgsS+tKgmHbYkJkFA=;
 b=Nys7XCY740JXF3FDsz6LL2E++NAE3nGUjUIFyqwS/ZEKQrNhmP1rgrgVmlM6f4FE3S0Q7d9Bh3to/8sIrOViTr+StfVItW9qATRhS2tQhhwl1q7tqwIAQDu6rOZKxTbUCUQqU3OCb0c0d7l8aH6ZxxsrlU4yy+iQsyI1rP5fxi/dSlOSD9+m8RjP7rBPnDV859DmFObcEnmwIUFFvmkARkAYQ9En9L6CaHEho6yD5wPvk5lQeqoXPmo44NzSbYnGPZ6rcAO+lDy7xBkfxMq89XY7jSNdnFXVEWjm9G1JSwzkbYLGXb2TwzSXwFR3JRYw+kOei52b5uPAATk1Z9zo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vesqvr0mKA7ZHjb9qmZx2oR0IDRgsS+tKgmHbYkJkFA=;
 b=LtCdInvMMn1j7hS2Fx4I2SAAdXMgX2FI56Zu+YXzrvRgny4i/yfTnMu5abay9mpuPHENV3awKNMIS4Xya7oW3ZHDOZBDGpMJRWh+Z4PIMglgoLbIssK0GXxaJYeJrJ1AEMq78spaKrNsz5QJl2BNPg3ba4P5ldfP2uXp+VLzK5g=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 19:25:51 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a7) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 19:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 19:25:51 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 13:25:48 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <kent.russell@amd.com>, <jay.cornwall@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v1 3/3] drm/amdkfd: Map VRAM MQD on GART
Date: Wed, 7 Jan 2026 14:23:40 -0500
Message-ID: <20260107192341.3521748-4-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107192341.3521748-1-Philip.Yang@amd.com>
References: <20260107192341.3521748-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6d0767-2762-4c59-0054-08de4e229196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/0g7IRQzO6iYxODh2V47qbMdVTF+RJzN6G9sVEiVO390Xzu2D++juJ4pyTvU?=
 =?us-ascii?Q?ilO0lxydalDY1LE46LRESIW8TZzY5cxtJlUouIYKRlkfd7CSFwdf4a5Jt0c2?=
 =?us-ascii?Q?juG1tvgAFe5DujExy+RMkxzFnvUXgmSRIZl4ugaaq5W84mOl9xadK/RIdcTh?=
 =?us-ascii?Q?vh+ZmIZ2XtpoBmKed1/RHA02a8Eadi8N01Icm2PCjuf9QyxLALaAYNVVUbdj?=
 =?us-ascii?Q?UjB4N3TszdEhEw/sSH7t++eULS9UgmDpMPl+wBTr1mQXpH5z2Kj1L2Wl5eWy?=
 =?us-ascii?Q?3QcPkMESVHXptp9fYxl+CtdtGqEwsWllq88O1goEdu09tLqft9GW/PFmkZg/?=
 =?us-ascii?Q?fTarviByjN9aZtoW42IIsAC7e/ZTnEt6fnM6fb+80Wt2ra+5Fj3zAgZ+hlkH?=
 =?us-ascii?Q?bB27OWoLQW8dV98DK0z++Ud85xRNPORNdz88bv5rtwAeRnEWk23+ysVNwGhJ?=
 =?us-ascii?Q?pBw4ap7m/M4iaZoj3Eiz2JStXmTByAzYmxaORVYPJ7R7lOLrDJAT75sPiu2y?=
 =?us-ascii?Q?lN2yLqLq5iuKrOfQjQuMv7a9Nm9C5IDSPnT2E+Kl7ET7nreH2Oe6Y3Dw9omD?=
 =?us-ascii?Q?JqQrK2iyx682gGUt/nf4g8bq2Ojbf+5jFActRbyZk3zLTbn2BG54dHuujT7f?=
 =?us-ascii?Q?Y9+/9Esv5f2ZUtGuVZxQm7NNFE8bHkd0tn7IK0AvDaGfxqVQv7KlEbbFYOwV?=
 =?us-ascii?Q?ItbUo/QhCSRjUlqPRv/oNtcCsn2wluX6oVv3bmY72YG3gT5oEVoM5seSrDvV?=
 =?us-ascii?Q?oyVyD2/yLYU6DBWi+Pn+MWFMZr9OWyk5MoJpaS7MwpK8TdnxB18q/mZWR5Ah?=
 =?us-ascii?Q?OR6/siWx1mwfFAv5DOwSiIw60w63dxB2fXR8NsCvlSjiuqrPgnmFo9qgfM4y?=
 =?us-ascii?Q?zm2CmR7wcem3lt8YxPwEKUHlYEz2Ect8DkhNh3yP7ADdAYlMe8JU65X0ufqu?=
 =?us-ascii?Q?07rh5OjBLOKdYXt5gvEVevqMsTVZxdROm9reWPczhXtwaQR9UrSSUIX0YBsN?=
 =?us-ascii?Q?L8Af46z9BubiuTgPqz8u7w3MacIv1IO5ParcNWp+HYG8Du2tk9G1TfjZ/BdL?=
 =?us-ascii?Q?0tXD2dJJjAEu6RUAm0+bT6cYf65BfOPPqnccTtcohyam0uRdi4mYCKG34DX1?=
 =?us-ascii?Q?D01MyVDnMPA522SxX13awS4R3QaMkLxe7HyyYeL9bkYYb2H9BrS3IHdw9k1W?=
 =?us-ascii?Q?qFfkzAmPKcO8UJgz3HivN4g2k2TeQNdZ/oeayxFqwhFFjCTob7QaXl/P0swJ?=
 =?us-ascii?Q?/+8s2wcxyAQfsPAmi75dovB77LPZcmgGyekKFhqcJGgnhMlzUiqz2nKzB02q?=
 =?us-ascii?Q?CutYpNVi04BdpDPRQ03Kz4AUZgOfAJZfYHYnvDl8zOaS6iqj3g2Irl3ay/kf?=
 =?us-ascii?Q?j92kH/SDJksO4upuDhMIk6PZ1HaI2Gc56ii6eIcjyj0p+58i/OqtR+l9WPAe?=
 =?us-ascii?Q?9XucG96ZW51QeEy1VNMRk3RCLh6wZsYVkHzWRAP/f18klChdBUXfgXrY9yVC?=
 =?us-ascii?Q?AVWbsPyqo5myvL3phDdAj9Ue7dKiVXBn8VI8RG8wxeAEEDfLGc+h1xSjqbXY?=
 =?us-ascii?Q?iDT1UgDqlyYfFkeN4pg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 19:25:51.1129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6d0767-2762-4c59-0054-08de4e229196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793
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

To reduce queue switch latency, alloc GART entries and map MQD with
MTYPE_RW and control stack with MTYPE_NC on GART. Before invoking
get_wave_state, debugger unmaps the runlist and at that time CP writes
back TC, so debugger will read the updated state.

Add GART mm_node to kfd mem obj to free the GART entries after MQD mem
obj is freed.

Use resource cursor to handle VRAM resource which maybe on multiple
blocks and use cursor_gart to handle GART entries.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 74 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 12 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 5 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f27ffe64aafa..92a21af789ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -875,6 +875,80 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	}
 }
 
+/*
+ * Same function and MQD description from amdgpu_ttm_gart_bind_gfx9_mqd,
+ * except this is for MQD on VRAM BO and use dynamic alloc GART entries.
+ */
+int amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
+				       struct amdgpu_bo *abo,
+				       struct drm_mm_node *mm_node,
+				       u64 *gpu_addr)
+{
+	struct ttm_buffer_object *bo = &abo->tbo;
+	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
+	u64 page_idx, pages_per_xcc;
+	struct amdgpu_res_cursor cursor_gart;
+	struct amdgpu_res_cursor cursor;
+	u64 ctrl_flags;
+	u64 total_pages;
+	u64 flags;
+	int i, r;
+
+	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
+					 amdgpu_bo_ngpu_pages(abo), 0);
+	if (r)
+		return r;
+
+	/* compute PTE flags for this buffer object */
+	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
+	ctrl_flags = flags;
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	total_pages = bo->base.size >> PAGE_SHIFT;
+	pages_per_xcc = total_pages;
+	do_div(pages_per_xcc, num_xcc);
+
+	amdgpu_res_first(NULL, mm_node->start, total_pages, &cursor_gart);
+	amdgpu_res_first(bo->resource, 0, bo->resource->size, &cursor);
+
+	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
+		u64 start_page;
+		u64 npages, n;
+		u64 pa;
+
+		/* MQD page: use flags MTYPE_RW */
+		start_page = cursor_gart.start;
+		pa = cursor.start + adev->vm_manager.vram_base_offset;
+		n = 1;
+		amdgpu_gart_map_vram_range(adev, pa, start_page, n,
+					   flags, NULL);
+
+		/* Ctrl stack pages: modify the memory type to NC */
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
+
+		amdgpu_res_next(&cursor_gart, n);
+		amdgpu_res_next(&cursor, n * PAGE_SIZE);
+	}
+
+	amdgpu_gart_invalidate_tlb(adev);
+	*gpu_addr = mm_node->start << PAGE_SHIFT;
+	return 0;
+}
+
 static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 				 struct ttm_buffer_object *tbo,
 				 uint64_t flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 143201ecea3f..3751f010f14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
-
 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
 				 struct drm_mm_node *mm_node,
 				 u64 num_pages,
@@ -189,8 +188,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		       struct dma_resv *resv,
 		       struct dma_fence **f,
 		       u64 k_job_id);
-
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
+int amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
+				       struct amdgpu_bo *abo,
+				       struct drm_mm_node *mm_node,
+				       u64 *gpu_addr);
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
index d867dccae675..1893dabb823a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -160,6 +160,18 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
 			kfree(mqd_mem_obj);
 			return NULL;
 		}
+
+		if (mqd_on_vram(node->adev)) {
+			retval = amdgpu_ttm_gart_bind_gfx9_mqd_vram(node->adev,
+						   mqd_mem_obj->mem,
+						   &(mqd_mem_obj->mm_node),
+						   &(mqd_mem_obj->gpu_addr));
+			if (retval) {
+				amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
+				kfree(mqd_mem_obj);
+				return NULL;
+			}
+		}
 	} else {
 		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
 				&mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 042b8e747b5b..7c95cc9e2f0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -253,6 +253,7 @@ struct kfd_mem_obj {
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	void *mem;
+	struct drm_mm_node mm_node;
 };
 
 struct kfd_vmid_info {
-- 
2.50.1


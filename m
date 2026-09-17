Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98D1C982CF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D58110E6EE;
	Thu, 17 Sep 2026 11:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fZj4uVP9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012039.outbound.protection.outlook.com
 [40.93.195.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D696D10E6EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TonnCBUoy6TVG1ushPrAVJhCDrmIv4LnxUNn0QM2KD8LsBJVHckrSDG+Sku9x2cR4Q1YMyDyp9huGM48n4hpaZ6e52py5OCgg5oKk6ofRMfGySpz0QCXMROEKCjzV2zNOGNFAUbmLpuwets/ejJlmPTGXcXu1L9+jQr4jGimLSjEF5W2ZyCreFOwqI6pv03+wW6hplqqLue6rtFtYgYQp0lUVfJqstQ9yjP9GM1COP+QdieysJwJBTvyI2lUv4Wbl0MSBn3YMOE4Cb3DahJLwamZuqP63eVmqEv15zG/AJhtX8Nyoe/nQ1dxKf5ojge/nE3IVuj1LK1VicBAz68TDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcNVrkt1FxeR2rcsP37mAVYpbcRaAUIDLJ8P3mP2b3U=;
 b=mAeFsBwoqbto30uUOSxkAtwhIe+HQwuqpYJ+WQkWLiMo2m/Obk3d5q9eP0KI74SxjVnAtZZfnsfpwbR3fD6mTZqqtyUivMh+5Nb1CzzQXGBLbdDQ/RR24CMBMFVrcxHgVMls01B0/cFa2/7wTXgwyjr+j+mPZDofKMQabz2DE8zap60j2eNFJAHepJXAsLbrRLnLajeBVyGAQnsoQVMlL94jtTsTnYYIIps5L4cdDs8MlVombvs/yNQJJQJNB1WnhqfXq/oYPriA7HhxoRv4vkc0PWVEBL2QytgqMltfVXRBH42RWlsvfdPiT2rWE6RLrUCKFxJ7krZu676Df9oGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcNVrkt1FxeR2rcsP37mAVYpbcRaAUIDLJ8P3mP2b3U=;
 b=fZj4uVP9uH2swpqnKbdU+rwUM+Vv/rhw5HvQWd8NHCLkhjOa6PvGx7YkbQB6sTQ4iEBjFUmml+ZpURaKku+om/Y4E4a8YRcoRv8lQs7dSnRTz6xwLYFjJdNMoQ9SU+5+N4Ncb50GsqtTc7E6Nb/AQ2MeBRdHJd2AWdJzSQsU8n4=
Received: from RI1P284CA0024.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:150::13)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:02:56 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10d6:10:150:cafe::90) by RI1P284CA0024.outlook.office365.com
 (2603:10d6:10:150::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 11:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:54 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:51 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_range
Date: Thu, 17 Sep 2026 19:01:50 +0800
Message-ID: <20260917110158.296198-6-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: e44a6159-db12-4927-776a-08df14ab397a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ge3l6cGFjPZvl7zAEunjJMH8Fr3Wia0R5rlCxzTbUH6WW2onKq6WpT6nTE5ykcH9Ao+HJSjreFcLx1pZhtDqUmAdVBgqDnwhasThahGY4M+znAxWL8VwuD/ILsTvNbZRc2eTpSZI4eOJV/9zfKS1lhv8MWOMFJU2o5zN9I/rT0t6NyRV0vY639UY+x7OLPY7TOfl/AQisiVTtogENzhhhDqXDCVNb9oztf0X9Cn5HmWdEO6zY68dP3awocwVICx6GdAByEx/AGyfzy5pNDcpiVirPffOFFqnmERDkJ+TMBX0vlOZ/M7xX3KMB3/WlcfpBfYvXN9B62mzoP10FH9Jk6Hz/WlcdsNn+oOSKO2XiVjRiWDnFkC++gQXgThO4DhW56nqTeNqQzWDY8h/71VZLYHvhKgR7mkC9zCJmiXCExfhhdDJTDhITj5Ll8k7XNFai9BjwmeeCr2Wid/6aFY4wUQwcHFw5eUCIwL1Sq3bklTGWrcuTflU1VTQmSOJID29RODVa1Zj2TBkcvDzcyjN1kg96go4g1l/MHino6JDau6rKWmFetd0lv2YhueW5ypyZ3nfU5ZV0zcpc6IFZCuPm1uPzC+IGhzTuCuax0VehS8VXd96GCZg+8Xwat5Mb7wRiQNfF5vu5kWWIusIZyVaiqGeHAIeqYj2/knyHMZ7Th9nWTPUMStHUAmT2/SGNn0dRxi31fpUHudU+iIQnt9Luw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qGZ+L7SigW2DbWJvds0zVS5NhXyYDdds0egwclKwCjUgjElDBl3dZ9frDtVMTvthQ2qSuTt83++C783KFVc8kNYQnOigUh2AY7GJpE5d5YcsldKAhtwZu98TzsHecPi/1JBcKq9sT7LhZNtbrNR/+I/olERus8IXvwE0GW0v5xyk4ffyzmyjK1sC7O+SRQWu7N68Jtp5vZnqSh4LxEx3f3UUAbxU1vDSwfpcxNRTUbQa8LkCzmhrJ3wD17V05ZzLT4Ldm0IX7EujK6SYjvA6HCiCc1ZqbPiX6tWsucyc7eGryZZ/XOme9GWdqKChiy/67MOJeT6ztHKc6f2kVJgAAUyE1fQ5clUbUyjltaRRWC4IqnIphDjgSLvVvbGqMUJ2G+07wxkfm0/r1Oi2b3k81B+fwxoBYcFwd1H/yXuYABFeoMcMgOaarr480Bg03Hh0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:54.5191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44a6159-db12-4927-776a-08df14ab397a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

That case is handled by amdgpu_vm_update_leaves now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 21 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 11 +++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  5 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 19 ++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 ++--
 5 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e60143d4990c..6a69e876e729 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1109,7 +1109,6 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  *
  * @adev: amdgpu_device pointer to use for commands
  * @vm: the VM to update the range
- * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
  * @allow_override: change MTYPE for local NUMA nodes
@@ -1129,12 +1128,11 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * 0 for success, negative erro code for failure.
  */
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
-			   bool allow_override, struct amdgpu_sync *sync,
-			   uint64_t start, uint64_t last, uint64_t flags,
-			   uint64_t offset, uint64_t vram_base,
-			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence)
+			   bool unlocked, bool flush_tlb, bool allow_override,
+			   struct amdgpu_sync *sync, uint64_t start,
+			   uint64_t last, uint64_t flags, uint64_t offset,
+			   uint64_t vram_base, struct ttm_resource *res,
+			   dma_addr_t *pages_addr, struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
@@ -1164,7 +1162,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
@@ -1390,7 +1387,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
 					   !uncached, &sync, mapping->start,
 					   mapping->last, update_flags,
 					   mapping->offset, vram_base, mem,
@@ -1601,7 +1598,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+		r = amdgpu_vm_update_range(adev, vm, false, true, false,
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -2644,7 +2641,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
-				false, &root, xcp_id);
+				&root, xcp_id);
 	if (r)
 		goto error_free_delayed;
 
@@ -2660,7 +2657,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
+	r = amdgpu_vm_pt_clear(adev, vm, root);
 	if (r)
 		goto error_free_root;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 826406522b24..8ab20826ddf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -458,12 +458,11 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
-			   bool allow_override, struct amdgpu_sync *sync,
-			   uint64_t start, uint64_t last, uint64_t flags,
-			   uint64_t offset, uint64_t vram_base,
-			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence);
+			   bool unlocked, bool flush_tlb, bool allow_override,
+			   struct amdgpu_sync *sync, uint64_t start,
+			   uint64_t last, uint64_t flags, uint64_t offset,
+			   uint64_t vram_base, struct ttm_resource *res,
+			   dma_addr_t *pages_addr, struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 7d3c0904e1a1..1011f49f0478 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -111,10 +111,9 @@ struct amdgpu_vm_update_funcs {
 };
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate);
+		       struct amdgpu_bo_vm *vmbo);
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
-			int32_t xcp_id);
+			int level, struct amdgpu_bo_vm **vmbo, int32_t xcp_id);
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 2f542c731447..919e1967c5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -352,7 +352,6 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: VM to clear BO from
  * @vmbo: BO to clear
- * @immediate: use an immediate update
  *
  * Root PD needs to be reserved when calling this.
  *
@@ -360,7 +359,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
  * 0 on success, errno otherwise.
  */
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate)
+		       struct amdgpu_bo_vm *vmbo)
 {
 	unsigned int level = adev->vm_manager.root_level;
 	struct ttm_operation_ctx ctx = { true, false };
@@ -397,7 +396,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
@@ -435,13 +433,11 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
  * @level: the page table level
- * @immediate: use a immediate update
  * @vmbo: pointer to the buffer object pointer
  * @xcp_id: GPU partition id
  */
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
-			int32_t xcp_id)
+			int level, struct amdgpu_bo_vm **vmbo, int32_t xcp_id)
 {
 	struct amdgpu_bo_param bp;
 	unsigned int num_entries;
@@ -471,7 +467,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
 	bp.type = ttm_bo_type_kernel;
-	bp.no_wait_gpu = immediate;
 	bp.xcp_id_plus1 = xcp_id + 1;
 
 	if (vm->root.bo)
@@ -486,7 +481,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @adev: amdgpu_device pointer
  * @vm: VM to allocate page tables for
  * @cursor: Which page table to allocate
- * @immediate: use an immediate update
  *
  * Make sure a specific page table or directory is allocated.
  *
@@ -496,8 +490,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 			      struct amdgpu_vm *vm,
-			      struct amdgpu_vm_pt_cursor *cursor,
-			      bool immediate)
+			      struct amdgpu_vm_pt_cursor *cursor)
 {
 	struct amdgpu_vm_bo_base *entry = cursor->entry;
 	struct amdgpu_bo *pt_bo;
@@ -508,7 +501,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, &pt,
 				vm->root.bo->xcp_id);
 	amdgpu_vm_eviction_lock(vm);
 	if (r)
@@ -520,7 +513,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
-	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
+	r = amdgpu_vm_pt_clear(adev, vm, pt);
 	if (r)
 		goto error_free_pt;
 
@@ -812,7 +805,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			 * address range are actually allocated
 			 */
 			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
-					       &cursor, params->immediate);
+					       &cursor);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d51f60..bc754f407f00 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1406,7 +1406,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
@@ -1518,7 +1518,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
+		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
 					   NULL, gpu_start, gpu_end,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
-- 
2.53.0


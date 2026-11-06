Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AD606A333
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l29JYhw5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D7910F4F5;
	Fri,  6 Nov 2026 09:56:23 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C5510F4F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 09:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywl94Xslx1Im56lL7nf+jarTIf6Zz9OTbsJ1yGRjMmsJwzPDnH6Zus9tIZWtwE35t7PjqrF0cvzknHMu6bjj4qGFbBXu8I58pc7pIJ2ZiTE2MPP/1/s0dzlH6yfZrwBHKg5XeIy2r+1xcEO+KQOE586FIaSSiRQfbdiy2jivz//2LfSqdiDG0cpczLTtvB6U3wxRV/oihTPPmMpP5Pn35HiUKWQH6U1EIZZIf7LpxA1N3H+qhOSMLMbsq0V41BeClwJjN0lQB2PuTX3tDu9uuDqdk+OnZOhufQIxP8pr2us3OIs80FxdZrTbXHTUoUgRbGgvXCyT8g08i8msFDeN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ5fovhOXVu7ntnQV7cqwawkqz6DhPYiVXOOjq9eZow=;
 b=aY25+feDMDynB7IBFsl95xrfQDGPUfAXjY2R/p6iae6CF1+/SHm8lkIv9gyUsaxnvStt3/tIe42r7uhuY7J+fKwWEMuDJPut7IBs9Q/8GnxjuCHZNl1rbUCRJkRx3SlH9ivEQoAcVky7graJulHOz3gkgP6vpa/aNRhfmIyFBY/omo8061eRCwLEvIdYlrlNMyTETeQWVzyyytNNYYEBKRNfS7BTvqo3qv/57YjJlxTMJOAuWxrSc2GY+RRMq8JYpYMi65/cEmnS/XOTIjv0N/2xoBKoQovZC4S/VuFVk61tERVYgf4xpdsGVLjiutCxCczYb87u4xk9oboBd9fptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5fovhOXVu7ntnQV7cqwawkqz6DhPYiVXOOjq9eZow=;
 b=l29JYhw5SDnazmhiroKlIfniWob8GT6JCpfnrD3fHCfB6DN2Z3ykgEhqwg7hk5oQ4gu1ZtKf0/UyYexlg0KiR84XBzYS/aYjgIUQ0DaAcc5j+KR8lTnlCkdKQUNOdJ4YHwsebKh7HYhdSHmrBG0VEJb27nsHC3MhlItjwrtKY84=
Received: from PH1PEPF00013316.namprd07.prod.outlook.com (2603:10b6:518:1::5)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:56:12 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2a01:111:f403:c936::1) by PH1PEPF00013316.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:56:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 09:56:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 03:56:11 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 6 Nov 2026 03:56:09 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: don't take a per VM kernel BO for a page table
Date: Fri, 6 Nov 2026 17:55:17 +0800
Message-ID: <20261106095608.1538768-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|MN2PR12MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 29574702-d21b-4cc9-4cce-08df3bec3061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|18002099003|11063799006|56012099006|3023799007|261009223027099003|261102123227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: i0P6U6jZLmxAP5/oUEEN2uy/eRqtxCBu34pzIKI/Zw2r45WgsCDr0aioTe9FLlPSK9XTssF6+OBk2vREzIK3nmSRzx/qjREDJMMa71QTLMlppAVfqGI/dxZm8LTCyd4ZCHh/Xgu4xEpaSk8Uu+vrQLS7TdUozec9AzU5EBYNbnytQhmNwG5gzBnQFQ5Ne5QnB9o1HLojtweWE1BaHeRBPjGExz7/XRHoFOux2UrXjJ21p+ZLoJ4z4q3YX1wWYKXTTUrEowASosPoY1kA1ZnJ8eQOOrrYZMj6vs7zW4269/y8dlmRSrRXrW91frmukaQ9n0vKK5dR6yQ5/sCP1o40ESnzjXayX/XYP9ZN3VZ24xEOM4hF7nBt2pWn9U0FbzVLM7hbH+KouC3JK+3bRPUCIByISi6dhubYkg6m33YzxxY98dVg/t4K2ghpiXT0DkjnZZsjBtCuvuVaHvwcYeyrpL0z4iQJxLfZi2AXxgSDJ/Aiyogl9gwhzuGuaX4O2Ld6qF5YBXDuKXfP7UdPAm4sMYyWQ8YWqmFvtqDnCPJq4dHgSdc8X7n8MeSZQ9rUQBqw1P0sN33ftF9xZSHoMjG7aqLrQyBIa9uS50ERosdon1Wpb/LH69GvOvyjleHN4SDkR4yKZ5mNNCZR02EERX+AVe1a2YGcjzOYDUEhGfQW6Bz9ZahDYGMYoDXOaBvdvnWCU3ZtliNiRKDQHMSDfTIiwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(11063799006)(56012099006)(3023799007)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wLbce5iiJDnkUs0v68TFJv5LUcQJSruVN18SW9Sp5MkvaEhevrXSL9qpWAC2vOebN/nO7OCuoL61YlKionvBVHU55xH3eeQSf5IIf85nPBB2/k2PRebTrSsKt4RZ6+i+eqKHfGdiN+Y2soTJZHf/XKkf7aHk6AbugD9os+s8VGBPNH5kjXzRNb4SdWKIA/fV5JODzihxfBrvRBemhTDs91ombGDZcatcfxcb6DS2A510aK7UKgPqFBMyylDaW9X9YSzZ6Oo15yVZFBCCYV792BOIE6zYPj+7OMqWU8Pl3HXy9H9AEJDOa5rXFn3Pq4AthrkgeCGQCA2uw0tmWHVZg8wxLiDj1XBkCLM8siJsPrCSqViWLEbZpNb5SlyZ/kVV7HpTnjS6zI20o3jwN1jccNvTXTygSYxHxS6WXzi2osloBkhqQ25eevToSIIch2cz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:56:11.9006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29574702-d21b-4cc9-4cce-08df3bec3061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_vm_bo_lock_lists() puts every BO which shares the resv of the
root PD and is a ttm_bo_type_kernel BO on the page table lists. The
CWSR TMA BO which amdgpu_cwsr_alloc() creates for every opened render
node is such a BO, so it is treated as a page table: after a VRAM
losing reset its bo_va moves to the page tables needing an update, and
amdgpu_vm_update_pdes() tries to write its PDE. It has no parent page
directory, so that fails, and fails again on every following
submission of the file.

On navi48, submitting on a render node, then amdgpu_gpu_recover and
submitting again, also with a new context:

  amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
  amdgpu 0000:03:00.0: GPU reset(1) succeeded!
  WARNING: amdgpu_vm_pt.c:671 at amdgpu_vm_pde_update+0x329/0x5d0 [amdgpu], CPU#0: vmreinit/2629
  Call Trace:
   amdgpu_vm_update_pdes+0x262/0x5e0 [amdgpu]
   amdgpu_cs_ioctl+0x35c9/0x7a00 [amdgpu]
   drm_ioctl_kernel+0x180/0x320 [drm]
   drm_ioctl+0x530/0xcb0 [drm]

and every command submission fails with -EINVAL from then on.

Don't look at the BO type, let the creator of the vm_bo tell whether it
is the root PD or a page table, like amdgpu_vm_bo_needs_update() already
compares with the root PD instead of looking at the type. The TMA BO
stays a kernel BO which userspace can't mmap.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2ba33212d507..a7d6f4b1efd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -162,7 +162,7 @@ amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
 		/* No extra locking needed, protected by the root PD resv lock */
 		amdgpu_vm_assert_locked(vm);
 
-		if (bo->tbo.type == ttm_bo_type_kernel)
+		if (vm_bo->page_table)
 			return &vm->kernel;
 
 		return &vm->always_valid;
@@ -408,15 +408,18 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
  * @base: base structure for tracking BO usage in a VM
  * @vm: vm to which bo is to be added
  * @bo: amdgpu buffer object
+ * @page_table: true if @bo is a PD/PT of @vm
  *
  * Initialize a bo_va_base structure and add it to the appropriate lists
  *
  */
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
-			    struct amdgpu_vm *vm, struct amdgpu_bo *bo)
+			    struct amdgpu_vm *vm, struct amdgpu_bo *bo,
+			    bool page_table)
 {
 	base->vm = vm;
 	base->bo = bo;
+	base->page_table = page_table;
 	base->next = NULL;
 	INIT_LIST_HEAD(&base->vm_status);
 
@@ -1805,7 +1808,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	if (bo_va == NULL) {
 		return NULL;
 	}
-	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
+	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo, false);
 
 	bo_va->ref_count = 1;
 	bo_va->last_pt_update = dma_fence_get_stub();
@@ -2704,7 +2707,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free_delayed;
 	}
 
-	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
+	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo, true);
 	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
 	if (r)
 		goto error_free_root;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d8e17f493f61..a58797e2b590 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -224,6 +224,9 @@ struct amdgpu_vm_bo_base {
 	/* if the BO was moved and all mappings are invalid
 	 * protected by the BO being reserved */
 	bool				moved;
+
+	/* True for a PD/PT of this VM; constant after initialization. */
+	bool				page_table;
 };
 
 /*
@@ -470,7 +473,8 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				uint32_t flush_type,
 				uint32_t xcc_mask);
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
-			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
+			    struct amdgpu_vm *vm, struct amdgpu_bo *bo,
+			    bool page_table);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   bool immediate, bool unlocked, bool flush_tlb,
 			   bool allow_override, struct amdgpu_sync *sync,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..481f697ce9e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -542,7 +542,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	 * freeing them up in the wrong order.
 	 */
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
-	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
+	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo, true);
 	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
 	if (r)
 		goto error_unpin;
-- 
2.50.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF61C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED03B10EA7D;
	Tue, 30 Jun 2026 13:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mjlbie/F";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9DF810EA7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luCn4DaKMuusFHxXZkeJAyx6j0JQAWO7UPxOwA06qcvvpqMQNBA/DV6eiJBo4qmZcZ0zmCVj/yLsdg/nQhyd1m6OoZkIgclOzOpe/JGGimTZtW0Q69Sfr6J20zVEltLMzPUsQ0ME8gJQKhVRJxgItt592nmqWAWakA0fpwBtvlK6ZXDvuORkYQgW9xUFOkdi6HhAWHPKjb/XuT7xPE3bdP4tgRVjQ0/QcGMoIatMVyfnVEINsMbmuqQujsqI789pf9q3LYmyxafUEGowVguwjpyonjnGTohZ3tuP5jPm9hLrfOrOdVHFht4BIlQ9u9qVNBj2hzQsNOHdSKJlhVS5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HhSSGdimwEbGxU7QEO9onsV3xYxzvb5qUn/B/CjJ+A=;
 b=Q440CRUAWwZ5OoQANZpdQnyd87bPtJbdk7T/RGQpUNWQ+gqPUvbZmwIJ9sttocQmFpBy0AufeTsmZFKQ9jl/bYM56jBWRuf5M4lbodjQ6vkS7WrbEMQshLGvHxhyLZovDq8zQ2UARYkEgcP98+vJbR2U7YlIsBsYcOCF7KBD0y9ySsZRBZdtficXUle50qH1YQW+3PuGwyNuWvEwY2UDAk/nJ/v02tXZF5r+Di7Yv2StuuUrpG5Z7mGSMo8bgCSCFXXLE+qmFHzgx90pwnsf6l3j62LeDxhgwpPZuJM8QyV3fUt2PyuArNIq09ksLNWonHr8P0Yu1oclx/paVwDrsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HhSSGdimwEbGxU7QEO9onsV3xYxzvb5qUn/B/CjJ+A=;
 b=mjlbie/Fca6p0Ko2LyUSBs3LlI7qJPFpIJvEWu4DzMi11XVtvxYJ1zRxv7vvxUnXiGOFWZtXAozJ63LNsrIXBuLnzw4opcWybTF5+UQuJdz50HQZrEyLyjxU0etV4n+H88cCHwHA3R3VeQ87XXT8iv/jTGMydhEEYDcEVg7m6AA=
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 13:43:50 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::94) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 13:43:49 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 30 Jun 2026 08:43:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 4/4] drm/amdgpu: Drop vm_manager PASID to VM mapping
Date: Tue, 30 Jun 2026 19:13:24 +0530
Message-ID: <20260630134324.3118873-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630134324.3118873-1-srinivasan.shanmugam@amd.com>
References: <20260630134324.3118873-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cd3f93-9b51-454d-414c-08ded6ad9dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: T9x5A/z/hfR3e1VNgR5Ex/ktjIOPYk1JileXseYAccUzewG2vCQUyk7Uaca52fFZ6VnaroksYxYg1b4Fb16GlG7xhJN6t+xk9sV688CrylyhdK5sg/zGNKv7KYs2ZXBNgpNwosNKy2xBwnvu0WekJro5IfOVyw/kBAEgQRxa0rYXLTasBB+GDSN4BMOgwnqlvm24HUnc3UkZ3R8m/39jq88bz9ZzmmTvRpiBGAk3fnzQ5I9XH5n16FGggIB5SddCYkAQWQfJYRfudmNt4ifPqgTfpHchqRaqqYCfUx80YSynPOhvWRjRKFUXR6ToNGsHDQEHJ2YviSAF0NUYsyqjcmC3D7VJCY6t9QZYiWoDh8UxrOOHB4s51zAtDdsqOTJ9oHId8lJztcYUNfaQdmKd7tQHBK+pfO+tFfrWOA+LKLmwWkXkR1LXBdmOuPCUWrsDIAjJ8hd0Cdr7euTQtLmToj/czNts1f2CiiHKELigoInkjFJDE6x5BQdcWCWXnVlgJ9nAQ3GBiz4rZv2J9lHchZCwe2WZIaSdKLBMlR9K4t77aH3BessEfzF2Yq3ik7Tbsa6hz/ULyqCCZ2pwsnZJPKPLnm//Pi0PbLxPv/ZkePi3i/QXLtPnTCKGnHM8eoXxzppNGLVzBUtJjChqcjlsJ0Q5FBz8wXNfT1vz8SFyAV5MzMpG6jUy9OxktHJZ2lNkxSsPePrc0ObCnsNoJEzSKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fQsSx+I15wXP9+wyMpfFQoip2L879ReAj5CboCeGdwvpwRB+OGj1po6xNwbVd9i8X2G6eLfLLJDXnjOufM+tsjQJqxTIyQog9xOqfpxcDQ9XH4ot2V30qtheceZ67LTg7jHlL8Aleap3KDJgApaauvvBR1ugiiNRFgK7Vn26kPr83+9J8e5lJA2rq0BH2yda6vArRnRNRe9AWDje8nqQNV1SfIkyLEUCjOeD5oYjjnYbYqMc9xpOavOKlsqyOT1u9kgNLoBD++IEnYGv4CVRwxNSJjB9GceMdroZsr930WsewvfeFxvtRaFN9NyD/G4vSAZoVxLtJUlIGSBCLKiujDkDaEuG+jGxYue8riC3pNpMTks3c0dDIoQ5YwLV4hFBUNzalKzOj6Afe3X9G7QQRFYi5ONVBGjiOQPSzP2n44uIO3KsStFMxhr6bx70Q14x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:43:49.8625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cd3f93-9b51-454d-414c-08ded6ad9dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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

Remove the PASID to VM mapping stored in adev->vm_manager.pasids.

PASID ownership is now tracked through the global amdgpu_pasid_xa
infrastructure, allowing PASID lookups to transition from:

	PASID -> VM

to

	PASID -> fpriv -> VM

Remove PASID registration and teardown from VM init/fini paths, drop
vm_manager PASID initialization/cleanup, and remove users which relied
on vm_manager.pasids.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 25 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  4 ----
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 44403f856c08..ac723832be79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1368,18 +1368,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		struct amdgpu_fpriv *fpriv = filp->driver_priv;
 		struct amdgpu_vm *vm = &fpriv->vm;
 		struct drm_amdgpu_info_gpuvm_fault gpuvm_fault;
-		unsigned long flags;
 
 		if (!vm)
 			return -EINVAL;
 
 		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
 
-		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 		gpuvm_fault.addr = vm->fault_info.addr;
 		gpuvm_fault.status = vm->fault_info.status;
 		gpuvm_fault.vmhub = vm->fault_info.vmhub;
-		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
 
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ef7c1efff10e..58c438d952d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2643,14 +2643,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 
-	/* Store new PASID in XArray (if non-zero) */
-	if (pasid != 0) {
-		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
-		if (r < 0)
-			goto error_free_root;
-
-		vm->pasid = pasid;
-	}
+	vm->pasid = pasid;
 
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
@@ -2658,11 +2651,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return 0;
 
 error_free_root:
-	/* If PASID was partially set, erase it from XArray before failing */
-	if (vm->pasid != 0) {
-		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
-		vm->pasid = 0;
-	}
+	vm->pasid = 0;
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
@@ -2769,11 +2758,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	/* Remove PASID mapping before destroying VM */
-	if (vm->pasid != 0) {
-		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
-		vm->pasid = 0;
-	}
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 	dma_fence_wait(vm->last_tlb_flush, false);
@@ -2869,8 +2853,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
-
-	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2882,9 +2864,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
-	xa_destroy(&adev->vm_manager.pasids);
-
 	amdgpu_vmid_mgr_fini(adev);
 	amdgpu_pasid_mgr_cleanup();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 4d96bb8c2c6d..409bbdaa4517 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -480,10 +480,6 @@ struct amdgpu_vm_manager {
 	 */
 	int					vm_update_mode;
 
-	/* PASID to VM mapping, will be used in interrupt context to
-	 * look up VM of a page fault
-	 */
-	struct xarray				pasids;
 	/* Global registration of recent page fault information */
 	struct amdgpu_vm_fault_info	fault_info;
 };
-- 
2.34.1


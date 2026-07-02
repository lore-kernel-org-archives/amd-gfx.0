Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEA2C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4F210F24B;
	Thu,  2 Jul 2026 08:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SznDdEkS";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C094410F24B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQe/NqVebUXkvyREdsd6z+EZHkwJAqyaNsxgn/mt/WEy20QxQWx4dtR3C5wxTsX2LPPLTGL30ykR4txg3cyqem0U2gP5SqfV5tnYHOYZPiRkBPqGLaI5JKbayq5zhEjvqeFtaxm7t6kKRpxxru4MS/SXhLa0fKhFfqhpS3r22f8CHHumiYgJyjxc4os2j/mPYS6ETdgQEtuhmLz3W5KY4C5OrPJuQvK6VK389pxoFxFvsgV3aJtMk3NB35fc8JZI71/vLsm/jJUB3Uupbl7Mu5LJ9tb4kSnRnfmAaVacuuu6u4Jwz35NgGFtvGu0A2hWnSWVicJU21y9hqA+HRQO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAKlPsXbN7VLdqtvUcxuoQBXSBo09c8WcbFAb9Sf/BQ=;
 b=hZlW40kaDyMDmlF96UJBxQk1FLUcT7QfTekndstjCrCFincQMmA4Z0rM+dgfLRIwobrOZ3MvLaS5m+Q4KFg6S79llHoUjRQ34cQGF9CM96d8tI8rUb2YLaKx/bpP7XHmHhab2NtcH0bfMlDZVJ3GF/ofNudNhmK6sHs+izHDS6vuWgvI1XZbCMFRe6z03bfQ3ICxVvQnC3ZXdtWMnNjeVAS7LbTkzfeSch2uZIps8oUDnY3nRYiElxY/YZDVQFT1twtP3wHt3lGigA8mn+VA5Hcq70Svu9fI/HbVIPpwifHu3wvBQ/BJUqFRltqI8G2Ud0lX7G1pXLhkuvAed+m8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAKlPsXbN7VLdqtvUcxuoQBXSBo09c8WcbFAb9Sf/BQ=;
 b=SznDdEkSVl17dvVQQ2IcnqhWCxXYQajM/Br1YcBDp2wurakcwrGt7p/+et2tio2rwCXDjZL7Hsqxu1dQBdEMfLPHmat2wRxHQP5+EctivtrT2oY025JkPIx5GSvf28hG1vs2U4Gm4rIc7HOqc94IWokYA/nlvbdtttyv2f5otr4=
Received: from BN9PR03CA0580.namprd03.prod.outlook.com (2603:10b6:408:10d::15)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 08:40:51 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::82) by BN9PR03CA0580.outlook.office365.com
 (2603:10b6:408:10d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 08:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:40:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 2 Jul 2026 03:40:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu: Drop vm_manager PASID to VM mapping
Date: Thu, 2 Jul 2026 14:10:21 +0530
Message-ID: <20260702084021.3140071-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
References: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 940d21f7-80fa-4c4a-f03f-08ded8159ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 6P4kqUAEJWYwHsoMpxjhmnpZ9Kp+EIKdrTfqJeU+Ua3kQUiYpCmxJ8ryTVd2wKWOFBtbdTkxr73xPnZ/92gLsmDyV9eE5h6fV2HrAyAen7fiL0N6yZTnf4lM7qnbpTqcj+SjskPviwmCvonVhufhF6Rjv4bpr86VMD570C02uFEUC49JLQyrjdpX0gx4i4nGhz1NUNKUP0VRGgl+A5B4Vo+H/Sf6m9Y5abjN9OB51g9BxTUf3um56S4gnuVI218WJk+M7AeHW1Fm+MNWBJjkDnGNVVT5OLt3+Rf/DVHsFhUrYS3PyqedebzR26A6ZaIrA93x+Y++AyEpY67jfgq6fBwzdgIvkjTfoTLdjZ8MZxOrtk0r/hkiB/bLULHZvStk9LOVGhdLv+dZzyAYu/m9b8pNoM2Kp+IGqwfUJfPDiScblMJAiDLc9WVC94BNLK/GMqIYod+D38CJ0dc+xZ4P3Plzw62jzZ21kbozjKD7zUNXpCrkzODDOckEwFaifqGg18DvMWtWPKcX/Y+JkuI1uaSQ5klTes+mIT2LTEGPoaA28hLQid0ijr2k4rxhCnvdfh00LuImT3HiBKBQJ6GK2eexPLg6TaMlAE9so8wijeCOuW7Ui+SF7Vatfdd//wjLQOvMRn60mcMikJt+JPhtApQDSSdWgvhp7nLIrFv689k+H2Lry4E3ygoEgeRCybGBpZa1kRq6UK5dShbNju9/5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KLOUok0ThJQyn3SXL6UAtQJSG9di4Ty+80QRpHGDnZzirl6dA6664CVEGNNvIqutTzpIc9VM6wNr9zSgFKEwh/Z2gLv584pTLhF1OxuinaaqwKmA/UhORPEJvgQR3l76C3LRHFKaNhOUQnwrkqLywI7SSm/tAuqdUqMp64F8JAraWuSOmHmXibHq7bqWMKFWVwtNByWjkE1AW8oP+YbWkA/wrfz6hkHlUyisZHG3t+8aabaBjrx4MeBtjUy70uKNS/0zPRXYVJpINquVeaLcCCKSURd+4zfHa6oXdUP0n3CCTuPqnNlUtXABCoPsjrPaeCKbT2M0e5CGbFD/de0wVSQcT5pWfeWdo95u9sxWADBcx3Z3nFT56FjE9oGMMVKwlHNRB1o002GI4DHGWcYPbCGUjY47qUhS51VyY++QLwpMbcpQx4P4YUxt/g+QhRy4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:40:50.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940d21f7-80fa-4c4a-f03f-08ded8159ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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
index 7f4727bdb6e6..72ad3f115887 100644
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
index 462761259d5f..dddff9d08fcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2647,14 +2647,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2662,11 +2655,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -2773,11 +2762,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
@@ -2873,8 +2857,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #else
 	adev->vm_manager.vm_update_mode = 0;
 #endif
-
-	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2886,9 +2868,6 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
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
index 939f639cd8bf..f63364f128bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -481,10 +481,6 @@ struct amdgpu_vm_manager {
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


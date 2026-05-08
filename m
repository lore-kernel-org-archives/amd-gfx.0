Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F81CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 06:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E555A10E5BA;
	Fri,  8 May 2026 06:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wOoj+rM8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010054.outbound.protection.outlook.com
 [52.101.193.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96CAA10E5BA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 06:18:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCwY7FCmykae1ccGd/cjHcPoRnqYjMuihRNqkEqdKzTMytwxjuNgsyd8Ep3qEu4WKA6W3jMvUBiOBmhRwD1DAAvdvEsYUhjduAh9ciO+IUY3CLG/tzvrIQTZO9XpqKSaR589lDyiwoI+cBETUh3wTj3WFUIkoriYrHW9UPvefi6AW6g5p7akmSFaeD0YVIP8nmf2uDTk9RhrqoHU2CSdsVu6GxH3ePia8IAJhBLX4/p2FgbLS8CPpSeHaJ0ua/BTO3iSkMsIblcniueLw+jGjkrCVccRAh3jf6/ZNgl8OjGCkKITuVm4LYwaO1id/HonFlslJsdv1yH1AtAr51f7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvQ4Ak5seqsOLBuAWz4TLtk+zCkRDMIDs9y9qgu7fSA=;
 b=A36WRomP5l/QLfc89n1v1L6jeYXgiP4lpGlCLnFRM7Vku6HKw+rHaFQbTxs3z/86cMzOl6n9p6Rhg9xCMo55u6eGumBzCP81CLPBWgvoI2fyQvvxINJKD56dYX6l7gmWWOmuqt5Gc92+zsQ0/hiS6vSefxjr2b28n0QCae7JGpBLLoxTe1/hFC8F0vx/JaALyEVIoGLcgy0G7ecZKyrtoM6UF+Xg5PiAQhU3tT646m79pEDrczUcjRstJN89YxIRhZR5UVnDlmvgCibPnH4E++qYezk7e+hirTbChtcywJ2trJL8tUfw6VYPRSf31T3AkVNonuoRjRksac6mr5cERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvQ4Ak5seqsOLBuAWz4TLtk+zCkRDMIDs9y9qgu7fSA=;
 b=wOoj+rM8ZguvoETboGwRbH0yJdza2/obMp0AucdR0kK4fk9xikZMWmn1VH3AvUKBZySY3PinNPRG4Y/87rwb88QP956MLJvCUWlmeAae2/h+0IBjtBZB3Vbx6KT62Hnbpb+29POOc57mmYYvJNAfLfETaBjN+mRzDvD1iWNIUjg=
Received: from CH2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:610::48) by
 SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 06:18:07 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::da) by CH2PR05CA0035.outlook.office365.com
 (2603:10b6:610::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Fri, 8
 May 2026 06:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:18:07 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:18:03 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <felix.kuehling@amd.com>, <phasta@kernel.org>, <Honglei1.Huang@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
Date: Fri, 8 May 2026 14:17:38 +0800
Message-ID: <20260508061738.1039917-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e62c1f-1ac2-4be4-8576-08deacc99223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: l1UQ75sOkZE+r3jCghsV00O8jxcgljZ5MeRP8snQORHASekR2wCI0w9/8i6SFfR+rFr9F2r5QaXPSts1RhMNh8OjV/iujMBB7hGFNnJv3OfOXxzRW1r53KKbIq4xO/KFe5UWTKDZfI6mzNE7EQpbVlt4fEkidq8w6/jTYRyhSaxJ13Pbbc5aOXDU3P9Qua+M3gTyeo23bdFqCbUDtX9fBZbsJWhF+WwvNfDfPOB4Xw5nTdaooZ3FL0ZH+xMXN8AZjuL+0Wi1K0TrDOtBNMHh0mzwuXHanMOrBJgWbiIAg7NqU9pk0MQSj49UkQlypL8VvsM7hVBR4OdQnbyxW527bH/oWP5yPmqCVLlIfr19kxCHYo9WucCknVBCeLXbmddhplKKnAcqfZ3buD06wSIL6aVF4PfD1BhOSA8eVv3sxryocFWdEv/B5xi9VSSWdHd8UfjTxOP+FmgJS5u50BjKy+yg6Y396fNqkPVdCwpvQ9aDJCSlzdiAhIwBA5j8VkJ6scMXdsWzph9rnuFI6XwzXWHv9lxF5TqEgy9d37S9UcX+OjCn2OR434u36KWYqnK58Y5o1h4afjiHjD9PDIlGIotSa6vQ4zwBwv1DwNGLGTuPCygDPDpSOgybwtPrTO1H5QHi7dfd2prvip3LNNW/TP4mEyovuQ+LfjnvSOLR619ZidCxhviNr6BNeG9Bo5lpYril4PIsinzjdr9yA4UxLHskAkoN+9C2FUndZkx4mLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jMzpVrXa/fKPIIhNJJHxgbeReFzSk3WtZ/wtzd2KCWNvhevdSqU9BatmkNUJkULKFRlSoMoqmLNnNEBfudDRAYCfTKXaTpja+r/AXWGZL7AJCkWpFtb1e6EVtPvjFrwlIsJRPbqI4Mn8Ctyofrx7xH0tpKOvrnwXhgWPsPsEiTeTsFld6ljZXxDe0OP7OFW10Klv0/KCVgyqzEgjquv6NXRRPPmGHvSfUEpKMR4tY2YuoaF6ZXQcr2UVoT32XzNgavEk16CznLoc8H7rgkwl/P/jXO8TDtohQ8mmDSIX2CrYDXR/a6fvUMk9lab8NJAE8wj64supny45G9E3j6n3IurvL7Adh//MU2Yql0QqzEjK6pPvCMjQ7JTIzvmUP5xzPyU9GMlJRSLVLDOYlPzYz950qhQ6NNRL23FxnpSGkzdMAcO0gnUTOC7I94sZWcCX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:18:07.3110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e62c1f-1ac2-4be4-8576-08deacc99223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
this window can result in uncompleted PCIe transactions, leading to NMI panics or
system hangs.

To prevent this, Unmap all of the applications mappings of the framebuffer
and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
during the reset process.

v2: remove inode in kfd_dev (Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 11 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 17 ++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 6 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2bf6a31c194d..5333e052d56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
 
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c01492e69dd..2b06a2dae3da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -139,6 +139,17 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 	kfd_mem_limit.system_mem_used += size;
 }
 
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
+{
+	if (!adev->kfd.dev)
+		return;
+
+	kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL,
+				    kfd_doorbell_process_slice(adev->kfd.dev));
+	kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO, PAGE_SIZE);
+}
+
+
 /* Estimate page table size needed to represent a given memory size
  *
  * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a..c741a1a2a8cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5840,6 +5840,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
+	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
+	 * accessing them
+	 */
+	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
+	amdgpu_amdkfd_clear_kfd_mapping(adev);
+
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
 	if (need_emergency_restart)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0071d6957828..1dd343f0219f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -46,6 +46,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_reset.h"
 
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
@@ -118,13 +119,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct drm_device *ddev = bo->base.dev;
 	vm_fault_t ret;
 	int idx;
 
+	/* Prevent new mappings from coming in during reset */
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return VM_FAULT_SIGSEGV;
+
 	ret = ttm_bo_vm_reserve(bo, vmf);
-	if (ret)
+	if (ret) {
+		up_read(&adev->reset_domain->sem);
 		return ret;
+	}
 
 	if (drm_dev_enter(ddev, &idx)) {
 		ret = amdgpu_bo_fault_reserve_notify(bo);
@@ -140,11 +149,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 	} else {
 		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);
 	}
-	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
+		up_read(&adev->reset_domain->sem);
 		return ret;
+	}
 
 unlock:
 	dma_resv_unlock(bo->base.resv);
+	up_read(&adev->reset_domain->sem);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84b9bde7f371..1be1b1dd2341 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -69,6 +69,21 @@ static const struct class kfd_class = {
 	.name = kfd_dev_name,
 };
 
+/*
+ * Cache the address space of the chardev on first open so that the reset
+ * path can drop all userspace mappings of doorbell and MMIO ranges via
+ * unmap_mapping_range().
+ */
+static struct address_space *kfd_dev_mapping;
+
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
+{
+	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
+
+	if (mapping)
+		unmap_mapping_range(mapping, holebegin, holelen, 1);
+}
+
 static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
 {
 	struct kfd_process_device *pdd;
@@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (iminor(inode) != 0)
 		return -ENODEV;
 
+	/*
+	 * /dev/kfd is a single chardev so all opens share one inode. Cache
+	 * its address_space on the first open for use by the reset path.
+	 */
+	if (!READ_ONCE(kfd_dev_mapping))
+		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
+
 	is_32bit_user_mode = in_compat_syscall();
 
 	if (is_32bit_user_mode) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6ff1db477f9..f037062c33ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -399,6 +399,7 @@ enum kfd_mempool {
 /* Character device interface */
 int kfd_chardev_init(void);
 void kfd_chardev_exit(void);
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
 
 /**
  * enum kfd_unmap_queues_filter - Enum for queue filters.
-- 
2.43.0


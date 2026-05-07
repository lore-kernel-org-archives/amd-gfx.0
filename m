Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C3CCD343B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 14:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA7010E262;
	Thu,  7 May 2026 14:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2P4HWdn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6582210E262
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 14:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNfo+qDwF4mAaq4m+JbMpI9q03Z+3z1DG/OJhuqlgkLk5mzXpq1mTLBEJB08pCQRTjPdpCd6dcqjReoVH54YOT55Q+GkCANodnTqBnaF+VXOIMGU4JaRLm39P/mBrJkwDKo7YtVRz72CEmTKNuvfdMYRXq0P2/caxswZq9mUiQfOuXiSUMouTa/F9MHgHBVPS7lKhPTKt3iqDxGw2XcEqBJU70wSUSOqifqQxHj/qpFexGMGhiMhS3mLcboNYuf5yUM4T8JNV1wmIOj/a/G76rTwB7RL0IUC/526LDYsNzv9EbjlabViwzFUGDi0Eud32p7ZYfL6BlU84w6CSkD9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMj9B9ZL21yOSB1OtOSKTKZZxGVTXB/pwVJy8CZG/4Y=;
 b=fv4GI1tMiT0AmyGY9zA6b3z1zqxxz7s7H80kzvKEAx+7zO9xpv8DWa1EzDsY4+RQTRulYMdBhJV/TDBveboxp/e9EyeRZmQ3uzQl+cfIG7hRj2mzl6iWqhyIIQuSPrWKxdqStEk43ewSJR1aNv9PloszQNPOvAmPgQKKpLW5RwmitePnX2NDaV7R+qFRCGBu77VblPezmJC317/Ft44+CtRP1n+LYVyCDNT055Fs7vmPIDUQLxyhpLhaPhgEde9bwjhiw5YbqZX4CXX+P4w9PZDRSsgfFFnycIg4amudhEK2RRzGCrCysGBPwNY60yEBCKH0OIN6CCxc0OOJgL6ZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMj9B9ZL21yOSB1OtOSKTKZZxGVTXB/pwVJy8CZG/4Y=;
 b=S2P4HWdnjLARZdR5Oz0jLskDOYN8lHPNss9uaA6sELqCvkjWf4H/XTtrU2ngvCS2DbnLTktJ5ixmzwWd3XvDmO9OjPKXDOBM5klkxWATlIqWhbMtA0iEGs5Rdnukzt/rCP3S1Vex6z4eHu6CdI8Gbzlalpy/F4fz7lsYRfui/H8=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 14:09:50 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8a) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Thu, 7
 May 2026 14:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 14:09:50 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 09:09:47 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
Date: Thu, 7 May 2026 22:09:34 +0800
Message-ID: <20260507140934.1001909-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab4f0fb-27c3-452c-eecd-08deac424daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IIbSM8DDx8cw73Deaig/hz0CAt5P72bM1z0ykWNsZBeoL6JErzgE5qbtIVCjRNnHvFv5cpbp83WGXFGsa2H7fX0qjvTOhy4bGo3cidBfXssfQFbni+U+4NFsuGNtWdgnr4zmnEe9KnPDyHmwt+QpMrX45Nk7g2VMXndDddoHye1LJbcz5pxfFDKPmLEy06+tUybqte9JXHLfYPeSdBxdRLTPeeI1XH75UfrKu+lOhypdaCy65IJ8DHcrovwXGC0GjVReo6FGy0IjXAxxLxpcWjYzPAfq/K32/2KZB42qh+1zoOq4CAWfqFZL3bdqaNXFOpGzuiQuxnzKIrFLDTkAYJPN27dlMbH1CYiCoBPf98EXTPKTtchgwRjlkrVCmWRGCM6B7n9xzDCd3AqsF5NHsqDNQZAIkJw0XH9gkBN93qU9n9PR/G1RsubUi9kiAXp3efmw3L3Klv3Sx92GKFucZwQdqMHubVL0wD37ClgGTtP6mae9y7fq0v0oszGOrDN5rnIIzkwUYnlEDyfTR+YupeT1wiM1lzU33esa7ZNuCMMC+e5n4+Mr0hPTB8XVW6SMrvvnRPw8Gm000usorNFQteJY6a+vJScsrhrR8Xwtuel48bp6M4alA2vuzMZZTdhElSA/48MelJ/PeaW41f9Xtx4+rnUxrQHKjwcnbbh1YjNRqEMDFBzKYH2ZoYo1zG5pRaDexqJkN0cnmB7z3f0Ao8frqxEDNf5n0mEz8vUc4no=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /xSOpwxPZV9PJuIPoOFyJ8fRXheQsLR5uD/NzZF+2Uwgt+V5pY9w8Wt0n2UofYBuievvQhCQzHSgcTrAeQf3uxvSjL7WYphrl/9pzmOazEuij+jOdWWeQHrJOJz8OMCe1W3rLIvUgJHu1LfiLVxOcACx5m/K5PrEh5elJAJkR2X+U6v9nmjv73QXJN+pqKHryKdPCDgHmZeoMhjgRYN5w7YOlWdh0N22ezNxWopaZ/9X2Efz9pQdNvFO2rCp+ajLLvbpdKm5UD0m7XL3jQ8+hrVLSuwglZakdGlR0ZbJLGhwNTt2YS/xIczYvNebnSzzjYKQlJ8uoo9IK4ywIcivgOkKBTbL5GizdbxRdsVk27LqBlPGlrgwsiiFiOjD1C4ImGCuzyF68Kr6lurLV9sxEKqt7Lu9KEotkWVpvm/AOG2WQqQyjBnXcebHgeRsczIw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:09:50.3520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab4f0fb-27c3-452c-eecd-08deac424daf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h      |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c         | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 10 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h           |  3 +++
 6 files changed, 47 insertions(+), 3 deletions(-)

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
index 7c01492e69dd..3ac2bd86c08b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -139,6 +139,18 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 	kfd_mem_limit.system_mem_used += size;
 }
 
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
+{
+	if (adev->kfd.dev && adev->kfd.dev->inode &&
+		adev->kfd.dev->inode->i_mapping) {
+		unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
+			KFD_MMAP_TYPE_DOORBELL, kfd_doorbell_process_slice(adev->kfd.dev), 1);
+		unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
+			KFD_MMAP_TYPE_MMIO, PAGE_SIZE, 1);
+	}
+}
+
+
 /* Estimate page table size needed to represent a given memory size
  *
  * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 073f632f295a..c67936d1fb0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5019,7 +5019,6 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
-
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
 		dev_info(adev->dev, "GPU smu mode1 reset\n");
 		ret = amdgpu_dpm_mode1_reset(adev);
@@ -5840,6 +5839,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
index 84b9bde7f371..d5bf5ba73ca0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -130,11 +130,21 @@ void kfd_chardev_exit(void)
 static int kfd_open(struct inode *inode, struct file *filep)
 {
 	struct kfd_process *process;
+	struct kfd_node *node;
 	bool is_32bit_user_mode;
+	int i;
 
 	if (iminor(inode) != 0)
 		return -ENODEV;
 
+	/* Save inode in kfd_dev for unmap_mapping_range */
+	for (i = 0; kfd_topology_enum_kfd_devices(i, &node) == 0; i++) {
+		if (node && node->kfd && !node->kfd->inode) {
+			node->kfd->inode = inode;
+			break;
+		}
+	}
+
 	is_32bit_user_mode = in_compat_syscall();
 
 	if (is_32bit_user_mode) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6ff1db477f9..bfdd7d3bc7cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -373,6 +373,9 @@ struct kfd_dev {
 
 	struct workqueue_struct *ih_wq;
 
+	/* kfd inode */
+	struct inode *inode;
+
 	/* Kernel doorbells for KFD device */
 	struct amdgpu_bo *doorbells;
 
-- 
2.43.0


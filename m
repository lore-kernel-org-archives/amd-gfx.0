Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C58FE63C9B
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Jan 2026 09:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F4010E11F;
	Sun, 25 Jan 2026 09:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xRptMIZz";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1E310E11F
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 09:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbTpiTyolBm/Xk/lYXJK5SXH8GcMvwBiFN3KGtClPGknir6FsBwg1zc45r7J1ykeY38cByYu04eougLwZf8WnBaQy67ooT/AQtA6YSEgUchNxVfMKcSH/fgN9dHzZTSv5wgNteWWnKlTOetyNz/mVamhm4g4+scmDm8YHM3nYek+zpv2BJVf9UdPnIwf5c0OylQyK5N4vaKxPY2Cqb7rmsmzi4V7pQ0EAyuNShkVgpq7U17N4yJy2fm9Dc8mpLMroUoaV2vWl1UI62KnGJV6KAVx5P3nP61OteAD5ImN8bXAHmg6bQ1PKJ3U9xcL9Z94AP9c0Hg+IDL/Rz+ySQcA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2j66wU2b4rxDOeqy2uQeM4/vCEcu4hchABvPSJVUw=;
 b=vg4RhyXUDhRQIDZxTRK2WrO97eN56h90zE9LO2SWp9jhCGLVnGVZiiyBxV/WGQtgTIA2p1f0n1VXltupikBaOReQAG4AGPqIFa50ycgH2qqongK9SAT0afwYXV4nZWLKGp8w4HRtePPE5sbHfwz5xm47An2BNmv922qkI7jiDK0KIO6FV4LbzgJFDW47h3fBooQ5op3YkMYE7JH4KPXSJcHPIRult+9/scJws68xonqklpZGZVhbIVFrTDQeIrw2PubkMxiLtWbBzio8odCEsESr5+2H98iajTbsLCQP8qNQ6bIruAT9ky2Woc6PpaY3mVc4K091xb3lo166WXgoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2j66wU2b4rxDOeqy2uQeM4/vCEcu4hchABvPSJVUw=;
 b=xRptMIZz7+nBBosUGi5+78wzXAabBIt20RkVzjqO8hk6wuh1Egjx16+ZksKgkjTU3cjw+GK/f6wr8vfjg+i3+xbFSO7sKvqEgVVsPKH57zIZVn0nhnosIZ6zGvFCP7ikcgGJXKiUq+l0d0bn4HR9e/lRKW8sbppM13/ZicF43u0=
Received: from SJ0PR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:33f::33)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sun, 25 Jan
 2026 09:48:30 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a3) by SJ0PR05CA0058.outlook.office365.com
 (2603:10b6:a03:33f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.5 via Frontend Transport; Sun,
 25 Jan 2026 09:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 09:48:28 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 25 Jan
 2026 03:48:26 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <perry.yuan@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
Date: Sun, 25 Jan 2026 17:48:05 +0800
Message-ID: <20260125094805.1861877-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: d348b7c9-2454-4309-4f17-08de5bf6e45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7adIJQC7/bdt4/upojf8RMeUS3FFxSXlbYwe7/7bdRhHraDSeVW8axX8bT0E?=
 =?us-ascii?Q?qe9WrfXjFTq+hUkTBB7uTVm+l7RdikYgeTBI1t/REnvHhFlqklDaS9Esir/4?=
 =?us-ascii?Q?VPxh3FlyTC3ZksrvLJBoaxG7t17wxdabUHBza/s66HSYt5cdPQXkiOqjxu7g?=
 =?us-ascii?Q?6hzid7xz6tZsUlSvPZfm1RNPDDFYjDyA2Bigac4HYP75foixzyUpZgfdaXUS?=
 =?us-ascii?Q?Y7vCm+0P6xobsMwWIThVievjI7dvIbJNPsuugZalEeEPFMZpPFNiFkQCYNdv?=
 =?us-ascii?Q?Tuptl1MorE3JVInvbVAy822VXgGQY9YsdMZmlOVrqLmjrUtPA35SL5Byr9Tu?=
 =?us-ascii?Q?TSJHGnGm7jjYhF6Imr0Yaowmlue//QKRS48emgPsm3A5wu4sA7xuNBWIaZYg?=
 =?us-ascii?Q?Kb6dahLHwNAYXOYolvkfq6TMbZGazfcDjOtLxVlGZwWDJOJ8sk2JOnIZyXxP?=
 =?us-ascii?Q?ffIjI789XnR8MDWeJbkXWUcw2SSdThXuiv7OJJ7MGY9udI9q5UBvx+nApV88?=
 =?us-ascii?Q?nlbVxZ2JwAARtv0SP5LQve5a8jp+cNMEmuTQdtRO8YcyMHFxPUUuVzJSfENO?=
 =?us-ascii?Q?6pf2Eu6fK3qKcLqHwU5VgH+q89cNqKhtwCbSdHpmPhiqiY4uyhNaNPa67NPl?=
 =?us-ascii?Q?OoIaOgq87LbyO7sqK2JrrGocbW7nhbd2EOfyUWtuuT4wHFovlJDH4X5JcGgr?=
 =?us-ascii?Q?AOkeGa1Pojkg8IrHAll9bIpF0663lDs9eCoQjlcsxCCkTVGhl83gMAdxv1DU?=
 =?us-ascii?Q?DUsaG9EQztDWAHGDjDaV0CFay7qlmfTEo+YKTKJuMR64o7KtlN1N++H8wJP3?=
 =?us-ascii?Q?NLgtsWsiDfrFfxr/3MIwcEsPea2D6BqA9xpCZRwQrsMcYTKwcgnbOlcMOx9n?=
 =?us-ascii?Q?6MC1Xx2qmlhZtiucvr/euEKZdW+w79NwkzXG5ZannQYRf4b/dUpwFlvnpNm+?=
 =?us-ascii?Q?V5tEYFT2ypaOFYaVrpdTHFqNC5Uh8/9HqzCVF0JGFpLsXackfrBDjx3csows?=
 =?us-ascii?Q?PCPiSoz569Ojnjzz3ohgAZOls4795PjTAHUk0TpSG2J9j4OjDGCSREyqOhJ3?=
 =?us-ascii?Q?w6SAiVZLX5edS10p6D0vkHQSAlOYcmHrkGymM34Mi+xA8SBq24QMSbMzLM+4?=
 =?us-ascii?Q?i4dQjdulqjpKJ+Lt5um9EGpFRIdFnrsLHPIbznUMK+vP423LyRv+IFVIYPzX?=
 =?us-ascii?Q?SCt1Ceyy9YNndb8cTMps4CXKM9qRfy+UiBlfrbeTvm3Dc0tFAZcyYLnlVNSb?=
 =?us-ascii?Q?egTPTGgBTx0y5bTourTdpCrziqi/2oJ12RvRsLcasVZ5Q+f0w3YwRxjWv7sl?=
 =?us-ascii?Q?mJk8SDA6kKAY7Cc3VeD5LJSw+N+ylgxhEcezCKhAJCLAu59x0LmsRs+iGSsY?=
 =?us-ascii?Q?W/qRA69Osg0FViU8sFSl6kjqBgtI1wfXaVIrquVeOu+HBdNZrOj8Ym9Em4fR?=
 =?us-ascii?Q?X/eIQ5b8/ofASiOoPOd08POg1HxTIkL0qmMqSfU7z1Az8cv4uNTpEa6FcKpF?=
 =?us-ascii?Q?Z7Jdzv8Dw1Q+GieT3JydPLIpt8/gv5GO6GsbJH35ktCysAvSWttJ1jf+mi4l?=
 =?us-ascii?Q?Jz2kvZr+PqZL5TceyMVacPUMEDfQHmDrdA4a5yKvdAsYFY/xpy6iLShItY8p?=
 =?us-ascii?Q?X8DEB2WXtmyg0IeLE+KnaU8ER8a+Wi5vlmui9SnHrgIVoABI4FZGARTyucrR?=
 =?us-ascii?Q?JsLg8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 09:48:28.3608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d348b7c9-2454-4309-4f17-08de5bf6e45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
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
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c         | 17 +++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c        | 10 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h           |  3 +++
 6 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index cdbab7f8cee8..2b4108f83f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -358,6 +358,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
 
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 768998c82b43..0de0b998eba7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -139,6 +139,15 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 	kfd_mem_limit.system_mem_used += size;
 }
 
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
+{
+	if (adev->kfd.dev && adev->kfd.dev->inode &&
+		adev->kfd.dev->inode->i_mapping)
+		unmap_mapping_range(adev->kfd.dev->inode->i_mapping,
+			KFD_MMAP_TYPE_DOORBELL, kfd_doorbell_process_slice(adev->kfd.dev), 1);
+}
+
+
 /* Estimate page table size needed to represent a given memory size
  *
  * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b2deb6a74eb2..c95e45b8eca4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5721,6 +5721,12 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
+	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
+	 * accessing them
+	 */
+	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
+	amdgpu_amdkfd_clear_kfd_mapping(adev);
+
 	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
 		dev_info(adev->dev, "GPU smu mode1 reset\n");
 		ret = amdgpu_dpm_mode1_reset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5f9fa2140f09..c0b789fa92dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -44,6 +44,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_reset.h"
 
 static int
 amdgpu_gem_add_input_fence(struct drm_file *filp,
@@ -115,13 +116,21 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
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
+		return VM_FAULT_RETRY;
+
 	ret = ttm_bo_vm_reserve(bo, vmf);
-	if (ret)
+	if (ret) {
+		up_read(&adev->reset_domain->sem);
 		return ret;
+	}
 
 	if (drm_dev_enter(ddev, &idx)) {
 		ret = amdgpu_bo_fault_reserve_notify(bo);
@@ -137,11 +146,15 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
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
index 88621cb7d409..3caf8da3cd71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -127,11 +127,21 @@ void kfd_chardev_exit(void)
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
index 9849b54f54ba..bb6959e83b60 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -374,6 +374,9 @@ struct kfd_dev {
 
 	struct workqueue_struct *ih_wq;
 
+	/* kfd inode */
+	struct inode *inode;
+
 	/* Kernel doorbells for KFD device */
 	struct amdgpu_bo *doorbells;
 
-- 
2.43.0


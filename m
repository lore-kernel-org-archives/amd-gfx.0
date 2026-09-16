Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8580C88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E35610E039;
	Wed, 16 Sep 2026 10:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xH322+AJ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F130710E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 10:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTGDM/zWbPljQFZf7BiBXC+ouq0H5A/jZaEdeB6sBbT6bsEJmQX96Oilk2T3LDxaz0TXbevq5lesxxoECFKX49p+Rr1D84buu3k6DyxZkJwlw1z0DM6fDDWs7XqQqOh4UlZ+/T7K0+C2VyfqUZxLirJy9Sq7DUfbVpW4WbxAjmudXvz+YS1WsauCWmGOU0Q5Sk7P6cuaxBbzMoPExEQgkh1TKPlCdRDdT6O3XKVt+/3vLLTSKY9NQX4bwuH13HqsUGBBQbyO3zAcc6oZafwO964iqecfNMknZUpS3aYG7aFoFzy1wLEYpkvH05LDYuT+/nG4uZ188qiDN2Z55hnRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9OhSNAPbA42CiyXzUT8Wv26Xql5pmePcIp9tuTDwH4=;
 b=JdlZFEow5A7KZ0LGo5UBMPBufeGJZ57hV8QwiOqREXez03Q3/TBbN02F3Hc8BIhytvbXPz67GPYOJ6zXfTU7u8CtwSfxstbytIpk+q2Y/b1CXZmohjQMaMWBAekK4q84TIkHS7DMkShyDTuXaaY0EC1C0nJr5cmrFXbcVNNO+L4wy9YYWvII4j22ccNc93k/AUqY4TFwt/KTVLe94yU+PKkRhj7NrOZKempDtqC0MUabV6gPviMYAvE6DBoi52LDHlhdWwUsy/ecziN2/K4Ydg5zET2ihYY5Q7yCc4JGPunAmkTnmO/taYdaENQtMhZ0TykwGVBR2BBCn9ARNwsZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9OhSNAPbA42CiyXzUT8Wv26Xql5pmePcIp9tuTDwH4=;
 b=xH322+AJxlXTY87TYrCbRGvmh1mtcvRhbtenXQcY7KzIPi01KUSZl2HJ7A+txYwABgJ3utpSK5IW+kn4BSTOVkEcm3rDcA3PiKztHc6KQhhqr+aD23Ro/8n/H/jv+JZpol872C0og1tarYgLcINrWXap1s9Ha9bhg/WElSGk88w=
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:02:28 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::32) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 10:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:02:28 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 05:02:26 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: serialize GEM fault mappings with GPU reset
Date: Wed, 16 Sep 2026 18:02:04 +0800
Message-ID: <20260916100204.3750592-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 2366e8bf-141e-4263-b1d7-08df13d99dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 9A1X+3bCzZO4/tB6coFyPw3pk5fHbpFITE62+I4iEKkYYMF9raod/CeeyCbq47hSh32O1bST+vJ2tTI/lTuZsG3U3zwaD73dw69zBevr/V/f7Z4ADGFj03xiVOsp9SPYVtMmoxy1EkFX2qkLpj2wKvfRXHwAwYTse/1wCAZ++DLlOVWK3bAHfeXId8PJobYkC6GeuEJUhhqBE7xtRLkN9ySXoztWevEbE8QVqvtagvAjkuN8v5w6gZX5eJ5/cbnqYuHkbFEUgO3KPCYfvBUW1VJ9h8nJqiv+KtcoNmn7QwXS2tA8X3JNkAQv8cEmKSwTZn6VB+1OjFLpz8A9YvraZeNob/WrgeRyhS6YWyOfAtBlj4oZdqJRqxdH/J2DxkU0JLy9EVtcPiL5/zf6NwN3qBaqIPL+DVFH/Fd8lz4Ng6pPnD4hEN73VGh/qp5+hO1DXaunKQlKY4OVlfEvcBy9sCKEE7z+DJeQXjRbZ7xjz/Tviy040DKfEkFJkdYD/XcIleQYcbdNXwKnpJpDLs7YN3IDS3bIByXKz68hlvpZ0v3rgvpvev8ny81QFLyhQmkWvl+35CxsqbuiXVQtu2QOTXu6p2R5lOCnO0Ha1cPo1yfsZkO8Sxxo89plRsP2ThV3Ly2PPfHHqBYIjAxy62oCL+bjv5Tf9Fm4+/I5CFDzGxUgbjATbJ5dCMNC6nY2JDMrEIfTA3+UtG8Bcdthcw3OAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zHVf7qu2VbHpxIAWtlHxcS56e/H3JHerb+MvyjcRN1t5/dEk2EjM20o9c3I214MY30yny/qoqJlAjKKCyyxOjSYYNdBReSOGBxv97Cd1gLFHvLHD22NMYMBlafnfmzmjAuQyGSjjEJWl4J2zfjdNgrIDUdIsDTe/aSWdYOtGDyAfn51SeIx12VYCSL5/AL+Ro+AsHEzxBeWIeq9UFQ8OMlK+xY4JMBfN0TLAKFTCJH89lvN2pH001I/y5yvCKezkyDQWDuX+88dBmB2yrNP0x37D+ngOCHMI4cCKkp/8gFsyIUiQ4mB3WZBaoOFmMjCvCPu3TmkRnfvTQWy5J42orR2f21N7gYGx/49OzSMVhjmPNlcynhQUUdBYlyXYC9mUYlWH8xTXOMJEYRGl/U+zEopaLf3DZdIBAbSaAK+OIc1cOOJZKb+HFZ5yonQbBxLQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:02:28.5465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2366e8bf-141e-4263-b1d7-08df13d99dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

GPU recovery invalidates CPU mappings before resetting the device. A
concurrent GEM fault can install a new mapping after invalidation and
allow userspace to access the framebuffer BAR while the device is being
reset. Serialize PFN insertion with the reset-domain write semaphore to
close this race.

Holding the read semaphore across the entire fault is unsafe: migration
fence waits may depend on recovery, and page-table allocation inside
vmf_insert_pfn_prot() can enter reclaim and wait for GPU fences through
MMU notifier callbacks. Recovery cannot complete those fences while it
is blocked acquiring the write semaphore.

Add an optional mapping semaphore to the TTM reserved fault helper.
Prepare page tables with apply_to_page_range() before taking the read
semaphore, then insert the PFN through vmf_insert_pfn_prot(). Restrict
this path to non-COW PFNMAP VMAs with mmap_lock held, relying on mapping
invalidation clearing PTEs without freeing the prepared page tables.
Keep the existing MM PFN permission and cache-mode checks, and leave
fence waits, BO population and page-table allocation outside reset
exclusion.

On semaphore contention, retry the fault when allowed. Drop the BO
reservation and mmap_lock before waiting, and retain an extra GEM
reference to protect the object and semaphore lifetime. RETRY_NOWAIT
keeps both locks held; faults that cannot retry return SIGBUS. Keep the
existing TTM helper as an unlocked wrapper so other callers retain their
original behavior, and opt AMDGPU GEM faults into the new helper.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |   6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c         | 104 +++++++++++++++++++++++-
 include/drm/ttm/ttm_bo.h                |   3 +
 3 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0d579517c03c..2937f6cda62a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -119,6 +119,7 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct drm_device *ddev = bo->base.dev;
 	vm_fault_t ret;
 	int idx;
@@ -134,8 +135,9 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
 			goto unlock;
 		}
 
-		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
-					       TTM_BO_VM_NUM_PREFAULT);
+		ret = ttm_bo_vm_fault_reserved_lock(vmf, vmf->vma->vm_page_prot,
+						    TTM_BO_VM_NUM_PREFAULT,
+						    &adev->reset_domain->sem);
 
 		drm_dev_exit(idx);
 	} else {
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index a80510489c45..e9ac14c471ab 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -162,6 +162,70 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_vm_reserve);
 
+static vm_fault_t ttm_bo_vm_mapping_retry(struct ttm_buffer_object *bo,
+					  struct vm_fault *vmf,
+					  struct rw_semaphore *mapping_lock)
+{
+	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
+		return VM_FAULT_SIGBUS;
+
+	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+		return VM_FAULT_RETRY;
+
+	drm_gem_object_get(&bo->base);
+	dma_resv_unlock(bo->base.resv);
+	mmap_read_unlock(vmf->vma->vm_mm);
+	if (!down_read_killable(mapping_lock))
+		up_read(mapping_lock);
+	drm_gem_object_put(&bo->base);
+
+	return VM_FAULT_RETRY;
+}
+
+/**
+ * ttm_bo_vm_insert_pfn - prepare page tables before taking mapping exclusion
+ * @vma: non-COW PFNMAP VMA, protected by mmap_lock
+ * @address: page-aligned address within @vma
+ * @pfn: backing page frame
+ * @prot: protection for this page
+ * @mapping_lock: semaphore held for writing while invalidating mappings
+ *
+ * The empty page tables must survive until insertion: mmap_lock excludes
+ * munmap/mremap, PFNMAP excludes MADV_DONTNEED and THP collapse, and mapping
+ * invalidation clears PTEs without freeing page tables. Thus the subsequent
+ * vmf_insert_pfn_prot() does not allocate page tables under @mapping_lock,
+ * while retaining the MM's PFN permission and cache-mode checks.
+ *
+ * Return: VM_FAULT_RETRY on contention, with all caller-owned locks retained;
+ * otherwise the insertion result or an allocation/validation error.
+ */
+static vm_fault_t ttm_bo_vm_insert_pfn(struct vm_area_struct *vma,
+				       unsigned long address, unsigned long pfn,
+				       pgprot_t prot,
+				       struct rw_semaphore *mapping_lock)
+{
+	vm_fault_t ret;
+	int err;
+
+	mmap_assert_locked(vma->vm_mm);
+	if ((vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)) != VM_PFNMAP ||
+	    is_cow_mapping(vma->vm_flags))
+		return VM_FAULT_SIGBUS;
+	if (address < vma->vm_start || address >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	err = apply_to_page_range(vma->vm_mm, address, PAGE_SIZE, NULL, NULL);
+	if (err)
+		return err == -ENOMEM ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+
+	if (!down_read_trylock(mapping_lock))
+		return VM_FAULT_RETRY;
+	ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+	up_read(mapping_lock);
+
+	return ret;
+}
+
 /**
  * ttm_bo_vm_fault_reserved - TTM fault helper
  * @vmf: The struct vm_fault given as argument to the fault callback
@@ -183,6 +247,33 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
 vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgprot_t prot,
 				    pgoff_t num_prefault)
+{
+	return ttm_bo_vm_fault_reserved_lock(vmf, prot, num_prefault, NULL);
+}
+EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
+
+/**
+ * ttm_bo_vm_fault_reserved_lock - fault a BO with optional mapping exclusion
+ * @vmf: fault information, with mmap_lock held
+ * @prot: page protection
+ * @num_prefault: maximum number of pages to prefault
+ * @mapping_lock: optional semaphore held for writing during invalidation
+ *
+ * The BO must be reserved. The caller must not hold @mapping_lock. Its lifetime
+ * must be protected by the BO's reference to the DRM device. When supplied,
+ * only non-COW PFNMAP mappings are supported. Fence waits, BO population and
+ * page-table allocation run without the semaphore.
+ *
+ * On contention, ALLOW_RETRY drops the BO reservation and mmap_lock before
+ * waiting, except RETRY_NOWAIT which retains both locks. Without ALLOW_RETRY,
+ * contention returns SIGBUS with both locks held rather than blocking reset.
+ *
+ * Return: Fault result. VM_FAULT_RETRY without RETRY_NOWAIT means both locks
+ * have been dropped; otherwise both locks remain held.
+ */
+vm_fault_t ttm_bo_vm_fault_reserved_lock(struct vm_fault *vmf, pgprot_t prot,
+					 pgoff_t num_prefault,
+					 struct rw_semaphore *mapping_lock)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
@@ -263,7 +354,16 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		 * at arbitrary times while the data is mmap'ed.
 		 * See vmf_insert_pfn_prot() for a discussion.
 		 */
-		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		if (mapping_lock) {
+			ret = ttm_bo_vm_insert_pfn(vma, address, pfn, prot,
+						   mapping_lock);
+			if (ret == VM_FAULT_RETRY)
+				return ttm_bo_vm_mapping_retry(bo, vmf, mapping_lock);
+			if (ret & VM_FAULT_ERROR)
+				return i ? VM_FAULT_NOPAGE : ret;
+		} else {
+			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
+		}
 
 		/* Never error on prefaulted PTEs */
 		if (unlikely((ret & VM_FAULT_ERROR))) {
@@ -279,7 +379,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	}
 	return ret;
 }
-EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
+EXPORT_SYMBOL_GPL(ttm_bo_vm_fault_reserved_lock);
 
 static void ttm_bo_release_dummy_page(struct drm_device *dev, void *res)
 {
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f9..06138c1688f6 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -438,6 +438,9 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgprot_t prot,
 				    pgoff_t num_prefault);
+vm_fault_t ttm_bo_vm_fault_reserved_lock(struct vm_fault *vmf, pgprot_t prot,
+					 pgoff_t num_prefault,
+					 struct rw_semaphore *mapping_lock);
 vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
 void ttm_bo_vm_open(struct vm_area_struct *vma);
 void ttm_bo_vm_close(struct vm_area_struct *vma);
-- 
2.43.0


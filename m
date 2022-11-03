Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6FCC43217
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 02:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E905310E219;
	Thu,  3 Nov 2022 02:01:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8371910E219
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 02:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvF4zDzw+xqJH0EXl2UU/NvwWySzr9kGQtq2CRPsFFTBnFNXOVYdnJZSuJqjVjGv65JYqpj88CX665e0lWAi/SEFYo66Z5ifbcXj3gRvUuTflrEm04rebI6JXMUr7/+md1BBqTKJbMSesDxtuE/TauetKVb0bBL4Frr9p8XOhMKfsRNikgJnKx2G0g/5rW4SNAdSa0J1PzjGgM2vETAcMPwcWXR3OrEckbBztX54s9GLowrz1RcAVdAaxG+Gi72jK6ls4dl68TrwHowRG9NwuqK1sc0w7t2Eos+7nVHPDuRRwsLAiRDd+FZlrMDETqH5RhIoG//IJv5Qy4mTdNyp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk1k91JNCEkRy6UZo50tUJgPULx219015qdp95bMc90=;
 b=IXurk990PqLzKACgb/E1RKpMDzjS/uQkvjzxw4nUfoneUI21Xf4qnngm+rJUlNv8VDX/rRoDnWv8Tn9THwktyxqJj9S9jeV6qJzA2A2DGOcIFxghHueryqzbiUVKgtiwW0OGkSm8RCuviQmR/W0FgsYdN4B8Hay42e6lsE/x1mwo+WsFx0d+xTVYPJW0kSzwmT/DPNCKDSbHQki3bSdvoOQdzhcB97/17nvBaWSK3zJtaS2VSd9RO6SQL+edpc06hm1ItCwQcgYDEhCkZu71rflTezDijWtlQfahRMWEWTGvN4qf8tJoS8VFocCLIKVTmRuAKXm4MW1SnkhSYj3oOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk1k91JNCEkRy6UZo50tUJgPULx219015qdp95bMc90=;
 b=ngGuKAvk5jkPceQRxENe7chQpu/s87Hi8U0imnT+hWUEboc/+m0y0kKJ5sX0LU1zBFsQw87R7/UXhCCi7kKR+/MPo8bQzYzQaa4pRgYB+lykxIc6k8LglcfJrWlnv6RLvid0flAkGsKlA6nFBSIKDQkpzyZc+IzUmkqVCZicKq8=
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 02:01:22 +0000
Received: from DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::39) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 02:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT073.mail.protection.outlook.com (10.13.173.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 02:01:21 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 21:00:48 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs
Date: Wed, 2 Nov 2022 22:00:28 -0400
Message-ID: <20221103020028.832664-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT073:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: a9008c87-1e73-4ab7-e5e0-08dabd3f4e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XihVaffaZogPp7aLRjxEDKD7j0iPUzAbVssCaeUBvm2xCAhCDQmnGzuV8TZfQQKeXPcDOFsqFhzQ0NCzjp6yWVFnr3M4pI0ObUO+2ri1uj0qlWni1TzqtmUS+KUm5QNbFq7RQP2mqcoCW+6I7jG/vI4iMrM5AJ41iX2IdZyZMp982dO8oEuXyb/hSDnsCSicHcarnFOMELjssPS/+1vWakAOjy386/5rPV3pFkFqL8jtLD81Fi4P7zl6Ghic9X5JaKAvYxKNGg4zzNC9khsTHVtifxPjlm7DSvYdfcaYlactdq6PljE/Rohb9LyW8t9/TigqWpSPkNqZEmaCNY5bETh2Tz1alhFozWVIbkOWB8deo6QG5GJqYaGMwXL0zVHf3/WaDBek32J4u9RbnYq4Qk/GpV6qbZHwDQYVU2fbPmG6Uz0hMDHEjH+bbRF+eODzsu2otBLxeG7aFl72fqItL9i93P2egid7D0d4079tjTFPryRa9/FMf59MtAkXa50Pc+WUTRiPcFYcR0bNmUQW0LwZX9eel6B5Nxtl7qjuemq1RpQQklv29RugvAHL0ObqSGH/dKwuvvFRxxS0Jci0Y1rGHbL/NokHVmORv0rUh4u8AkQtqpTisbqmHkBaJmbdd468xc5EXore+PVnKizbK5TrXN8CE+s63hNbOUNSrdbXOwbJ9+NuRTgR9Ddm+N4ABcYYdMMgzNbWeKEDTbUlo9oYZahw6U6N67VWdwpuXkQ3Xppyhe4+UuPizKpFbnFqStTBVflz6mc2DXV7b4f1nvTeEXgORmHjrPWGzypmjMWuyk0ctx2p5EGvoNPymkZiI7rUSZmd2k5PTvopH1AOKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(70586007)(47076005)(6916009)(70206006)(2906002)(40460700003)(316002)(336012)(36860700001)(82740400003)(36756003)(6666004)(83380400001)(1076003)(81166007)(16526019)(86362001)(426003)(2616005)(8936002)(186003)(41300700001)(7696005)(26005)(8676002)(356005)(5660300002)(30864003)(478600001)(82310400005)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 02:01:21.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9008c87-1e73-4ab7-e5e0-08dabd3f4e4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

Add a per-process MMU notifier lock for processing notifiers from
userptrs. Use that lock to properly synchronize page table updates with
MMU notifiers.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  12 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 202 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c        |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   4 +
 6 files changed, 158 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f50e3ba4d7a5..1ca18a77818b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -29,6 +29,7 @@
 #include <linux/mm.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
+#include <linux/mmu_notifier.h>
 #include <kgd_kfd_interface.h>
 #include <drm/ttm/ttm_execbuf_util.h>
 #include "amdgpu_sync.h"
@@ -75,7 +76,7 @@ struct kgd_mem {
 
 	uint32_t alloc_flags;
 
-	atomic_t invalid;
+	uint32_t invalid;
 	struct amdkfd_process_info *process_info;
 
 	struct amdgpu_sync sync;
@@ -131,7 +132,8 @@ struct amdkfd_process_info {
 	struct amdgpu_amdkfd_fence *eviction_fence;
 
 	/* MMU-notifier related fields */
-	atomic_t evicted_bos;
+	struct mutex notifier_lock;
+	uint32_t evicted_bos;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
 	bool block_mmu_notifications;
@@ -180,7 +182,8 @@ int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
 int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+				unsigned long cur_seq, struct kgd_mem *mem);
 #else
 static inline
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
@@ -201,7 +204,8 @@ int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
 }
 
 static inline
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+				unsigned long cur_seq, struct kgd_mem *mem)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 955fa8c8213b..5510b7c42ac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -964,7 +964,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		 * later stage when it is scheduled by another ioctl called by
 		 * CRIU master process for the target pid for restore.
 		 */
-		atomic_inc(&mem->invalid);
+		mutex_lock(&process_info->notifier_lock);
+		mem->invalid++;
+		mutex_unlock(&process_info->notifier_lock);
 		mutex_unlock(&process_info->lock);
 		return 0;
 	}
@@ -1301,6 +1303,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 			return -ENOMEM;
 
 		mutex_init(&info->lock);
+		mutex_init(&info->notifier_lock);
 		INIT_LIST_HEAD(&info->vm_list_head);
 		INIT_LIST_HEAD(&info->kfd_bo_list);
 		INIT_LIST_HEAD(&info->userptr_valid_list);
@@ -1317,7 +1320,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		}
 
 		info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
-		atomic_set(&info->evicted_bos, 0);
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
@@ -1372,6 +1374,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 		put_pid(info->pid);
 create_evict_fence_fail:
 		mutex_destroy(&info->lock);
+		mutex_destroy(&info->notifier_lock);
 		kfree(info);
 	}
 	return ret;
@@ -1496,6 +1499,7 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 		cancel_delayed_work_sync(&process_info->restore_userptr_work);
 		put_pid(process_info->pid);
 		mutex_destroy(&process_info->lock);
+		mutex_destroy(&process_info->notifier_lock);
 		kfree(process_info);
 	}
 }
@@ -1548,7 +1552,9 @@ int amdgpu_amdkfd_criu_resume(void *p)
 
 	mutex_lock(&pinfo->lock);
 	pr_debug("scheduling work\n");
-	atomic_inc(&pinfo->evicted_bos);
+	mutex_lock(&pinfo->notifier_lock);
+	pinfo->evicted_bos++;
+	mutex_unlock(&pinfo->notifier_lock);
 	if (!READ_ONCE(pinfo->block_mmu_notifications)) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1773,8 +1779,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	list_del(&bo_list_entry->head);
 	mutex_unlock(&process_info->lock);
 
-	/* No more MMU notifiers */
-	amdgpu_mn_unregister(mem->bo);
+	/* Cleanup user pages and MMU notifiers */
+	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
+		amdgpu_mn_unregister(mem->bo);
+		mutex_lock(&process_info->notifier_lock);
+		amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm);
+		mutex_unlock(&process_info->notifier_lock);
+	}
 
 	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
 	if (unlikely(ret))
@@ -1864,14 +1875,14 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	 */
 	mutex_lock(&mem->process_info->lock);
 
-	/* Lock mmap-sem. If we find an invalid userptr BO, we can be
+	/* Lock notifier lock. If we find an invalid userptr BO, we can be
 	 * sure that the MMU notifier is no longer running
 	 * concurrently and the queues are actually stopped
 	 */
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-		mmap_write_lock(current->mm);
-		is_invalid_userptr = atomic_read(&mem->invalid);
-		mmap_write_unlock(current->mm);
+		mutex_lock(&mem->process_info->notifier_lock);
+		is_invalid_userptr = !!mem->invalid;
+		mutex_unlock(&mem->process_info->notifier_lock);
 	}
 
 	mutex_lock(&mem->lock);
@@ -2251,34 +2262,38 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
  *
  * Runs in MMU notifier, may be in RECLAIM_FS context. This means it
  * cannot do any memory allocations, and cannot take any locks that
- * are held elsewhere while allocating memory. Therefore this is as
- * simple as possible, using atomic counters.
+ * are held elsewhere while allocating memory.
  *
  * It doesn't do anything to the BO itself. The real work happens in
  * restore, where we get updated page addresses. This function only
  * ensures that GPU access to the BO is stopped.
  */
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem,
-				struct mm_struct *mm)
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+				unsigned long cur_seq, struct kgd_mem *mem)
 {
 	struct amdkfd_process_info *process_info = mem->process_info;
-	int evicted_bos;
 	int r = 0;
 
-	/* Do not process MMU notifications until stage-4 IOCTL is received */
+	/* Do not process MMU notifications during CRIU restore until
+	 * KFD_CRIU_OP_RESUME IOCTL is received
+	 */
 	if (READ_ONCE(process_info->block_mmu_notifications))
 		return 0;
 
-	atomic_inc(&mem->invalid);
-	evicted_bos = atomic_inc_return(&process_info->evicted_bos);
-	if (evicted_bos == 1) {
+	mutex_lock(&process_info->notifier_lock);
+	mmu_interval_set_seq(mni, cur_seq);
+
+	mem->invalid++;
+	if (++process_info->evicted_bos == 1) {
 		/* First eviction, stop the queues */
-		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
+		r = kgd2kfd_quiesce_mm(mni->mm,
+				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
 		schedule_delayed_work(&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 	}
+	mutex_unlock(&process_info->notifier_lock);
 
 	return r;
 }
@@ -2295,49 +2310,54 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 	struct kgd_mem *mem, *tmp_mem;
 	struct amdgpu_bo *bo;
 	struct ttm_operation_ctx ctx = { false, false };
-	int invalid, ret;
+	uint32_t invalid;
+	int ret = 0;
 
-	/* Move all invalidated BOs to the userptr_inval_list and
-	 * release their user pages by migration to the CPU domain
-	 */
+	mutex_lock(&process_info->notifier_lock);
+
+	/* Move all invalidated BOs to the userptr_inval_list */
 	list_for_each_entry_safe(mem, tmp_mem,
 				 &process_info->userptr_valid_list,
-				 validate_list.head) {
-		if (!atomic_read(&mem->invalid))
-			continue; /* BO is still valid */
-
-		bo = mem->bo;
-
-		if (amdgpu_bo_reserve(bo, true))
-			return -EAGAIN;
-		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		amdgpu_bo_unreserve(bo);
-		if (ret) {
-			pr_err("%s: Failed to invalidate userptr BO\n",
-			       __func__);
-			return -EAGAIN;
-		}
-
-		list_move_tail(&mem->validate_list.head,
-			       &process_info->userptr_inval_list);
-	}
-
-	if (list_empty(&process_info->userptr_inval_list))
-		return 0; /* All evicted userptr BOs were freed */
+				 validate_list.head)
+		if (mem->invalid)
+			list_move_tail(&mem->validate_list.head,
+				       &process_info->userptr_inval_list);
 
 	/* Go through userptr_inval_list and update any invalid user_pages */
 	list_for_each_entry(mem, &process_info->userptr_inval_list,
 			    validate_list.head) {
-		invalid = atomic_read(&mem->invalid);
+		invalid = mem->invalid;
 		if (!invalid)
 			/* BO hasn't been invalidated since the last
-			 * revalidation attempt. Keep its BO list.
+			 * revalidation attempt. Keep its page list.
 			 */
 			continue;
 
 		bo = mem->bo;
 
+		amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm);
+
+		/* BO reservations and getting user pages (hmm_range_fault)
+		 * must happen outside the notifier lock
+		 */
+		mutex_unlock(&process_info->notifier_lock);
+
+		/* Move the BO to system (CPU) domain if necessary to unmap
+		 * and free the SG table
+		 */
+		if (bo->tbo.resource->mem_type != TTM_PL_SYSTEM) {
+			if (amdgpu_bo_reserve(bo, true))
+				return -EAGAIN;
+			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+			amdgpu_bo_unreserve(bo);
+			if (ret) {
+				pr_err("%s: Failed to invalidate userptr BO\n",
+				       __func__);
+				return -EAGAIN;
+			}
+		}
+
 		/* Get updated user pages */
 		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
 		if (ret) {
@@ -2352,30 +2372,31 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			 */
 			if (ret != -EFAULT)
 				return ret;
-		} else {
-
-			/*
-			 * FIXME: Cannot ignore the return code, must hold
-			 * notifier_lock
-			 */
-			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
+			ret = 0;
 		}
 
+		mutex_lock(&process_info->notifier_lock);
+
 		/* Mark the BO as valid unless it was invalidated
 		 * again concurrently.
 		 */
-		if (atomic_cmpxchg(&mem->invalid, invalid, 0) != invalid)
-			return -EAGAIN;
+		if (mem->invalid != invalid) {
+			ret = -EAGAIN;
+			goto unlock_out;
+		}
+		mem->invalid = 0;
 	}
 
-	return 0;
+unlock_out:
+	mutex_unlock(&process_info->notifier_lock);
+
+	return ret;
 }
 
 /* Validate invalid userptr BOs
  *
- * Validates BOs on the userptr_inval_list, and moves them back to the
- * userptr_valid_list. Also updates GPUVM page tables with new page
- * addresses and waits for the page table updates to complete.
+ * Validates BOs on the userptr_inval_list. Also updates GPUVM page tables
+ * with new page addresses and waits for the page table updates to complete.
  */
 static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 {
@@ -2446,9 +2467,6 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 			}
 		}
 
-		list_move_tail(&mem->validate_list.head,
-			       &process_info->userptr_valid_list);
-
 		/* Update mapping. If the BO was not validated
 		 * (because we couldn't get user pages), this will
 		 * clear the page table entries, which will result in
@@ -2464,7 +2482,9 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 			if (ret) {
 				pr_err("%s: update PTE failed\n", __func__);
 				/* make sure this gets validated again */
-				atomic_inc(&mem->invalid);
+				mutex_lock(&process_info->notifier_lock);
+				mem->invalid++;
+				mutex_unlock(&process_info->notifier_lock);
 				goto unreserve_out;
 			}
 		}
@@ -2484,6 +2504,32 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 	return ret;
 }
 
+/* Confirm that all user pages are valid while holding the notifier lock
+ *
+ * Moves valid BOs from the userptr_inval_list back to userptr_val_list.
+ */
+static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_info)
+{
+	struct kgd_mem *mem, *tmp_mem;
+	int ret = 0;
+
+	list_for_each_entry_safe(mem, tmp_mem,
+				 &process_info->userptr_inval_list,
+				 validate_list.head) {
+		if (!amdgpu_ttm_tt_get_user_pages_done(mem->bo->tbo.ttm)) {
+			WARN(!mem->invalid, "Invalid BO not marked invalid");
+			ret = -EAGAIN;
+			continue;
+		}
+		WARN(mem->invalid, "Valid BO is marked invalid");
+
+		list_move_tail(&mem->validate_list.head,
+			       &process_info->userptr_valid_list);
+	}
+
+	return ret;
+}
+
 /* Worker callback to restore evicted userptr BOs
  *
  * Tries to update and validate all userptr BOs. If successful and no
@@ -2498,9 +2544,11 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 			     restore_userptr_work);
 	struct task_struct *usertask;
 	struct mm_struct *mm;
-	int evicted_bos;
+	uint32_t evicted_bos;
 
-	evicted_bos = atomic_read(&process_info->evicted_bos);
+	mutex_lock(&process_info->notifier_lock);
+	evicted_bos = process_info->evicted_bos;
+	mutex_unlock(&process_info->notifier_lock);
 	if (!evicted_bos)
 		return;
 
@@ -2523,9 +2571,6 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * and we can just restart the queues.
 	 */
 	if (!list_empty(&process_info->userptr_inval_list)) {
-		if (atomic_read(&process_info->evicted_bos) != evicted_bos)
-			goto unlock_out; /* Concurrent eviction, try again */
-
 		if (validate_invalid_user_pages(process_info))
 			goto unlock_out;
 	}
@@ -2534,10 +2579,17 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * be a first eviction that calls quiesce_mm. The eviction
 	 * reference counting inside KFD will handle this case.
 	 */
-	if (atomic_cmpxchg(&process_info->evicted_bos, evicted_bos, 0) !=
-	    evicted_bos)
-		goto unlock_out;
-	evicted_bos = 0;
+	mutex_lock(&process_info->notifier_lock);
+	if (process_info->evicted_bos != evicted_bos)
+		goto unlock_notifier_out;
+
+	if (confirm_valid_user_pages_locked(process_info)) {
+		WARN(1, "User pages unexpectedly invalid");
+		goto unlock_notifier_out;
+	}
+
+	process_info->evicted_bos = evicted_bos = 0;
+
 	if (kgd2kfd_resume_mm(mm)) {
 		pr_err("%s: Failed to resume KFD\n", __func__);
 		/* No recovery from this failure. Probably the CP is
@@ -2545,6 +2597,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 		 */
 	}
 
+unlock_notifier_out:
+	mutex_unlock(&process_info->notifier_lock);
 unlock_out:
 	mutex_unlock(&process_info->lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index b86c0b8252a5..93b6a2a7d64c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -102,17 +102,11 @@ static bool amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,
 				     unsigned long cur_seq)
 {
 	struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
 	if (!mmu_notifier_range_blockable(range))
 		return false;
 
-	mutex_lock(&adev->notifier_lock);
-
-	mmu_interval_set_seq(mni, cur_seq);
-
-	amdgpu_amdkfd_evict_userptr(bo->kfd_bo, bo->notifier.mm);
-	mutex_unlock(&adev->notifier_lock);
+	amdgpu_amdkfd_evict_userptr(mni, cur_seq, bo->kfd_bo);
 
 	return true;
 }
@@ -231,9 +225,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	return r;
 }
 
-int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
+bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
 {
-	int r;
+	bool r;
 
 	r = mmu_interval_read_retry(hmm_range->notifier,
 				    hmm_range->notifier_seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
index 14a3c1864085..b37fcf99baf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
@@ -29,13 +29,14 @@
 #include <linux/rwsem.h>
 #include <linux/workqueue.h>
 #include <linux/interval_tree.h>
+#include <linux/mmu_notifier.h>
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct mm_struct *mm, struct page **pages,
 			       uint64_t start, uint64_t npages,
 			       struct hmm_range **phmm_range, bool readonly,
 			       bool mmap_locked, void *owner);
-int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
+bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 585460ab8dfd..5f2b87dd5732 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -706,8 +706,20 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	return r;
 }
 
+/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array allocations
+ */
+void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm)
+{
+	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+
+	if (gtt && gtt->userptr && gtt->range) {
+		amdgpu_hmm_range_get_pages_done(gtt->range);
+		gtt->range = NULL;
+	}
+}
+
 /*
- * amdgpu_ttm_tt_userptr_range_done - stop HMM track the CPU page table change
+ * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page table change
  * Check if the pages backing this ttm range have been invalidated
  *
  * Returns: true if pages are still valid
@@ -727,10 +739,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 		"No user pages to check\n");
 
 	if (gtt->range) {
-		/*
-		 * FIXME: Must always hold notifier_lock for this, and must
-		 * not ignore the return code.
-		 */
 		r = amdgpu_hmm_range_get_pages_done(gtt->range);
 		gtt->range = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 9120ae80ef52..58b70d862437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -158,6 +158,7 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
+void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm);
 bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);
 #else
 static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
@@ -165,6 +166,9 @@ static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 {
 	return -EPERM;
 }
+static void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm)
+{
+}
 static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 {
 	return false;
-- 
2.32.0


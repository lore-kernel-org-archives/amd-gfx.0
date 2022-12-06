Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC128C4708C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Dec 2022 00:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C15310E2D8;
	Tue,  6 Dec 2022 00:54:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DFF10E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Dec 2022 00:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcRvWX3JroT94NTmQNj7d1QxSPRSFtWSUmP8qnxwBcgrDFq88tu0KwCLbRd2a0bQDaoltLMPic+fMYxN4AUjCibRMm5L5NRju0/EDXV3gtvTua4/WiKzrK01m0Bwzm6ZZJufWYlIAtS35ON/0IqvHhei1c8CAtHwlW36Kop9El8GMyjGcHXqL9LHMYSS1eYM7AeKrHzuH5U0tjHmbnOyNlMwhuS8FNRY0IV36Sc713II85h9W6CDlPztLmTdXA0AqB+33HGw1bpoQG+U32fGDEoFuyo57yjk7YCUNg89HTOakLlReyhZtPZZrVfUvZKVOsWFJI8Jqp0Zkm2pZSnQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu/yN03zczDdR0aBO2NajrHt7GAylYF3mTPCBTmBCgc=;
 b=V6JIw41RwmqGyqi/BusWIsGKBes02KLDcyI0WgwQ1uUvI+y1lBUy4FQ5urpiYSobrZOPjFM77igLb4JeWsCld4UhkptExcCsL67mxDd7ot+oRuWTHF7FUDlNQo40Pz8WLn7CG9vP6cDi2+xY7ulvjAAO65Zha9OA8uLxFuUX8QUb8egF72MBNqA939cdj3HFtZjYo6qz2Y6tKkY/TubBWPqXXx6ZF+tsdgevQlHqUpNbXTRAcdAKwUVXQsxvnbAClRbykoILjJAk81lCE50CtR+nYz7HcdXYjP2XxlCCVfJRHv0v7EhK6bk6uWsV0pIxb1dvQxLCU5lYlTYuviLhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu/yN03zczDdR0aBO2NajrHt7GAylYF3mTPCBTmBCgc=;
 b=RqePsTAg54AD9XNO1Y3c7SiA4p0OkmBpHmuS9TiQ9QJDYKDoHdzoRCF0yRDHVchgNayjXnmr1SUbuVwHEoVNd5aZcSqCvDo3z7XU2PWFcr7Z8WyGhw57SrxQtclZZqNpeon2J/bal2LrFUC1gMoqHTRgFEDIZwDesiM0aQiveiQ=
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 00:54:47 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::1) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 00:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Tue, 6 Dec 2022 00:54:47 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 18:54:47 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add notifier lock for KFD userptrs
Date: Mon, 5 Dec 2022 19:54:24 -0500
Message-ID: <20221206005424.2121968-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcffc18-f643-4a21-ff46-08dad7247918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t7UH1rVSlwuaVSmMHRfzoTe/kvbTF1UO6S7+6MKmknfteebZ0zSpCPY5SIgc2tWxkRCf13nSLXPSwfydVUF78ZIGTULrCk36g1iZmFzwRaKC0+xKomu5wCK9iamVhjhx9i7TmdS60FDAo5U+NBTqAg/AAjuY8T9q0dvRtoaW+rMQRD9tKqMOnIdw9hz3vDYNDCvKqDGYkWSAEDhWS0eZw/yvUpW9xK/FKdiIU6tl7BnQbtmaPllPu9qakVJQ51OZ5OSt9s1h+uwlw1cOhS/ox0kj2CT0U/YlgTLxOmTKUqgsKraXaii43VCq42t0CwJQsjb9oOrjf6p9wYAYN6sT8GoiUb8nnr6S+N+Por4dgkf07kjF545kcuBahIV6P8x/2/wl79AW41fXManCWbhydIj57ESPbq+iyH7Ueslyjyz7xAyz+JLLz5wFAWr9/PYErV2sb68uaq0avyvShsrnzrrHChelNGSnnB83V5pgWDPBlL274Dq6ZKn09dmsXzRNeybxvCVyCtrWM5Q8zLcussxBWvUnOLkMZ+n2tQxD68+eiGiHfR4otbocMaKMUXhI3oWKB1VrRbL8amHjzLoEEmPd3ZgUYXftuqJHo6wiCzSCmUrgZnbPqmG139qIs+j5dwpdZ5MAMp3++mDoyEE0LetpWh/gNxs48kMOdm1W1INPV6FrL/sIUvKg2ljIwoZxnG38bDMahyBeO3plYC/P0WeUZdwKuBAMPePYqpnYBFdkBGCiiV5eKRbP/kYR2uHUMvTZJN1wi8HHDP9cbKYNsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(82740400003)(5660300002)(86362001)(81166007)(356005)(8936002)(2906002)(40460700003)(41300700001)(4326008)(30864003)(36860700001)(83380400001)(70586007)(478600001)(70206006)(316002)(2616005)(6916009)(40480700001)(8676002)(82310400005)(336012)(47076005)(1076003)(6666004)(16526019)(186003)(7696005)(26005)(426003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 00:54:47.6353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcffc18-f643-4a21-ff46-08dad7247918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a per-process MMU notifier lock for processing notifiers from
userptrs. Use that lock to properly synchronize page table updates with
MMU notifiers.

v2: rebased

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Xiaogang Chen<Xiaogang.Chen@amd.com> (v1)
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  13 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 212 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   6 +
 6 files changed, 172 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f50e3ba4d7a5..589939631ed4 100644
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
@@ -65,6 +66,7 @@ struct kgd_mem {
 	struct mutex lock;
 	struct amdgpu_bo *bo;
 	struct dma_buf *dmabuf;
+	struct hmm_range *range;
 	struct list_head attachments;
 	/* protected by amdkfd_process_info.lock */
 	struct ttm_validate_buffer validate_list;
@@ -75,7 +77,7 @@ struct kgd_mem {
 
 	uint32_t alloc_flags;
 
-	atomic_t invalid;
+	uint32_t invalid;
 	struct amdkfd_process_info *process_info;
 
 	struct amdgpu_sync sync;
@@ -131,7 +133,8 @@ struct amdkfd_process_info {
 	struct amdgpu_amdkfd_fence *eviction_fence;
 
 	/* MMU-notifier related fields */
-	atomic_t evicted_bos;
+	struct mutex notifier_lock;
+	uint32_t evicted_bos;
 	struct delayed_work restore_userptr_work;
 	struct pid *pid;
 	bool block_mmu_notifications;
@@ -180,7 +183,8 @@ int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm);
 struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f);
 int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo);
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm);
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+				unsigned long cur_seq, struct kgd_mem *mem);
 #else
 static inline
 bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
@@ -201,7 +205,8 @@ int amdgpu_amdkfd_remove_fence_on_pt_pd_bos(struct amdgpu_bo *bo)
 }
 
 static inline
-int amdgpu_amdkfd_evict_userptr(struct kgd_mem *mem, struct mm_struct *mm)
+int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
+				unsigned long cur_seq, struct kgd_mem *mem)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8782916e64a0..0a854bb8b47e 100644
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
-	amdgpu_hmm_unregister(mem->bo);
+	/* Cleanup user pages and MMU notifiers */
+	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
+		amdgpu_hmm_unregister(mem->bo);
+		mutex_lock(&process_info->notifier_lock);
+		amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm, mem->range);
+		mutex_unlock(&process_info->notifier_lock);
+	}
 
 	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
 	if (unlikely(ret))
@@ -1864,6 +1875,16 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	 */
 	mutex_lock(&mem->process_info->lock);
 
+	/* Lock notifier lock. If we find an invalid userptr BO, we can be
+	 * sure that the MMU notifier is no longer running
+	 * concurrently and the queues are actually stopped
+	 */
+	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
+		mutex_lock(&mem->process_info->notifier_lock);
+		is_invalid_userptr = !!mem->invalid;
+		mutex_unlock(&mem->process_info->notifier_lock);
+	}
+
 	mutex_lock(&mem->lock);
 
 	domain = mem->domain;
@@ -2241,34 +2262,38 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
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
@@ -2285,54 +2310,58 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
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
-		struct hmm_range *range;
-
-		invalid = atomic_read(&mem->invalid);
+		invalid = mem->invalid;
 		if (!invalid)
 			/* BO hasn't been invalidated since the last
-			 * revalidation attempt. Keep its BO list.
+			 * revalidation attempt. Keep its page list.
 			 */
 			continue;
 
 		bo = mem->bo;
 
+		amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm, mem->range);
+		mem->range = NULL;
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
 		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
-						   &range);
+						   &mem->range);
 		if (ret) {
 			pr_debug("Failed %d to get user pages\n", ret);
 
@@ -2345,30 +2374,32 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			 */
 			if (ret != -EFAULT)
 				return ret;
-		} else {
 
-			/*
-			 * FIXME: Cannot ignore the return code, must hold
-			 * notifier_lock
-			 */
-			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
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
@@ -2439,9 +2470,6 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 			}
 		}
 
-		list_move_tail(&mem->validate_list.head,
-			       &process_info->userptr_valid_list);
-
 		/* Update mapping. If the BO was not validated
 		 * (because we couldn't get user pages), this will
 		 * clear the page table entries, which will result in
@@ -2457,7 +2485,9 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
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
@@ -2477,6 +2507,36 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
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
+		bool valid = amdgpu_ttm_tt_get_user_pages_done(
+				mem->bo->tbo.ttm, mem->range);
+
+		mem->range = NULL;
+		if (!valid) {
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
@@ -2491,9 +2551,11 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
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
 
@@ -2516,9 +2578,6 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * and we can just restart the queues.
 	 */
 	if (!list_empty(&process_info->userptr_inval_list)) {
-		if (atomic_read(&process_info->evicted_bos) != evicted_bos)
-			goto unlock_out; /* Concurrent eviction, try again */
-
 		if (validate_invalid_user_pages(process_info))
 			goto unlock_out;
 	}
@@ -2527,10 +2586,17 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
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
@@ -2538,6 +2604,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 		 */
 	}
 
+unlock_notifier_out:
+	mutex_unlock(&process_info->notifier_lock);
 unlock_out:
 	mutex_unlock(&process_info->lock);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 65715cb395d8..2dadcfe43d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -105,17 +105,11 @@ static bool amdgpu_hmm_invalidate_hsa(struct mmu_interval_notifier *mni,
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
@@ -244,9 +238,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	return r;
 }
 
-int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
+bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
 {
-	int r;
+	bool r;
 
 	r = mmu_interval_read_retry(hmm_range->notifier,
 				    hmm_range->notifier_seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index 13ed94d3b01b..e2edcd010ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -29,12 +29,13 @@
 #include <linux/rwsem.h>
 #include <linux/workqueue.h>
 #include <linux/interval_tree.h>
+#include <linux/mmu_notifier.h>
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
 			       void *owner, struct page **pages,
 			       struct hmm_range **phmm_range);
-int amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
+bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
 int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index dd8b6a11db9a..5c6fabaa4444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -703,8 +703,19 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
 	return r;
 }
 
+/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array allocations
+ */
+void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
+				      struct hmm_range *range)
+{
+	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+
+	if (gtt && gtt->userptr && range)
+		amdgpu_hmm_range_get_pages_done(range);
+}
+
 /*
- * amdgpu_ttm_tt_userptr_range_done - stop HMM track the CPU page table change
+ * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page table change
  * Check if the pages backing this ttm range have been invalidated
  *
  * Returns: true if pages are still valid
@@ -722,10 +733,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
 
 	WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
 
-	/*
-	 * FIXME: Must always hold notifier_lock for this, and must
-	 * not ignore the return code.
-	 */
 	return !amdgpu_hmm_range_get_pages_done(range);
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b4d8ba2789f3..e2cd5894afc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -159,6 +159,8 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
 				 struct hmm_range **range);
+void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
+				      struct hmm_range *range);
 bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
 				       struct hmm_range *range);
 #else
@@ -168,6 +170,10 @@ static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 {
 	return -EPERM;
 }
+static inline void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
+						    struct hmm_range *range)
+{
+}
 static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
 						     struct hmm_range *range)
 {
-- 
2.32.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590BBC61DF7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 22:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B34210E36C;
	Thu, 23 Nov 2023 22:55:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2571110E366
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Nov 2023 22:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IihsIpb742pWlleOWbs9VQdiYzyjNTPdPbOnEvSyvMxB/k7ID/c6Z6kAfnkR/s3gfo0qt+R2cN2TapeHIOqnBtZtojal9Ky5kCu1MwROf9I51euV5e6OzRcIcWb1czIO4CJ2+PXINxrgQi8rCvJIGfkw+Sh9XFHWQAf3H786GFEC6QmcK6iwfwBY+JDI4Bb9ywL0fN5GzzxeBDsY1W0biRCf0Xv7S9TO29D9ADRpat6rZy5l7xzjV21YYkqmmlJ+YUtdnfH9kRBAqMfxG4hE6HbRelAKNGPMIbnOywWmLlROSnmzYOQNrPFDE3+M/FWItS3cGj/UwkR/ivqyk6o5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNxLiy6r4QpOkJIZ2PlC8hA4371/VPdT7RUBThTZE4o=;
 b=eei5vRxYNIlR0upQ77J7A7SeNsRN4gP10OXRwfDMDeof0lV7o4todSHpf79/q4DqonCOzXswAb2mwPCUf2RqLNMoh0yltrxPbNdGRlCkgPJ17BQcDWItDPkR7tiSndxpdKv4nvNoh76WIGWYwlJkvCrQ13o3BPeuyWQ9J231tQyqJR28dOwjacXJJAB7kMwfKGqENWm5J/tYjBoNC6AqJQuS6ykltz+0jpVwQPT47Le7WChdzeQAnu3YPoIJcmJJd/TTanU09bbdVp7lj9sAWSK10Oo+J4nGG9AYyXQfnB6Znavg3WXM9KoqkPYxZd2jKtcj1G+JttMvzqjvxelXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNxLiy6r4QpOkJIZ2PlC8hA4371/VPdT7RUBThTZE4o=;
 b=3qqB9VJV8KoSilXJ/oEq5jprtWyUR8RtMQWsnIAn+0mU1NYvLotxN2q+jITVeK5mRiIlnT4dJhbAywQUmwSYi4hbVi4JqG1cAepDS25ZfXg5dCvHLoPltBSOoRsccTg/06vl4f5DG9WxDpQUjFGZnVdJlatqdgesdzyb+euLRp8=
Received: from BL1PR13CA0238.namprd13.prod.outlook.com (2603:10b6:208:2bf::33)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 22:55:29 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2bf:cafe::c) by BL1PR13CA0238.outlook.office365.com
 (2603:10b6:208:2bf::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Thu, 23 Nov 2023 22:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Thu, 23 Nov 2023 22:55:29 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 23 Nov
 2023 16:55:28 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdkfd: Run restore_workers on freezable WQs
Date: Thu, 23 Nov 2023 17:55:06 -0500
Message-ID: <20231123225506.986511-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 097e77d7-8ea1-4390-7aa5-08dbec774a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7W800DyKagNwmnR52oBWhryOFd2Kqvd5ePEFyxsURxO4DM8QFjpdhCBxzJfg7c3vpc6zjqpMDURI7PofaaCDBS+9DfTbbATwi57IDShNUSNk6x5fLxQDyoTinsi53TcTLNyl2wAbIamLtlDDX73d57eMFXN6Jpu+86R2lsS0bIoCahz7ddvHT40c7G1lMjDd5q4EoSfjwBDuSnXb5AETY6/keRV2NqAuNuWoYoyAoPn9HDPXegWjf9uKPYRpxWHkEUO1YHsqC2Gaz3iEr8hMxUEOLujMhjp89x/UnzpJuQLVue0djmbRQFxmtVDYhkH+BdQdd7wFwyxyT+P1v+j881l7WCxvS8isQKh8x0+SE+gTp77RVZVfrhPSIRDCTIXYgVBs+6D0OmhsaZQWFrtxLnqL+0HwNLik5Nnzu481ArFOkjJmEtsNMRz1QPN13xWJGleXuVFUSrjFDFGOtlbB/lPqMsge3RuIezg32LvE6sXUJpBdQl5dtvsYtneclRpP+/MxczmOuQ53PDG1wo9bVJQfJ514ARbINR8OoDQ2XntiuvNAWaiDmjo5OVOJxSBO4SQNbLP5lpNllFiHUdYb/RB/zBo/PyMGTdj3xQFyamOkaUWHxq5mVT+4sNCDgAyP0tzFvS5o9l+RpkSoU869o2lCgus9jGn2WQ1K9zbYY5B+ygTwFMJndFpftQIo4fGuYdrotV+KbSncW9SqTCxPcFVXZJtk1rjUjbGklWQ5w4BbSVQh/XjV4IGmHGowXaF6/ZGkgbAXpQTA3L8QyF1OAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(36840700001)(46966006)(40480700001)(16526019)(40460700003)(82740400003)(70586007)(54906003)(70206006)(36756003)(81166007)(356005)(6916009)(86362001)(36860700001)(47076005)(336012)(426003)(83380400001)(26005)(1076003)(7696005)(6666004)(2616005)(478600001)(2906002)(316002)(66574015)(8676002)(8936002)(4326008)(5660300002)(41300700001)(30864003)(45080400002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 22:55:29.5255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097e77d7-8ea1-4390-7aa5-08dbec774a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make restore workers freezable so we don't have to explicitly flush them
in suspend and GPU reset code paths, and we don't accidentally try to
restore BOs while the GPU is suspended. Not having to flush restore_work
also helps avoid lock/fence dependencies in the GPU reset case where we're
not allowed to wait for fences.

A side effect of this is, that we can now have multiple concurrent threads
trying to signal the same eviction fence. Rework eviction fence signaling
and replacement to account for that.

The GPU reset path can no longer rely on restore_process_worker to resume
queues because evict/restore workers can run independently of it. Instead
call a new restore_process_helper directly.

This is an RFC and request for testing.

v2:
- Reworked eviction fence signaling
- Introduced restore_process_helper

v3:
- Handle unsignaled eviction fences in restore_process_bos

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 68 +++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 3 files changed, 104 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 2e302956a279..bdec88713a09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1431,7 +1431,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
 		*process_info = info;
-		*ef = dma_fence_get(&info->eviction_fence->base);
 	}
 
 	vm->process_info = *process_info;
@@ -1462,6 +1461,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	list_add_tail(&vm->vm_list_node,
 			&(vm->process_info->vm_list_head));
 	vm->process_info->n_vms++;
+
+	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
 	mutex_unlock(&vm->process_info->lock);
 
 	return 0;
@@ -1473,10 +1474,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 reserve_pd_fail:
 	vm->process_info = NULL;
 	if (info) {
-		/* Two fence references: one in info and one in *ef */
 		dma_fence_put(&info->eviction_fence->base);
-		dma_fence_put(*ef);
-		*ef = NULL;
 		*process_info = NULL;
 		put_pid(info->pid);
 create_evict_fence_fail:
@@ -1670,7 +1668,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
 		goto out_unlock;
 	}
 	WRITE_ONCE(pinfo->block_mmu_notifications, false);
-	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+	queue_delayed_work(system_freezable_wq,
+			   &pinfo->restore_userptr_work, 0);
 
 out_unlock:
 	mutex_unlock(&pinfo->lock);
@@ -2475,7 +2474,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 	}
 	mutex_unlock(&process_info->notifier_lock);
@@ -2810,7 +2810,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_bos) {
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -2819,6 +2820,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	put_task_struct(usertask);
 }
 
+static void replace_eviction_fence(struct dma_fence **ef,
+				   struct dma_fence *new_ef)
+{
+	struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, true
+		/* protected by process_info->lock */);
+
+	/* If we're replacing an unsignaled eviction fence, that fence will
+	 * never be signaled, and if anyone is still waiting on that fence,
+	 * they will hang forever. This should never happen. We should only
+	 * replace the fence in restore_work that only gets scheduled after
+	 * eviction work signaled the fence.
+	 */
+	WARN_ONCE(!dma_fence_is_signaled(old_ef),
+		  "Replacing unsignaled eviction fence");
+	dma_fence_put(old_ef);
+}
+
 /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the given
  *   KFD process identified by process_info
  *
@@ -2844,7 +2862,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	struct amdgpu_vm *peer_vm;
 	struct kgd_mem *mem;
 	struct bo_vm_reservation_context ctx;
-	struct amdgpu_amdkfd_fence *new_fence;
 	int ret = 0, i;
 	struct list_head duplicate_save;
 	struct amdgpu_sync sync_obj;
@@ -2974,22 +2991,35 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	/* Wait for validate and PT updates to finish */
 	amdgpu_sync_wait(&sync_obj, false);
 
-	/* Release old eviction fence and create new one, because fence only
-	 * goes from unsignaled to signaled, fence cannot be reused.
-	 * Use context and mm from the old fence.
+	/* The old eviction fence may be unsignaled if restore happens
+	 * after a GPU reset or suspend/resume. Keep the old fence in that
+	 * case. Otherwise release the old eviction fence and create new
+	 * one, because fence only goes from unsignaled to signaled once
+	 * and cannot be reused. Use context and mm from the old fence.
+	 *
+	 * If an old eviction fence signals after this check, that's OK.
+	 * Anyone signaling an eviction fence must stop the queues first
+	 * and schedule another restore worker.
 	 */
-	new_fence = amdgpu_amdkfd_fence_create(
+	if (dma_fence_is_signaled(&process_info->eviction_fence->base)) {
+		struct amdgpu_amdkfd_fence *new_fence =
+			amdgpu_amdkfd_fence_create(
 				process_info->eviction_fence->base.context,
 				process_info->eviction_fence->mm,
 				NULL);
-	if (!new_fence) {
-		pr_err("Failed to create eviction fence\n");
-		ret = -ENOMEM;
-		goto validate_map_fail;
+
+		if (!new_fence) {
+			pr_err("Failed to create eviction fence\n");
+			ret = -ENOMEM;
+			goto validate_map_fail;
+		}
+		dma_fence_put(&process_info->eviction_fence->base);
+		process_info->eviction_fence = new_fence;
+		replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
+	} else {
+		WARN_ONCE(*ef != &process_info->eviction_fence->base,
+			  "KFD eviction fence doesn't match KGD process_info");
 	}
-	dma_fence_put(&process_info->eviction_fence->base);
-	process_info->eviction_fence = new_fence;
-	*ef = dma_fence_get(&new_fence->base);
 
 	/* Attach new eviction fence to all BOs except pinned ones */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c10d050e1a61..71df51fcc1b0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
 	if (!kfd_process_wq)
 		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
 	if (!kfd_restore_wq)
-		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq", 0);
+		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
+							 WQ_FREEZABLE);
 
 	if (!kfd_process_wq || !kfd_restore_wq) {
 		kfd_process_destroy_wq();
@@ -1642,6 +1643,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct amdgpu_fpriv *drv_priv;
 	struct amdgpu_vm *avm;
 	struct kfd_process *p;
+	struct dma_fence *ef;
 	struct kfd_node *dev;
 	int ret;
 
@@ -1661,11 +1663,12 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 
 	ret = amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
 						     &p->kgd_process_info,
-						     &p->ef);
+						     &ef);
 	if (ret) {
 		pr_err("Failed to create process VM object\n");
 		return ret;
 	}
+	RCU_INIT_POINTER(p->ef, ef);
 	pdd->drm_priv = drm_file->private_data;
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
@@ -1908,6 +1911,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
 	return -EINVAL;
 }
 
+static int signal_eviction_fence(struct kfd_process *p)
+{
+	struct dma_fence *ef;
+	int ret;
+
+	rcu_read_lock();
+	ef = dma_fence_get_rcu_safe(&p->ef);
+	rcu_read_unlock();
+
+	ret = dma_fence_signal(ef);
+	dma_fence_put(ef);
+
+	return ret;
+}
+
 static void evict_process_worker(struct work_struct *work)
 {
 	int ret;
@@ -1920,31 +1938,46 @@ static void evict_process_worker(struct work_struct *work)
 	 * lifetime of this thread, kfd_process p will be valid
 	 */
 	p = container_of(dwork, struct kfd_process, eviction_work);
-	WARN_ONCE(p->last_eviction_seqno != p->ef->seqno,
-		  "Eviction fence mismatch\n");
-
-	/* Narrow window of overlap between restore and evict work
-	 * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
-	 * unreserves KFD BOs, it is possible to evicted again. But
-	 * restore has few more steps of finish. So lets wait for any
-	 * previous restore work to complete
-	 */
-	flush_delayed_work(&p->restore_work);
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
 	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
 	if (!ret) {
-		dma_fence_signal(p->ef);
-		dma_fence_put(p->ef);
-		p->ef = NULL;
-		queue_delayed_work(kfd_restore_wq, &p->restore_work,
+		/* If another thread already signaled the eviction fence,
+		 * they are responsible stopping the queues and scheduling
+		 * the restore work.
+		 */
+		if (!signal_eviction_fence(p))
+			queue_delayed_work(kfd_restore_wq, &p->restore_work,
 				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
+		else
+			kfd_process_restore_queues(p);
 
 		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
 	} else
 		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
 }
 
+static int restore_process_helper(struct kfd_process *p)
+{
+	int ret = 0;
+
+	/* VMs may not have been acquired yet during debugging. */
+	if (p->kgd_process_info) {
+		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(
+			p->kgd_process_info, &p->ef);
+		if (ret)
+			return ret;
+	}
+
+	ret = kfd_process_restore_queues(p);
+	if (!ret)
+		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
+	else
+		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
+
+	return ret;
+}
+
 static void restore_process_worker(struct work_struct *work)
 {
 	struct delayed_work *dwork;
@@ -1970,24 +2003,15 @@ static void restore_process_worker(struct work_struct *work)
 	 */
 
 	p->last_restore_timestamp = get_jiffies_64();
-	/* VMs may not have been acquired yet during debugging. */
-	if (p->kgd_process_info)
-		ret = amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_process_info,
-							     &p->ef);
+
+	ret = restore_process_helper(p);
 	if (ret) {
 		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
 			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
 		ret = queue_delayed_work(kfd_restore_wq, &p->restore_work,
 				msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS));
 		WARN(!ret, "reschedule restore work failed\n");
-		return;
 	}
-
-	ret = kfd_process_restore_queues(p);
-	if (!ret)
-		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
-	else
-		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
 }
 
 void kfd_suspend_all_processes(void)
@@ -1998,14 +2022,9 @@ void kfd_suspend_all_processes(void)
 
 	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		cancel_delayed_work_sync(&p->eviction_work);
-		flush_delayed_work(&p->restore_work);
-
 		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
-		dma_fence_signal(p->ef);
-		dma_fence_put(p->ef);
-		p->ef = NULL;
+		signal_eviction_fence(p);
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
@@ -2017,7 +2036,7 @@ int kfd_resume_all_processes(void)
 	int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0)) {
+		if (restore_process_helper(p)) {
 			pr_err("Restore process %d failed during resume\n",
 			       p->pasid);
 			ret = -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b23ba92a794c..42b5279c7010 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1871,7 +1871,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
 		pr_debug("reschedule to restore svm range\n");
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -1947,7 +1947,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug("failed to quiesce KFD\n");
 
 		pr_debug("schedule to restore svm %p ranges\n", svms);
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
 		unsigned long s, l;
-- 
2.34.1


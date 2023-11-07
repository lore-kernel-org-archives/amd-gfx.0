Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE350C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 22:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4959110E3BD;
	Tue,  7 Nov 2023 22:06:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEEFB10E3BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 22:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZe8arBYZsJ5jqJ30iydGLcLNJLaDCITrPuUOSxJT9whwNLUQmImry0EtqmIscBcgwTGCmnU/KVHIpqBw6DZ80pjfsDl+g6YXsz/CvoF45+9aOB4JRt5op51tLfig0xNdABVoPDygqRMCgBpZ0/OZPmnxaTxjazdmiiaNfzwTRFScTYnlEe/Q+JCNEIatcL0dHdhomHONm+OYBG6YUnuQ00vir4e0SchETjNe4NxYpsQHlEc3fQ2DJQE80LI+GR4ueUq6BoM4cIzUMopXe8JpImDX5Wo6fHauBIJsS80QkiWZE6m99KolPAgGqoC0lmNuQWmt3j0NWPc/g/jQGvKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDPSU7DvsIVu0ESGMPzdLAmwLuHCY7XyaYWzHPP9H5o=;
 b=kPP88OtpUjc8SAWGJvp//FYE8n3r/6HBqx2aKxz9mYddXiAlqWbuXKrvhSGCDBOabrZuIlhDmURjTZEzCX29Gvm4rGkHfpmY8wvdTBpbJrulK6lPOwUo8jjl/UmpBmGcnHT9Nsr1S0ZGSDjglmIE8QqzbRt2XYHlx+S2WlH5nVSiFx60veOhBW3ixDVMtOt3pGji86572kjlrQNtWlxCBVfo1/QSoP7GeobxptOvi1llZ0JfLQpYwxr/6Q/SBcdLclVzxhqebp/sAd2D9N6OsqWeamAy7gBeBEiOYm21Nh0kV/CX5tW5zkQrti9QnrgTf92Qva+ccFRbShnqbHxFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDPSU7DvsIVu0ESGMPzdLAmwLuHCY7XyaYWzHPP9H5o=;
 b=5pkOk+QSWOwccREcoeUS1BiBF1/U++xWYKpO1/miT98DQt4mU3R2sI/vQUKo4DvuYmI5ApI4wHY+ZbPhkZ864AYcMmarwr5Uj/dZQu+gsRo6rsoZ87BMxNGeAzZoewp3bv7Wx0JEdmqPkRRzf8Qz0gSSjoYN1BBn44h+R6dEfhY=
Received: from SA0PR12CA0006.namprd12.prod.outlook.com (2603:10b6:806:6f::11)
 by CH2PR12MB5017.namprd12.prod.outlook.com (2603:10b6:610:36::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 22:06:27 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::ad) by SA0PR12CA0006.outlook.office365.com
 (2603:10b6:806:6f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 22:06:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 22:06:27 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 16:06:25 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
Date: Tue, 7 Nov 2023 17:05:40 -0500
Message-ID: <20231107220540.3711990-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH2PR12MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e6ada6-8a43-419f-550b-08dbdfddc9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo30Sw/hCwjY1vgwNC9g+mQdqv+vI/NrYytAoY/KnORpTu/TNnkG6CjGR5kl17un8PRiJlZNzAInJnTUMLNgG3DpHi7s1MwjzmTi6FmytA9SIA0zvpIHIkipgjY5Bl/j+vsdt1w4v4nMLvzBuf8iALMSVeDhHtTanPBsI/VfWAAA2OQusz0lVsUlfHvMOAgkfXZL7d29FVez5Cf5Igjcb+tbKDpXTM/fwe/ej7sytTemXLBOvAgiZFJ3MWTNrwQuicGfYF4oDmkALlIcSHs0IOaZTy5ttCOEclJYm61Pdz7rz4fDMWg11COAIlWLvQVMpuZwiGjOjrfYEyFeaz1TQjA5sJDGmR14j/ssKSTwWVYv+9XSIinKjOIu5rs7eaRycYtjVtNQzeV2aZPt6P2U1gGpVSIAMHqkB7vk5eqyzwpmWv7QEwG0QWtz96SiDgbj+Ngx7Ed/Jf6c/+990sZv53oF7SCazqJc3sefIgzQypykA4O/T5WlhgJ0Vo2PAbf+DS75hzn5c+TcgtLb2dF+XK6YwzBIaMp83JFLby8Uw/nKW0AJzVwSWTN07m5MYg36YZimVwYWLlc7KAfGq2pNMJAIiIu6UmH2t43b44YBZbf3/V8MR1+cqr3GKhVgyGg1aracl8YbLr6f5ZYcWBafKrGfS765FMpHRCmZux3MnZqCxQBazAikmrsqNmARybPJbrpPNzOrZLvKqMlTX+hyLDUaFAl3TKY25S8iCJjm8TVDx4WevrEg6YQ7WlSFtQFMcR+ExZA0qQvSi9DmhJ21gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(8676002)(6916009)(54906003)(41300700001)(4326008)(40480700001)(36756003)(316002)(8936002)(2906002)(5660300002)(36860700001)(47076005)(356005)(86362001)(30864003)(81166007)(40460700003)(70586007)(70206006)(83380400001)(336012)(26005)(16526019)(82740400003)(1076003)(2616005)(45080400002)(426003)(6666004)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:06:27.0710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e6ada6-8a43-419f-550b-08dbdfddc9e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5017
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

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 3 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..1b33ddc0512e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1405,7 +1405,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
 		*process_info = info;
-		*ef = dma_fence_get(&info->eviction_fence->base);
 	}
 
 	vm->process_info = *process_info;
@@ -1436,6 +1435,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 	list_add_tail(&vm->vm_list_node,
 			&(vm->process_info->vm_list_head));
 	vm->process_info->n_vms++;
+
+	*ef = dma_fence_get(&vm->process_info->eviction_fence->base);
 	mutex_unlock(&vm->process_info->lock);
 
 	return 0;
@@ -1447,10 +1448,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
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
@@ -1644,7 +1642,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
 		goto out_unlock;
 	}
 	WRITE_ONCE(pinfo->block_mmu_notifications, false);
-	schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+	queue_delayed_work(system_freezable_wq,
+			   &pinfo->restore_userptr_work, 0);
 
 out_unlock:
 	mutex_unlock(&pinfo->lock);
@@ -2458,7 +2457,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
 		if (r)
 			pr_err("Failed to quiesce KFD\n");
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 	}
 	mutex_unlock(&process_info->notifier_lock);
@@ -2793,7 +2793,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	/* If validation failed, reschedule another attempt */
 	if (evicted_bos) {
-		schedule_delayed_work(&process_info->restore_userptr_work,
+		queue_delayed_work(system_freezable_wq,
+			&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -2802,6 +2803,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
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
@@ -2956,7 +2974,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	}
 	dma_fence_put(&process_info->eviction_fence->base);
 	process_info->eviction_fence = new_fence;
-	*ef = dma_fence_get(&new_fence->base);
+	replace_eviction_fence(ef, dma_fence_get(&new_fence->base));
 
 	/* Attach new eviction fence to all BOs except pinned ones */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fbf053001af9..568c49f2f0ab 100644
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
@@ -1637,6 +1638,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	struct amdgpu_fpriv *drv_priv;
 	struct amdgpu_vm *avm;
 	struct kfd_process *p;
+	struct dma_fence *ef;
 	struct kfd_node *dev;
 	int ret;
 
@@ -1656,11 +1658,12 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 
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
 	atomic64_set(&pdd->tlb_seq, 0);
 
@@ -1904,6 +1907,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
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
@@ -1916,31 +1934,46 @@ static void evict_process_worker(struct work_struct *work)
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
@@ -1966,24 +1999,15 @@ static void restore_process_worker(struct work_struct *work)
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
@@ -1994,14 +2018,9 @@ void kfd_suspend_all_processes(void)
 
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
@@ -2013,7 +2032,7 @@ int kfd_resume_all_processes(void)
 	int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0)) {
+		if (restore_process_helper(p)) {
 			pr_err("Restore process %d failed during resume\n",
 			       p->pasid);
 			ret = -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fe937670c927..aa6c34127be9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	/* If validation failed, reschedule another attempt */
 	if (evicted_ranges) {
 		pr_debug("reschedule to restore svm range\n");
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 
 		kfd_smi_event_queue_restore_rescheduled(mm);
@@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 			pr_debug("failed to quiesce KFD\n");
 
 		pr_debug("schedule to restore svm %p ranges\n", svms);
-		schedule_delayed_work(&svms->restore_work,
+		queue_delayed_work(system_freezable_wq, &svms->restore_work,
 			msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS));
 	} else {
 		unsigned long s, l;
-- 
2.34.1


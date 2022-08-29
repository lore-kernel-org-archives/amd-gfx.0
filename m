Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5681AC0502C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4B210F30B;
	Mon, 29 Aug 2022 14:31:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2217A10F2FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtmalsyAHxzP6izAJaERCzw+IlCPaHYWFWa2tTCFjhG/VOrcJNdk1b6/Jr57vELOH/Dpx4jhSe6dP8uLZBCrY5XAlg6JPpbg3RU9WERR4Zjq6PXDX56Sf6DqwjrhZklAtMfOIqjsHXsVvrl2HWqeh/VdzGJGhfFgYnl6MsFkIYO5P8XkqQUIcAOmFEBqNLeei5Kj7p4kfUG/Sc7uRabUSUoCrUgTQ/FhbBcdWYrVlsF0mN1OOdq/34j8Htrcy3pK+bIJ0gQL8zllFUSSb0+7FnKWmzfgYRXv7iTNGXiGKOFXTiY7kB20Y0bNACeJUwqsZ2lP2/6poA1v27SeW7BzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC3S8D0Uy9Vmj5qvXIzyO6W7NZJ1o9ygTNZVRsFfGgU=;
 b=OT5RydoueQnB/iSCNX7hKM2CpH7CfqGeRdRZJpmuAYStTlawuNqb9dlubiVUvFGfXYz56LMhHc35hIxy6O2FxaTqWnxLUiYdQvhQghF7TDNIJyCStvcDLf6sd5SljBzbMGiQ2pslrvvWrbz3cuUCNl/mYOc+r3nE0L1ymzGeTY81rCCLLAB2QV+2tq0jM5li8tbIAibT4SFtvqxPOqNt9lOxx7LGd+qgV1slneMHBnay34tjoEBw41WFVARIWfY/MGyTiKjksmOTtd05zQlI4u4aziWZDv3qGLNS2f8LnfTJpWBReeSDFFx3FrFGTV9ZhBKTslyd9pUDo8d2hadcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC3S8D0Uy9Vmj5qvXIzyO6W7NZJ1o9ygTNZVRsFfGgU=;
 b=jAiWXyOwlGfplvLzztArOEHKttustC9rSCzuj9s5kGjBO2vTxfbiQJZyODkpby31DXhNIH7QRgNgSvbtn1quwSpyvY8d9dMZ48p66iphMxKu6tvYYLhjZEhpWoi1H2i7lP7YH085x3yh6qMF91BWOH9EaaTrdVStY3idxGmtN3g=
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by SN6PR12MB4750.namprd12.prod.outlook.com (2603:10b6:805:e3::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Mon, 29 Aug
 2022 14:31:13 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::a) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:13 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:47 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/29] drm/amdkfd: add send exception operation
Date: Mon, 29 Aug 2022 10:30:12 -0400
Message-ID: <20220829143026.1509027-16-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bab84736-8851-4c70-6cf1-08da89cb1fff
X-MS-TrafficTypeDiagnostic: SN6PR12MB4750:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8N9iYMc6USMcYAuod8WcOSMrBpmw3g0ET+4jJCU2IxhQMOkeEL6iDISJYMRWAIKh4hkIcLwqMl5JBGPexXek3U891tiPNXvSZgHlA+R4bJqGp9FB8C3zCmKHmvB1NeAdpwijX9ivgoveqh5XPXGcNJIuTbAHstoPXNYuZnbHR34l/59buzKq8xEPF7KTng28VPgCQvVRBBG4jcnvTMTox7h1Xq+T7GCNC0oPSGHAiha3I6GD8K4WWwIG6GiKTw2hsVlqHxLh6+bHpgQUslTkdO/9B8lyeolIIlhgR+CSnWZZOHz/PdNIoISqvU9hTm3OKkOFQuh9dgOu7PqXgVURygBWGh/CB6gCHx0o1rOsbR7hA9aE5mmFoLO5hPzL2jaXfId++edfyYam8v/jbQqKS2xcvdZV7MeqlSKwskQ9uuzM7xcXChBJJEQNMooyYxO0KrkRKw3sKaKNOcJzub9vtWJJgBc1RImQe9TnHLgUoxAlHpRBW9ux6jG96rVxo+qlrARXeB5qeBbJZJM6mtWKcpFUmqXZNPSY0bWlRfy2n53Q/A+Xt1ca13rUIs3Ttx5Rmt5+AS7u6P+O3yRaSC3O/dfVIQHwg6PzcEEl/irDDNzLknO94hHxmkJ8QB9JxnCy+1luOSBtq8cWrYUofssDAOwradgjf9OZqeCnvwxEfkSgiihJdnf2/mgNNglAiQfoih+jh8kQQA5oHrGuBCJHJcQv6Kz3Z9cm0UMqsaQeY6yj2MwMH7phlCXV0IId6TYQnT+G4JmF3LQ1AnuHbWxuYWCB2lLJCQ9YE+a653RwG+0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(40470700004)(40480700001)(82310400005)(2906002)(4326008)(8676002)(70586007)(70206006)(6666004)(8936002)(7696005)(316002)(6916009)(26005)(54906003)(41300700001)(478600001)(86362001)(40460700003)(16526019)(36860700001)(1076003)(186003)(47076005)(426003)(356005)(336012)(2616005)(81166007)(83380400001)(5660300002)(36756003)(82740400003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:13.2671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab84736-8851-4c70-6cf1-08da89cb1fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4750
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a debug operation that allows the debugger to send an exception
directly to runtime through a payload address.

For memory violations, normal vmfault signals will be applied to
notify runtime instead after passing in the saved exception data
when a memory violation was raised to the debugger.

For runtime exceptions, this will unblock the runtime enable
function which will be explained and implemented in a follow up
patch.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 43 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |  5 ++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 71 ++++++++++++++++++-
 8 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 5c8023cba196..62a38cd820fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -118,9 +118,9 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
 			return;
 
 		if (info.vmid == vmid)
-			kfd_signal_vm_fault_event(dev, pasid, &info);
+			kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
 		else
-			kfd_signal_vm_fault_event(dev, pasid, NULL);
+			kfd_signal_vm_fault_event(dev, pasid, NULL, NULL);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index beb26c93d920..8e25f47d7028 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2708,6 +2708,11 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		r = kfd_dbg_trap_disable(target);
 		break;
 	case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
+		r = kfd_dbg_send_exception_to_runtime(target,
+				args->send_runtime_event.gpu_id,
+				args->send_runtime_event.queue_id,
+				args->send_runtime_event.exception_mask);
+		break;
 	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
 	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index b7a4b2ec5b36..87a23b1d4d49 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -125,6 +125,49 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 	return is_subscribed;
 }
 
+int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
+					unsigned int dev_id,
+					unsigned int queue_id,
+					uint64_t error_reason)
+{
+	if (error_reason & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
+		struct kfd_process_device *pdd = NULL;
+		struct kfd_hsa_memory_exception_data *data;
+		int i;
+
+		for (i = 0; i < p->n_pdds; i++) {
+			if (p->pdds[i]->dev->id == dev_id) {
+				pdd = p->pdds[i];
+				break;
+			}
+		}
+
+		if (!pdd)
+			return -ENODEV;
+
+		data = (struct kfd_hsa_memory_exception_data *)
+						pdd->vm_fault_exc_data;
+
+		kfd_dqm_evict_pasid(pdd->dev->dqm, p->pasid);
+		kfd_signal_vm_fault_event(pdd->dev, p->pasid, NULL, data);
+		error_reason &= ~KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION);
+	}
+
+	if (error_reason & (KFD_EC_MASK(EC_PROCESS_RUNTIME))) {
+		/*
+		 * block should only happen after the debugger receives runtime
+		 * enable notice.
+		 */
+		up(&p->runtime_enable_sema);
+		error_reason &= ~KFD_EC_MASK(EC_PROCESS_RUNTIME);
+	}
+
+	if (error_reason)
+		return kfd_send_exception_to_runtime(p, queue_id, error_reason);
+
+	return 0;
+}
+
 /* kfd_dbg_trap_deactivate:
  *	target: target process
  *	unwind: If this is unwinding a failed kfd_dbg_trap_enable()
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index a288ca1941a6..8aa52cc3af17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -38,6 +38,11 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
 			void __user *runtime_info,
 			uint32_t *runtime_info_size);
 
+int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
+					unsigned int dev_id,
+					unsigned int queue_id,
+					uint64_t error_reason);
+
 static inline bool kfd_dbg_is_per_vmid_supported(struct kfd_dev *dev)
 {
 	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2); /* Aldebaran */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 83e3ce9f6049..6958c5389fbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1226,7 +1226,8 @@ void kfd_signal_hw_exception_event(u32 pasid)
 }
 
 void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
-				struct kfd_vm_fault_info *info)
+				struct kfd_vm_fault_info *info,
+				struct kfd_hsa_memory_exception_data *data)
 {
 	struct kfd_event *ev;
 	uint32_t id;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 0b75a37b689b..e092563f22de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -362,7 +362,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 
 		kfd_smi_event_update_vmfault(dev, pasid);
 		kfd_dqm_evict_pasid(dev->dqm, pasid);
-		kfd_signal_vm_fault_event(dev, pasid, &info);
+		kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 40a695619eab..b69f2f94a50e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -942,6 +942,7 @@ struct kfd_process {
 	bool queues_paused;
 
 	/* Tracks runtime enable status */
+	struct semaphore runtime_enable_sema;
 	struct kfd_runtime_info runtime_info;
 
 };
@@ -1391,7 +1392,8 @@ int kfd_get_num_events(struct kfd_process *p);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
 void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
-				struct kfd_vm_fault_info *info);
+				struct kfd_vm_fault_info *info,
+				struct kfd_hsa_memory_exception_data *data);
 
 void kfd_signal_reset_event(struct kfd_dev *dev);
 
@@ -1407,6 +1409,9 @@ static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
 	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
 
+int kfd_send_exception_to_runtime(struct kfd_process *p,
+				unsigned int queue_id,
+				uint64_t error_reason);
 bool kfd_is_locked(void);
 
 /* Compute profile */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c92da9b998d8..19c6863e124b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1405,6 +1405,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->debugger_process = NULL;
 	process->exception_enable_mask = 0;
 	atomic_set(&process->debugged_process_count, 0);
+	sema_init(&process->runtime_enable_sema, 0);
 
 	process->pasid = kfd_pasid_alloc();
 	if (process->pasid == 0) {
@@ -2051,6 +2052,75 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	}
 }
 
+struct send_exception_work_handler_workarea {
+	struct work_struct work;
+	struct kfd_process *p;
+	unsigned int queue_id;
+	uint64_t error_reason;
+};
+
+static void send_exception_work_handler(struct work_struct *work)
+{
+	struct send_exception_work_handler_workarea *workarea;
+	struct kfd_process *p;
+	struct queue *q;
+	struct mm_struct *mm;
+	struct kfd_context_save_area_header __user *csa_header;
+	uint64_t __user *err_payload_ptr;
+	uint64_t cur_err;
+	uint32_t ev_id;
+
+	workarea = container_of(work,
+				struct send_exception_work_handler_workarea,
+				work);
+	p = workarea->p;
+
+	mm = get_task_mm(p->lead_thread);
+
+	if (!mm)
+		return;
+
+	kthread_use_mm(mm);
+
+	q = pqm_get_user_queue(&p->pqm, workarea->queue_id);
+
+	if (!q)
+		goto out;
+
+	csa_header = (void __user *)q->properties.ctx_save_restore_area_address;
+
+	get_user(err_payload_ptr, (uint64_t __user **)&csa_header->err_payload_addr);
+	get_user(cur_err, err_payload_ptr);
+	cur_err |= workarea->error_reason;
+	put_user(cur_err, err_payload_ptr);
+	get_user(ev_id, &csa_header->err_event_id);
+
+	kfd_set_event(p, ev_id);
+
+out:
+	kthread_unuse_mm(mm);
+	mmput(mm);
+}
+
+int kfd_send_exception_to_runtime(struct kfd_process *p,
+			unsigned int queue_id,
+			uint64_t error_reason)
+{
+	struct send_exception_work_handler_workarea worker;
+
+	INIT_WORK_ONSTACK(&worker.work, send_exception_work_handler);
+
+	worker.p = p;
+	worker.queue_id = queue_id;
+	worker.error_reason = error_reason;
+
+	schedule_work(&worker.work);
+	flush_work(&worker.work);
+	destroy_work_on_stack(&worker.work);
+
+	return 0;
+}
+
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
 {
 	int i;
@@ -2110,4 +2180,3 @@ int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
 }
 
 #endif
-
-- 
2.25.1


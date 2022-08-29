Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F2AECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D116D10F2FD;
	Mon, 29 Aug 2022 14:31:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F059A10F2FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIHR6uIkETDAKFKDif0VO8Q1AhEeNnGgbDZM15QkZwlRG9DfRpXX6mQMTLUWXW5E02n0JBc4zbbiUq/66PUu2Fp6YHAFyQ5BdqgFIKwfQqzLYPZS4mm5SJh2fStzYV8YqXYv4Qda6CI17Vt0wDCesnTHLbN210QLPDaAIbdTjzPDPMfpgK6DCqcApKIbLz5vEELyPhNimf1geOmUPe7AL/+WGzAD+9YkffBVZoh90h+x8Fedx8PW/zsxEWtNVQysFIQ19CCHhOTFXmSZ5px28VDWjSWRpmczHv7IE0XqXjTnoLol4GOOAba+3d88U9+6TXDya7bOcVw2EXUomM8OVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeEA9ovV/gqzvQmKJjyVCiULYz+pEK9IzpQ4IIWVbRk=;
 b=Ise6HFWgkB9p4rGuA6gyoXMGFdG6/iTqNHTup6/YxExDG4k7LfOu6Sce4T6NseNKVsorMQLv0y1LqWAu7v6tCag3fRPYE0oaHP9a5AMR34EpXE5EFIjNjDRJXh0FvCr3wyPWsZ4z+/U//dV8WDO2CLQBta2JU4hLs+xxN1oU+E/tjAuven0TGz3+DD+1r1Ey15z3P6TPLTFVqTV7MR57JW6OXUGvfq40OuYY4Dcvmai2n/cplsZq/9nUAMAKzpJIwel6ePHA/cF+t9wC0WTPUIecNyJrcJ+5bNlDGN8qa0fq9c9+41P7MFs30SiPDNSjQxEe+TkWt6SItOJWkPluwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeEA9ovV/gqzvQmKJjyVCiULYz+pEK9IzpQ4IIWVbRk=;
 b=ePtSK/DfPwkMluGrbo5YUdHrHO7nOQfsa4JRrX0H/ax/wZ9kAPhZZnYtFsEnjETWr5vbE6gPZ2ufdQEbzp4tbme3W+n06BgPr04BxtskfH7hzNDHNydoEPgZdBd6aBUVZFcNfpvIYdf0Mp9iviOHWddi+L3DarXC6/jATvlb+5w=
Received: from MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35) by
 BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 14:31:16 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::ed) by MW2PR16CA0022.outlook.office365.com
 (2603:10b6:907::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:16 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:09 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/29] drm/amdkfd: add debug suspend and resume process queues
 operation
Date: Mon, 29 Aug 2022 10:30:19 -0400
Message-ID: <20220829143026.1509027-23-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1ec7aea-1a4d-4092-2842-08da89cb21d2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5212:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0B8Z7LmlV6c1qI5HOHCoPujlNITFw08LTQZUyyiw/6hZfz7CHvdyoHxjH1uUeKRlH+QJB80eto6rQZIYc7im5k8A8m3E1ap4ThjTVhJW35qL/JDQZ+KTZcYaqkg45c06TkoyEjlLFfb3/FkaQGTM0glddywQQuW9jKsA4MnW+lB1l+jxioyl62m2gvcmRI9YHCVp2jAHf+zSk6A2ep3YHd07lVySHPFI42Am1z5b68ekhGZR4yUbU1I6D2xUhxTp32kmlsnJCQOJp6PHlS02M/G8kWkEWSSpcbXhVtEmml8sKW0pSW59Hak0zmRylSd4dbEJ1lJiLQOcJLGXOFCzODlChFhCPSL01PufdIQ9cvXU7KMlZjrPr7EbjJTkslT91Ql8huyefRj2bfomYvIcrvKQ4pNPitChJx/MKL+22Dcp+kd4C8gk7D4pWBhLIoql9IDuBqg0KCQtMC0b1u5/NnpoDSpBFYCSzDLu1FPiA0mzGy72D9yWVoV2knJPqvGo+DS8YE4m5FhswCAT1Rxup0ahAjN2swPo88pjiz3NRmG8eHwL0UdK6lgITgLOF+/8uXVJWsfxEbuEqCsUjatKCjHa+kBFHKD/oPvxlo9Ek2IPs7XsUOn70hESZg1cygWMG+2FtfTtbJ6DYJhGgCl97MmQlrtidg0wKlckW0pgBvZcBdwBWZGiZHeJKy1LpQby+z9V7ZoHP2XToOBWXdMKA24p/oV/aGU20OQILwb+J735VE3B3neSOpx4LSkFcS5GCQHESeYffAfuVnyt80e7t7qyyOCvuFGUk4veV0UjFpN38pR+WZq/Qji/EqSU1HW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(40470700004)(36840700001)(81166007)(316002)(356005)(26005)(82310400005)(41300700001)(44832011)(82740400003)(8936002)(6666004)(30864003)(40460700003)(5660300002)(478600001)(86362001)(4326008)(8676002)(15650500001)(2906002)(70206006)(54906003)(7696005)(70586007)(40480700001)(47076005)(426003)(2616005)(336012)(1076003)(16526019)(186003)(83380400001)(6916009)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:16.3259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ec7aea-1a4d-4092-2842-08da89cb21d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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

In order to inspect waves from the saved context at any point during a
debug session, the debugger must be able to preempt queues to trigger
context save by suspending them.

On queue suspend, the KFD will copy the context save header information
so that the debugger can correctly crawl the appropriate size of the saved
context. The debugger must then also be allowed to resume suspended queues.

A queue that is newly created cannot be suspended because queue ids are
recycled after destruction so the debugger needs to know that this has
occurred.  Query functions will be later added that will clear a given
queue of its new queue status.

A queue cannot be destroyed while it is suspended to preserve its saved
context during debugger inspection.  Have queue destruction block while
a queue is suspended and unblocked when it is resumed.  Likewise, if a
queue is about to be destroyed, it cannot be suspended.

Return the number of queues successfully suspended or resumed along with
a per queue status array where the upper bits per queue status show that
the request was invalid (new/destroyed queue suspend request, missing
queue) or an error occurred (HWS in a fatal state so it can't suspend or
resume queues).

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  12 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   7 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 401 +++++++++++++++++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  11 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  10 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   5 +-
 7 files changed, 454 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 653287d0f184..40260cecd756 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -404,6 +404,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 	pr_debug("Write ptr address   == 0x%016llX\n",
 			args->write_pointer_address);
 
+	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_NEW), p, dev, queue_id, false, NULL, 0);
 	return 0;
 
 err_create_queue:
@@ -2872,7 +2873,18 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				args->launch_mode.launch_mode);
 		break;
 	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
+		r = suspend_queues(target,
+				args->suspend_queues.num_queues,
+				args->suspend_queues.grace_period,
+				args->suspend_queues.exception_mask,
+				(uint32_t *)args->suspend_queues.queue_array_ptr);
+
+		break;
 	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
+		r = resume_queues(target, false,
+				args->resume_queues.num_queues,
+				(uint32_t *)args->resume_queues.queue_array_ptr);
+		break;
 	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
 	case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
 	case KFD_IOC_DBG_TRAP_SET_FLAGS:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 70008e047c12..14b606a3dff2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -274,6 +274,13 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 
 		count++;
 	}
+
+	if (!unwind) {
+		int resume_count = resume_queues(target, true, 0, NULL);
+
+		if (resume_count)
+			pr_debug("Resumed %d queues\n", resume_count);
+	}
 }
 
 int kfd_dbg_trap_disable(struct kfd_process *target)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index cba9968adcd0..492dd7d9fcff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -919,6 +919,79 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	return retval;
 }
 
+/* suspend_single_queue does not lock the dqm like the
+ * evict_process_queues_cpsch or evict_process_queues_nocpsch. You should
+ * lock the dqm before calling, and unlock after calling.
+ *
+ * The reason we don't lock the dqm is because this function may be
+ * called on multiple queues in a loop, so rather than locking/unlocking
+ * multiple times, we will just keep the dqm locked for all of the calls.
+ */
+static int suspend_single_queue(struct device_queue_manager *dqm,
+				      struct kfd_process_device *pdd,
+				      struct queue *q)
+{
+	bool is_new;
+
+	if (q->properties.is_suspended)
+		return 0;
+
+	pr_debug("Suspending PASID %u queue [%i]\n",
+			pdd->process->pasid,
+			q->properties.queue_id);
+
+	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
+
+	if (is_new || q->properties.is_being_destroyed) {
+		pr_debug("Suspend: skip %s queue id %i\n",
+				is_new ? "new" : "destroyed",
+				q->properties.queue_id);
+		return -EBUSY;
+	}
+
+	q->properties.is_suspended = true;
+	if (q->properties.is_active) {
+		decrement_queue_count(dqm, &pdd->qpd, q);
+		q->properties.is_active = false;
+	}
+
+	return 0;
+}
+
+/* resume_single_queue does not lock the dqm like the functions
+ * restore_process_queues_cpsch or restore_process_queues_nocpsch. You should
+ * lock the dqm before calling, and unlock after calling.
+ *
+ * The reason we don't lock the dqm is because this function may be
+ * called on multiple queues in a loop, so rather than locking/unlocking
+ * multiple times, we will just keep the dqm locked for all of the calls.
+ */
+static void resume_single_queue(struct device_queue_manager *dqm,
+				      struct qcm_process_device *qpd,
+				      struct queue *q)
+{
+	struct kfd_process_device *pdd;
+	uint64_t pd_base;
+
+	if (!q->properties.is_suspended)
+		return;
+
+	pdd = qpd_to_pdd(qpd);
+	/* Retrieve PD base */
+	pd_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
+
+	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
+			    pdd->process->pasid,
+			    q->properties.queue_id);
+
+	q->properties.is_suspended = false;
+
+	if (QUEUE_IS_ACTIVE(q->properties)) {
+		q->properties.is_active = true;
+		increment_queue_count(dqm, qpd, q);
+	}
+}
+
 static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
@@ -1888,6 +1961,31 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
 	return map_queues_cpsch(dqm);
 }
 
+static int wait_on_destroy_queue(struct device_queue_manager *dqm,
+				 struct queue *q)
+{
+	struct kfd_process_device *pdd = kfd_get_process_device_data(q->device,
+								q->process);
+	int ret = 0;
+
+	if (pdd->qpd.is_debug)
+		return ret;
+
+	q->properties.is_being_destroyed = true;
+
+	if (pdd->process->debug_trap_enabled && q->properties.is_suspended) {
+		dqm_unlock(dqm);
+		mutex_unlock(&q->process->mutex);
+		ret = wait_event_interruptible(dqm->destroy_wait,
+						!q->properties.is_suspended);
+
+		mutex_lock(&q->process->mutex);
+		dqm_lock(dqm);
+	}
+
+	return ret;
+}
+
 static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
@@ -1907,11 +2005,16 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				q->properties.queue_id);
 	}
 
-	retval = 0;
-
 	/* remove queue from list to prevent rescheduling after preemption */
 	dqm_lock(dqm);
 
+	retval = wait_on_destroy_queue(dqm, q);
+
+	if (retval) {
+		dqm_unlock(dqm);
+		return retval;
+	}
+
 	if (qpd->is_debug) {
 		/*
 		 * error, currently we do not allow to destroy a queue
@@ -1957,7 +2060,17 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	dqm_unlock(dqm);
 
-	/* Do free_mqd after dqm_unlock(dqm) to avoid circular locking */
+	/*
+	 * Do free_mqd and delete raise event after dqm_unlock(dqm) to avoid
+	 * circular locking
+	 */
+	kfd_dbg_ev_raise(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE),
+			qpd->pqm->process,
+			q->device,
+			-1,
+			false,
+			NULL,
+			0);
 	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
 
 	return retval;
@@ -2421,8 +2534,10 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		goto out_free;
 	}
 
-	if (!dqm->ops.initialize(dqm))
+	if (!dqm->ops.initialize(dqm)) {
+		init_waitqueue_head(&dqm->destroy_wait);
 		return dqm;
+	}
 
 out_free:
 	kfree(dqm);
@@ -2560,6 +2675,284 @@ int release_debug_trap_vmid(struct device_queue_manager *dqm,
 	return r;
 }
 
+#define QUEUE_NOT_FOUND		-1
+/* invalidate queue operation in array */
+static void q_array_invalidate(uint32_t num_queues, uint32_t *queue_ids)
+{
+	int i;
+
+	for (i = 0; i < num_queues; i++)
+		queue_ids[i] |= KFD_DBG_QUEUE_INVALID_MASK;
+}
+
+/* find queue index in array */
+static int q_array_get_index(unsigned int queue_id,
+		uint32_t num_queues,
+		uint32_t *queue_ids)
+{
+	int i;
+
+	for (i = 0; i < num_queues; i++)
+		if (queue_id == (queue_ids[i] & ~KFD_DBG_QUEUE_INVALID_MASK))
+			return i;
+
+	return QUEUE_NOT_FOUND;
+}
+
+struct copy_context_work_handler_workarea {
+	struct work_struct copy_context_work;
+	struct kfd_process *p;
+};
+
+static void copy_context_work_handler (struct work_struct *work)
+{
+	struct copy_context_work_handler_workarea *workarea;
+	struct mqd_manager *mqd_mgr;
+	struct queue *q;
+	struct mm_struct *mm;
+	struct kfd_process *p;
+	uint32_t tmp_ctl_stack_used_size, tmp_save_area_used_size;
+	int i;
+
+	workarea = container_of(work,
+			struct copy_context_work_handler_workarea,
+			copy_context_work);
+
+	p = workarea->p;
+	mm = get_task_mm(p->lead_thread);
+
+	if (!mm)
+		return;
+
+	kthread_use_mm(mm);
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct device_queue_manager *dqm = pdd->dev->dqm;
+		struct qcm_process_device *qpd = &pdd->qpd;
+
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_CP];
+
+			/* We ignore the return value from get_wave_state
+			 * because
+			 * i) right now, it always returns 0, and
+			 * ii) if we hit an error, we would continue to the
+			 *      next queue anyway.
+			 */
+			mqd_mgr->get_wave_state(mqd_mgr,
+					q->mqd,
+					(void __user *)	q->properties.ctx_save_restore_area_address,
+					&tmp_ctl_stack_used_size,
+					&tmp_save_area_used_size);
+		}
+	}
+	kthread_unuse_mm(mm);
+	mmput(mm);
+}
+
+static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
+{
+	size_t array_size = num_queues * sizeof(uint32_t);
+	uint32_t *queue_ids = NULL;
+
+	if (!usr_queue_id_array)
+		return NULL;
+
+	queue_ids = kzalloc(array_size, GFP_KERNEL);
+	if (!queue_ids)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
+		return ERR_PTR(-EFAULT);
+
+	return queue_ids;
+}
+
+int resume_queues(struct kfd_process *p,
+		bool resume_all_queues,
+		uint32_t num_queues,
+		uint32_t *usr_queue_id_array)
+{
+	uint32_t *queue_ids = get_queue_ids(num_queues, usr_queue_id_array);
+	int total_resumed = 0;
+	int i;
+
+	if (!resume_all_queues && IS_ERR(queue_ids))
+		return PTR_ERR(queue_ids);
+
+	/* mask all queues as invalid.  unmask per successful request */
+	if (!resume_all_queues)
+		q_array_invalidate(num_queues, queue_ids);
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct device_queue_manager *dqm = pdd->dev->dqm;
+		struct qcm_process_device *qpd = &pdd->qpd;
+		struct queue *q;
+		int r, per_device_resumed = 0;
+
+		dqm_lock(dqm);
+
+		/* unmask queues that resume or already resumed as valid */
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			int q_idx = QUEUE_NOT_FOUND;
+
+			if (queue_ids)
+				q_idx = q_array_get_index(
+						q->properties.queue_id,
+						num_queues,
+						queue_ids);
+
+			if (resume_all_queues || q_idx != QUEUE_NOT_FOUND) {
+				resume_single_queue(dqm, &pdd->qpd, q);
+				if (queue_ids)
+					queue_ids[q_idx] &=
+						~KFD_DBG_QUEUE_INVALID_MASK;
+				per_device_resumed++;
+			}
+		}
+
+		if (!per_device_resumed) {
+			dqm_unlock(dqm);
+			continue;
+		}
+
+		r = execute_queues_cpsch(dqm,
+					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
+					0,
+					USE_DEFAULT_GRACE_PERIOD);
+		if (r) {
+			pr_err("Failed to resume process queues\n");
+			if (!resume_all_queues) {
+				list_for_each_entry(q, &qpd->queues_list, list) {
+					int q_idx = q_array_get_index(
+							q->properties.queue_id,
+							num_queues,
+							queue_ids);
+
+					/* mask queue as error on resume fail */
+					if (q_idx != QUEUE_NOT_FOUND)
+						queue_ids[q_idx] |=
+							KFD_DBG_QUEUE_ERROR_MASK;
+				}
+			}
+		} else {
+			wake_up_all(&dqm->destroy_wait);
+			total_resumed += per_device_resumed;
+		}
+
+		dqm_unlock(dqm);
+	}
+
+	if (copy_to_user((void __user *)usr_queue_id_array, queue_ids,
+			num_queues * sizeof(uint32_t)))
+		pr_err("copy_to_user failed on queue resume\n");
+
+	kfree(queue_ids);
+
+	return total_resumed;
+}
+
+int suspend_queues(struct kfd_process *p,
+			uint32_t num_queues,
+			uint32_t grace_period,
+			uint64_t exception_clear_mask,
+			uint32_t *usr_queue_id_array)
+{
+	uint32_t *queue_ids = get_queue_ids(num_queues, usr_queue_id_array);
+	int total_suspended = 0;
+	int i;
+
+	if (IS_ERR(queue_ids))
+		return PTR_ERR(queue_ids);
+
+	/* mask all queues as invalid.  umask on successful request */
+	q_array_invalidate(num_queues, queue_ids);
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct device_queue_manager *dqm = pdd->dev->dqm;
+		struct qcm_process_device *qpd = &pdd->qpd;
+		struct queue *q;
+		int r, per_device_suspended = 0;
+
+		mutex_lock(&p->event_mutex);
+		dqm_lock(dqm);
+
+		/* unmask queues that suspend or already suspended */
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			int q_idx = q_array_get_index(q->properties.queue_id,
+							num_queues,
+							queue_ids);
+
+			if (q_idx != QUEUE_NOT_FOUND &&
+					!suspend_single_queue(dqm, pdd, q)) {
+				queue_ids[q_idx] &=
+					~KFD_DBG_QUEUE_INVALID_MASK;
+				per_device_suspended++;
+			}
+		}
+
+		if (!per_device_suspended) {
+			dqm_unlock(dqm);
+			mutex_unlock(&p->event_mutex);
+			continue;
+		}
+
+		r = execute_queues_cpsch(dqm,
+			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
+			grace_period);
+
+		if (r)
+			pr_err("Failed to suspend process queues.\n");
+		else
+			total_suspended += per_device_suspended;
+
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			int q_idx = q_array_get_index(q->properties.queue_id,
+						num_queues, queue_ids);
+
+			if (q_idx == QUEUE_NOT_FOUND)
+				continue;
+
+			/* mask queue as error on suspend fail */
+			if (r)
+				queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
+			else if (exception_clear_mask)
+				q->properties.exception_status &=
+							~exception_clear_mask;
+		}
+
+		dqm_unlock(dqm);
+		mutex_unlock(&p->event_mutex);
+		amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
+	}
+
+	if (total_suspended) {
+		struct copy_context_work_handler_workarea copy_context_worker;
+
+		INIT_WORK_ONSTACK(
+				&copy_context_worker.copy_context_work,
+				copy_context_work_handler);
+
+		copy_context_worker.p = p;
+
+		schedule_work(&copy_context_worker.copy_context_work);
+
+
+		flush_work(&copy_context_worker.copy_context_work);
+		destroy_work_on_stack(&copy_context_worker.copy_context_work);
+	}
+
+	if (copy_to_user((void __user *)usr_queue_id_array, queue_ids,
+			num_queues * sizeof(uint32_t)))
+		pr_err("copy_to_user failed on queue suspend\n");
+
+	kfree(queue_ids);
+
+	return total_suspended;
+}
+
 int debug_lock_and_unmap(struct device_queue_manager *dqm)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index bef3be84c5cc..12643528684c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -259,6 +259,8 @@ struct device_queue_manager {
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
 	uint32_t		wait_times;
+
+	wait_queue_head_t	destroy_wait;
 };
 
 void device_queue_manager_init_cik(
@@ -286,6 +288,15 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
 int release_debug_trap_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
+int suspend_queues(struct kfd_process *p,
+			uint32_t num_queues,
+			uint32_t grace_period,
+			uint64_t exception_clear_mask,
+			uint32_t *usr_queue_id_array);
+int resume_queues(struct kfd_process *p,
+		bool resume_all_queues,
+		uint32_t num_queues,
+		uint32_t *usr_queue_id_array);
 int debug_lock_and_unmap(struct device_queue_manager *dqm);
 int debug_map_and_unlock(struct device_queue_manager *dqm);
 int debug_refresh_runlist(struct device_queue_manager *dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index cb484ace17de..d74862755213 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -237,6 +237,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  u32 *save_area_used_size)
 {
 	struct v10_compute_mqd *m;
+	struct kfd_context_save_area_header header;
 
 	m = get_mqd(mqd);
 
@@ -255,6 +256,15 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	 * accessible to user mode
 	 */
 
+	header.control_stack_size = *ctl_stack_used_size;
+	header.wave_state_size = *save_area_used_size;
+
+	header.wave_state_offset = m->cp_hqd_wg_state_offset;
+	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
+
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
+		return -EFAULT;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 86f1cf090246..f05a2bed655a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -289,6 +289,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 			  u32 *save_area_used_size)
 {
 	struct v9_mqd *m;
+	struct kfd_context_save_area_header header;
 
 	/* Control stack is located one page after MQD. */
 	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
@@ -300,7 +301,18 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
 	*save_area_used_size = m->cp_hqd_wg_state_offset -
 		m->cp_hqd_cntl_stack_size;
 
-	if (copy_to_user(ctl_stack, mqd_ctl_stack, m->cp_hqd_cntl_stack_size))
+	header.control_stack_size = *ctl_stack_used_size;
+	header.wave_state_size = *save_area_used_size;
+
+	header.wave_state_offset = m->cp_hqd_wg_state_offset;
+	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
+
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
+		return -EFAULT;
+
+	if (copy_to_user(ctl_stack + m->cp_hqd_cntl_stack_offset,
+				mqd_ctl_stack + m->cp_hqd_cntl_stack_offset,
+				*ctl_stack_used_size))
 		return -EFAULT;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e50b472460ad..a07bbecc376e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -477,6 +477,8 @@ struct queue_properties {
 	uint32_t doorbell_off;
 	bool is_interop;
 	bool is_evicted;
+	bool is_suspended;
+	bool is_being_destroyed;
 	bool is_active;
 	bool is_gws;
 	/* Not relevant for user mode queues in cp scheduling */
@@ -499,7 +501,8 @@ struct queue_properties {
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
 			    (q).queue_address != 0 &&	\
 			    (q).queue_percent > 0 &&	\
-			    !(q).is_evicted)
+			    !(q).is_evicted &&		\
+			    !(q).is_suspended)
 
 enum mqd_update_flag {
 	UPDATE_FLAG_CU_MASK = 0,
-- 
2.25.1


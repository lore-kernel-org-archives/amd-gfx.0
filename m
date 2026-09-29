Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864C3C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D87610EC84;
	Tue, 29 Sep 2026 03:47:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DPEs437R";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BFF10EC8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNeEgC3O67ardPjdVbJxFyIxfMu8uOGJUmyU1g5GRALD530qwc64tvggt3ljlOP4Q/FElVNUk2WCgYpHPLoNQRnEXCPo517wmvUNhGpmGIG427j4WQ4/Wx+WHLsequG5F+ct62y6uI31y8ibftZPcYLemHF3BC5BNfiFuEhmy+I6tr1IGyDO5/3z49YynUaCZinmjU/P6YKpg9ttzkVIi54Po5zd4t0brbMZ/vDeSmxdl5jbLrHutxMnug3uUcKNNLvnmZ9R2blSl0GkAwYY3RStFP+J4XZchCOX/chN6k31t9iFKuzC/1kEqWz5jnGhWmS4NTYdVpZI0seo+FeXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPd2nZLyna3RBGPvvHwpdNiWw0MNJcHx2qpGDb75x3o=;
 b=qlis1mLYLrtDveDTPJ5ki2pDViVGMSBb3NlJ2Brdegc+gePxs5q32KHfw3FOSvY/MNnS6Vu9rJhtsJnqX7irhFF46dijioCc9FLjZ0DdoKKGUWMRGiBhgxFDo5OtouNeAJKAYTVSTP+TTS2uMJ1GQY1vuB2WUIpBeUS87zx9e0edHwtDXG9qf2qchFvWf8rSvePQTfnPRKuiGixZi9a5kqvSSoR1YgJZuISljHsvVSCr0fugB71ho3Qz4yj2+14b2WSi3CMXMzC8v//Ay3Uk2I49GvYmya1ynCfHdo7slpuxA/g/sZM9r26wiWk7eUD7yxgo6oipCW0rWsj8uBw7ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPd2nZLyna3RBGPvvHwpdNiWw0MNJcHx2qpGDb75x3o=;
 b=DPEs437REs4IjDigUVEGq3qvm9cIYyTyumZLNAMc6IgJeeLgubdRz7GGoXxEeHTz1sQ9R8b6TykdaguWDxIGYVSq0n3FNyuQGsmM0/7p4lTnlPTOhUm+eX9FaBXg9QAMCKf+oq1FQc5GS/HzlKCobkSooSVHPqCANdA3noApyKQ=
Received: from BN9PR03CA0899.namprd03.prod.outlook.com (2603:10b6:408:13c::34)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:19 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::98) by BN9PR03CA0899.outlook.office365.com
 (2603:10b6:408:13c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 03:47:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:16 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 11/14] drm/amdgpu/userq: complete eviction fences after
 hardware reset
Date: Tue, 29 Sep 2026 11:46:47 +0800
Message-ID: <20260929034650.2393125-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd8be2f-2c95-4f78-0fea-08df1ddc5c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|6133799003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Bs821bd4DvbHrryLqNDwiZBJAFJ0IurWSyyXOCKjoK+tabZFYNia+yKnmzwMWCGBMJG4LhTTmq+bMY21pSzaoa8Npc/h3QyC0Ds0iknVscAn+oNN5Q6HwUeg5ThRfleHrtM0RDJHJW29lChSVz72KS9GmUvwrYbgUXT2UPlsan9xcqoSQEFUFHtJOKNo8kuYuEfnuRs+8KC9xfsRACZPzjjsoCMhpZLDQprlCAuvD40KRC99joymh67jjq91zeIwtkgojNbvZW5VdXKm0lHW1btAXbG6sOvJQFOMwIjauJv1viC4lPzSddFc3/uyBJBfJZ83gSnzUQBafWv3SaKJrvobfvaIG+JV54/4B6x3m7KmD3phXIHuBcto1foAZYPG/hSqwGos6HRdGPhsptpbpqE87vjjdtCC+QVFqDgmWTg66WXayO+EAx6uzZNjUEYoobytMoHNUsazY/IXi5F6xyWaiP22YJvF/QUDOeVD1XKy3i+Kz47vvedAM0ye2fztMm53NRnHi5WRPhoUb/lducUrEWmAFkQu4Q9eFCjkNPIY8snLOcVSelhWb4LlFzqG/Z58Sp+woPmC8BZoHyxWl+0NOnbzVv4mgtnSzjrFNXltDz9UvhHbnYHPoaVeAAU8a5LvHideaikYjf0doN11KPjCGrEkP+5s7k6Mv0t/QBnWo0Tq0zfD5V4SzGaU+mOQ7mSQv0ThfTdQEMppF+0fGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(6133799003)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JU6xQ6stB15q6Ng1Hp9AM08TP5Sm7/JnO9kO5uFSyKrZ7cB6EAsc4RGCoZcQt1FfVAzboQoPsaKS/7YyODPmdGgl7ukQT7Yw1AxyoX+rBc+1+lQqqM+g7t+hLdH3PIRgsnrrai//cP6IGOrTp6rAx7GXMnNLSKgDcoZSC9Jeb6MNddvIjj4+vaPaQ2yqpcUDXpVdm2fdR076Cx8xE6f+oy02k9MbxNeNQRw89L8EoxhP0+pBfEbh94xQChrC6TbYlCRQUbN9uQLcnbTaHdwtI0BPaAo10ttcHUZHpgqwpEGot/HaFNoFW4STkciqfs0gNQ8DxXm1OraGIYacd0qdjiTWlgi+2UY4OkwwRmEJL5c7qcb1k9uGgjCBGoFvcYJGTEIRgM9LXvRPanBKjSayIUThSV+m7rnAEtnaRkea4KNvcPNRHoPiLq1CqQvRDOMp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:18.7770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd8be2f-2c95-4f78-0fea-08df1ddc5c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
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

A process eviction fence protects every queue sharing its VM. Completing
it from the per-queue fence helper releases sibling queues' BO dependencies
and allows raw post-reset mapping with an already-signaled eviction fence.

Complete process eviction fences only after a successful device hardware
reset, before resume can allocate BOs. Retire every old queue, then complete
queue fences before acquiring manager mutexes to release the eviction
dependencies. Old queues remain terminal even when VRAM survives; applications
must recreate them. Safe transparent remapping would require a separate context
and VM validation design, including a fresh eviction fence.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 19 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 98 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++
 5 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 83d98c9191b0..74030d588a36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4794,6 +4794,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		return r;
 
 	amdgpu_ras_clear_err_state(adev);
+	amdgpu_userq_reset_complete(adev);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
 	/* some sw clean up VF needs to do before recover */
@@ -5024,6 +5025,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	int i, r;
 
+	amdgpu_userq_pre_reset(adev);
+
 	if (reset_context->reset_req_dev == adev)
 		job = reset_context->job;
 
@@ -5192,10 +5195,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
-				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
-				if (r)
-					goto out;
-
 				drm_client_dev_resume(adev_to_drm(tmp_adev));
 
 				/*
@@ -5306,7 +5305,15 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		}
 	}
 
-	if (!r && amdgpu_ras_intr_triggered()) {
+	if (r)
+		goto out;
+
+	if (!skip_hw_reset && need_full_reset) {
+		list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+			amdgpu_userq_reset_complete(tmp_adev);
+	}
+
+	if (amdgpu_ras_intr_triggered()) {
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			amdgpu_ras_reset_error_count(tmp_adev,
 						     AMDGPU_RAS_BLOCK__MMHUB);
@@ -5536,8 +5543,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
 			amdgpu_ras_suspend(tmp_adev);
 
-		amdgpu_userq_pre_reset(tmp_adev);
-
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index c8016fa55a92..fbc30e85a398 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -250,6 +250,7 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 			       struct amdgpu_reset_context *reset_context)
 {
+	struct amdgpu_device *tmp_adev;
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
@@ -263,6 +264,11 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
+	if (reset_context->reset_device_list) {
+		list_for_each_entry(tmp_adev, reset_context->reset_device_list, reset_list)
+			amdgpu_userq_reset_complete(tmp_adev);
+	}
+
 	return reset_handler->restore_hwcontext(adev->reset_cntl,
 						reset_context);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a745c752f459..2eba234a504e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -150,6 +150,12 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
+	/* A device reset retires queues and completes their fences as a group. */
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		schedule_delayed_work(&queue->hang_detect_work, msecs_to_jiffies(10));
+		return;
+	}
+
 	if (queue->vm && queue->vm->pasid) {
 		ti = amdgpu_vm_get_task_info_pasid(adev, queue->vm->pasid);
 		if (ti) {
@@ -178,6 +184,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 		gpu_reset = true;
 	}
 	amdgpu_vm_put_task_info(ti);
+	up_read(&adev->reset_domain->sem);
 
 	/*
 	 * Don't schedule the work here! Scheduling or queue work from one reset
@@ -372,6 +379,9 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	if (queue->state == AMDGPU_USERQ_STATE_RESET_PENDING)
+		return -EBUSY;
+
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -770,8 +780,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->doorbell_index = index;
 	queue->doorbell_offset = (u32)args->in.doorbell_offset;
 	trace_amdgpu_userq_create_start(queue);
+	/* Publish the MQD and doorbell in the same reset epoch. */
+	down_read(&adev->reset_domain->sem);
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
+		up_read(&adev->reset_domain->sem);
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
 		goto clean_doorbell_bo;
 	}
@@ -781,11 +794,18 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	r = xa_insert_irq(&adev->userq_doorbell_xa, index, queue,
 			  GFP_KERNEL);
+	up_read(&adev->reset_domain->sem);
 	if (r)
 		goto clean_mqd;
 
 map_retry:
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    queue->state == AMDGPU_USERQ_STATE_RESET_PENDING) {
+		r = -ECANCELED;
+		mutex_unlock(&uq_mgr->userq_mutex);
+		goto erase_doorbell;
+	}
 
 	/* don't map the queue if scheduling is halted */
 	if (!adev->userq_halt_for_enforce_isolation ||
@@ -806,7 +826,11 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 			up_read(&adev->reset_domain->sem);
 			goto map_retry;
 		}
-		r = amdgpu_userq_map_helper(queue);
+		if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+		    queue->state == AMDGPU_USERQ_STATE_RESET_PENDING)
+			r = -ECANCELED;
+		else
+			r = amdgpu_userq_map_helper(queue);
 		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
@@ -1582,54 +1606,58 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 	struct amdgpu_usermode_queue *queue;
 	unsigned long queue_id;
 
-	/* TODO: We probably need a new lock for the queue state */
+	lockdep_assert_held_write(&adev->reset_domain->sem);
+
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		if (queue->state == AMDGPU_USERQ_STATE_MAPPED ||
+		    queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
 			trace_amdgpu_userq_state_start(queue);
 			userq_funcs = adev->userq_funcs[queue->queue_type];
 			userq_funcs->unmap(queue);
-			/* just mark all queues as hung at this point.
-			 * if unmap succeeds, we could map again
-			 * in amdgpu_userq_post_reset() if vram is not lost
-			 */
-			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
-			queue->state = AMDGPU_USERQ_STATE_HUNG;
 		}
-		/* Force-complete any pending fence regardless of queue state so
-		 * that eviction/suspend and queue teardown waiters don't block
-		 * forever on a fence that will never signal after the reset.
-		 */
-		amdgpu_userq_fence_driver_force_completion(queue);
+		/* A failed unmap is not proof that hardware access has stopped. */
+		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_RESET_PENDING);
+		queue->state = AMDGPU_USERQ_STATE_RESET_PENDING;
 	}
 }
 
-int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+/* Called after successful hardware reset, before allocations during resume. */
+void amdgpu_userq_reset_complete(struct amdgpu_device *adev)
 {
-	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
-	 * at this point, we should be able to map it again
-	 * and continue if vram is not lost.
-	 */
 	struct amdgpu_usermode_queue *queue;
-	const struct amdgpu_userq_funcs *userq_funcs;
 	unsigned long queue_id;
-	int ret = 0, r;
 
+	if (xa_empty(&adev->userq_doorbell_xa))
+		return;
+
+	lockdep_assert_held_write(&adev->reset_domain->sem);
+
+	/* Release queue-fence waiters before acquiring their manager mutexes. */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
-			trace_amdgpu_userq_state_start(queue);
+		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+		amdgpu_userq_fence_driver_force_completion(queue);
+	}
 
-			userq_funcs = adev->userq_funcs[queue->queue_type];
-			/* Re-map queue */
-			r = userq_funcs->map(queue);
-			if (r) {
-				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
-				ret = r;
-				continue;
-			}
-			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
-			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+	/*
+	 * All queues are now retired. Keep them terminal even if VRAM survived:
+	 * raw remapping would bypass VM validation and eviction-fence rearm.
+	 */
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+		struct amdgpu_fpriv *fpriv = uq_mgr->file->driver_priv;
+		struct dma_fence *fence;
+		bool cookie;
+
+		mutex_lock(&uq_mgr->userq_mutex);
+		cookie = dma_fence_begin_signalling();
+		fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
+		if (!dma_fence_is_signaled(fence)) {
+			dma_fence_set_error(fence, -ECANCELED);
+			dma_fence_signal(fence);
 		}
+		dma_fence_put(fence);
+		dma_fence_end_signalling(cookie);
+		mutex_unlock(&uq_mgr->userq_mutex);
 	}
-
-	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 4dcf6151de6a..d17dbc284688 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -38,6 +38,7 @@ enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_PREEMPTED,
 	AMDGPU_USERQ_STATE_HUNG,
 	AMDGPU_USERQ_STATE_INVALID_VA,
+	AMDGPU_USERQ_STATE_RESET_PENDING,
 };
 
 struct amdgpu_mqd_prop;
@@ -180,7 +181,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
-int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_reset_complete(struct amdgpu_device *adev);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c270635c907b..b9e6753ec4cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -556,11 +556,25 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	/* We are here means UQ is active, make sure the eviction fence is valid */
 	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
 
+	if (!down_read_trylock(&adev->reset_domain->sem)) {
+		r = -EAGAIN;
+		mutex_unlock(&userq_mgr->userq_mutex);
+		goto free_fence;
+	}
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    queue->state == AMDGPU_USERQ_STATE_RESET_PENDING) {
+		r = -ECANCELED;
+		up_read(&adev->reset_domain->sem);
+		mutex_unlock(&userq_mgr->userq_mutex);
+		goto free_fence;
+	}
+
 	/* Create the new fence */
 	amdgpu_userq_fence_init(queue, fence, wptr);
 
 	trace_amdgpu_userq_emit_fence(dev->dev, queue, fence);
 
+	up_read(&adev->reset_domain->sem);
 	mutex_unlock(&userq_mgr->userq_mutex);
 
 	/*
@@ -609,6 +623,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	dma_fence_put(&fence->base);
 
 	drm_exec_fini(&exec);
+	goto put_queue;
+
+free_fence:
+	/* Allocation transferred the external fence-driver references. */
+	amdgpu_userq_fence_put_fence_drv_array(fence);
+	amdgpu_userq_fence_driver_put(fence->fence_drv);
+	kvfree(fence->fence_drv_array);
+	kfree(fence);
 put_queue:
 	amdgpu_userq_put(queue);
 put_gobj_write:
-- 
2.34.1


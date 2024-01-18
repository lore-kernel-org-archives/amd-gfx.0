Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DFC47DAF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 19:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162CF10E8AB;
	Thu, 18 Jan 2024 19:21:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDC110E8AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 19:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur9i+K120DAZ8c6CYPwzjs2GodhmklEV8QQ7gDnh1b68JGLQCUDiPebbFphXWwiPvGyEQaogwJ+R8k74BxdZ/Kabhzh9T2lspaEas0wHG5D3+4OHvKWoBum6phb9jczqrYKroTSK543sypH0dasLGxyWQEGYGL1FhxzQAqv6exKBoLlXQLLtVqD1KQ52DAyPh8wHppHNma+O3F5vWo53cqJBpVpvxQuIY7Umk+CKs6F0FSxCYpuVn2EDfdFlIzSXSgVU4qniJrFVKP+4zB3PQ7xfmayScVFxinhRdadW5e0cYyWwEZTZ86FVpt2SyOKKZpEvP+5duOAAI7RJnN4Mgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtdV9CD73JnQP1dZEwWVEiorTo/kRz5LWrfZFu1Eolg=;
 b=AeeW0y5nihzMiACvQtypYFSRT1ulcKGeOjtdQr5vZDI2TcZe/gKP0Tr6ycbWT4XhjWwQzTNOrGAG4L4s/gLBKI+FmKUO8ntPYoKlo5YmLDiQClR9azRY3oy4fiB3YbWCe2WhXgXlQvE1uOyED+aY7Wpih+ozOZsLiib8XYrO8d3jCl4cvsGnUS2dzAevUdj41M99rYSLfAFdRS/x4D/gDnrdAG8zBKbEw4c1A8PYSGlDpqBLlrPtyOmSMvNLLCyCX2qOaggMkz45qqqV4bNcOyBAH7GhO8vB1WzcLsNqofPJoS3EUyeTbBjF/w/CG7f5ZTnmw3jjDIFHZ9EEJqazSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtdV9CD73JnQP1dZEwWVEiorTo/kRz5LWrfZFu1Eolg=;
 b=uEqUJwwsqLV/r8LRpr3sgFyCZsIot0wCrW3UFwxqWINtE846AL0Mn6pb8Cz5q/9ZdcrMgV52LxOLIJvO1sIBgMy2o2lnQKLOarHhj9o7nKxAaYihiIw0nEADF7svaSFU5y8qhc3jLEU18GhU3GcFjlQWAF+q13pO/oy+j/01wdo=
Received: from DM6PR07CA0069.namprd07.prod.outlook.com (2603:10b6:5:74::46) by
 CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Thu, 18 Jan 2024 19:21:32 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::44) by DM6PR07CA0069.outlook.office365.com
 (2603:10b6:5:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 19:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:21:32 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:21:30 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: change vm->task_info handling
Date: Thu, 18 Jan 2024 20:21:03 +0100
Message-ID: <20240118192104.147-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe9f1d3-08b8-4187-1664-08dc185aadd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhudQIKkDUHoYINMjyVT9NhvUZ0UbG5fiyuADy43N9l3dudBQBLURAetryje6Xi5LLAFAoy9+gxJRLPka21CxnBEtQ4TtBaFlgsF99OCHtD2t4TpedujtfivAw3+xet7OHJfzce8+b/Pi5nx8K3JBbwGCwETfM/2tQ7v9JyF/My/PIjzzArST5jPPtWwPhEOWhEOTj3gnc/2TCbTozxjkqQmlDnyckQ/JXVzV85kpS0Hgw5YlIK4BME3/oIjmW7Mx8uQS4IKKGjRbvpSWSVI+KDVaVBaW8RxQxsmT++pJTmRv9A5TNjuBnjab+uKBdEFvcMGOJbSpI0FYnHvWGOhk9QF1n8IiWQYVS8QVkH1To724LA/y/O1EawYMu5i9ewBuOiWgkeAf9WbsnHPnEyJMU/urQqnGOAw+toiImr4YBlFQTnsuideLh9MoeExHc871WS6skNr0Wkr6dQS1p5/UtnaFvrYnD5iJHtCKysY8V0LEd3pP4koSWcao4D67m2f4bNQOqv/BEy2XX5dlAR5m+Yytf6Mcw0jf6RvIXnYl3Bep+RW9jNYbAZf8nH+lKXhaL9971VHP73yZaYuGI2+54o6z5BESDMFSw4/hLhEO1BFt1qDqsmHFcHZKv8VQAdgCHJyhybsMc5DKU4woQvnmX2Bn2/Li5KgmnFO/ZjGadGJ7g5Z6OLkQlpQ8lA0Z2MJnE1WT8MPqG7ugk8Qxjc8dc9mFxxOIt1n9LPEMSuaSaSBjURXOts6ia7DDWvjwXNfTB4JFbb5D9qnCjLB4hHqvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(1076003)(426003)(16526019)(26005)(6666004)(83380400001)(336012)(86362001)(36756003)(82740400003)(81166007)(44832011)(356005)(4326008)(8676002)(478600001)(2616005)(47076005)(36860700001)(6916009)(2906002)(70206006)(70586007)(54906003)(7696005)(316002)(5660300002)(8936002)(30864003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:21:32.1689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe9f1d3-08b8-4187-1664-08dc185aadd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch changes the handling and lifecycle of vm->task_info object.
The major changes are:
- vm->task_info is a dynamically allocated ptr now, and its uasge is
  reference counted.
- introducing two new helper funcs for task_info lifecycle management
    - amdgpu_vm_get_task_info: reference counts up task_info before
      returning this info
    - amdgpu_vm_put_task_info: reference counts down task_info
- last put to task_info() frees task_info from the vm.

This patch also does logistical changes required for existing usage
of vm->task_info.

V2: Do not block all the prints when task_info not found (Felix)

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 142 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  26 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  30 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  31 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  22 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  26 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  26 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  26 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
 13 files changed, 287 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e61ebdb3f3e..99c736b6e32c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1775,9 +1775,12 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file->driver_priv;
 		struct amdgpu_vm *vm = &fpriv->vm;
+		struct amdgpu_task_info *ti;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, ti->process_name);
+		amdgpu_vm_put_task_info_vm(ti, vm);
 
-		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
-				vm->task_info.pid, vm->task_info.process_name);
 		r = amdgpu_bo_reserve(vm->root.bo, true);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1f357198533f..af23746821b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info ti;
+	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
 	int idx;
 	int r;
@@ -48,7 +48,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-	memset(&ti, 0, sizeof(struct amdgpu_task_info));
+
 	adev->job_hang = true;
 
 	if (amdgpu_gpu_recovery &&
@@ -58,12 +58,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
 	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
-		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
-		  ring->fence_drv.sync_seq);
-	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
-		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
+			  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
+			  ring->fence_drv.sync_seq);
+
+	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
+	if (ti) {
+		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
+			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
+		amdgpu_vm_put_task_info_pasid(ring->adev, ti, job->pasid);
+	}
 
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..bfd7a6067edd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -230,8 +230,16 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 
 	coredump->reset_vram_lost = vram_lost;
 
-	if (reset_context->job && reset_context->job->vm)
-		coredump->reset_task_info = reset_context->job->vm->task_info;
+	if (reset_context->job && reset_context->job->vm) {
+		struct amdgpu_task_info *ti;
+		struct amdgpu_vm *vm = reset_context->job->vm;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		if (ti) {
+			coredump->reset_task_info = *ti;
+			amdgpu_vm_put_task_info_vm(ti, vm);
+		}
+	}
 
 	coredump->adev = adev;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d1b8afd105c9..0c95e10c815d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2347,6 +2347,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	if (vm->task_info)
+		amdgpu_vm_put_task_info_vm(vm->task_info, vm);
+
 	flush_work(&vm->pt_free_work);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -2507,26 +2510,129 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
+static void amdgpu_vm_destroy_task_info(struct kref *kref)
+{
+	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
+
+	kfree(ti);
+}
+
+static inline struct amdgpu_vm *
+amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_vm *vm;
+	unsigned long flags;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+
+	return vm;
+}
+
+/**
+ * amdgpu_vm_put_task_info_pasid - reference down the vm task_info ptr
+ * frees the vm task_info ptr at the last put
+ *
+ * @adev: drm device pointer
+ * @task_info: task_info struct under discussion.
+ * @pasid: pasid of the VM which contains task_info
+ */
+void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
+				   struct amdgpu_task_info *task_info,
+				   u32 pasid)
+{
+	int ret;
+
+	ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
+
+	/* Clean up if object was removed in the last put */
+	if (ret == 1) {
+		struct amdgpu_vm *vm;
+
+		vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
+		if (!vm) {
+			WARN(1, "Invalid PASID %u to put task info\n", pasid);
+			return;
+		}
+
+		vm->task_info = NULL;
+	}
+}
+
+/**
+ * amdgpu_vm_put_task_info_vm - reference down the vm task_info ptr
+ * frees the vm task_info ptr at the last refdown
+ *
+ * @task_info: task_info struct under discussion.
+ * @vm: VM which contains task_info
+ */
+void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info, struct amdgpu_vm *vm)
+{
+	int ret;
+
+	ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
+
+	/* Clean up if object was removed in the last put */
+	if (ret == 1)
+		vm->task_info = NULL;
+}
+
 /**
- * amdgpu_vm_get_task_info - Extracts task info for a PASID.
+ * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
  *
  * @adev: drm device pointer
  * @pasid: PASID identifier for VM
- * @task_info: task_info to fill.
+ *
+ * Returns the respective task_info structure, which must be referenced
+ * down with amdgpu_vm_put_task_info.
  */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			 struct amdgpu_task_info *task_info)
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
 {
 	struct amdgpu_vm *vm;
-	unsigned long flags;
+	struct amdgpu_task_info *ti = NULL;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
+	if (vm) {
+		ti = vm->task_info;
+		kref_get(&vm->task_info->refcount);
+	}
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm)
-		*task_info = vm->task_info;
+	return ti;
+}
 
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+/**
+ * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
+ *
+ * @vm: VM to get info from
+ *
+ * Returns the respective task_info structure, which must be referenced
+ * down with amdgpu_vm_put_task_info.
+ */
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
+{
+	struct amdgpu_task_info *ti = NULL;
+
+	if (vm) {
+		ti = vm->task_info;
+		kref_get(&vm->task_info->refcount);
+	}
+
+	return ti;
+}
+
+static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
+{
+	vm->task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
+	if (!vm->task_info) {
+		DRM_ERROR("OOM while creating task_info space\n");
+		return -ENOMEM;
+	}
+
+	kref_init(&vm->task_info->refcount);
+	return 0;
 }
 
 /**
@@ -2536,17 +2642,23 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
  */
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 {
-	if (vm->task_info.pid)
+	if (!vm->task_info) {
+		if (amdgpu_vm_create_task_info(vm))
+			/* OOM */
+			return;
+	}
+
+	if (vm->task_info->pid == current->pid)
 		return;
 
-	vm->task_info.pid = current->pid;
-	get_task_comm(vm->task_info.task_name, current);
+	vm->task_info->pid = current->pid;
+	get_task_comm(vm->task_info->task_name, current);
 
 	if (current->group_leader->mm != current->mm)
 		return;
 
-	vm->task_info.tgid = current->group_leader->pid;
-	get_task_comm(vm->task_info.process_name, current->group_leader);
+	vm->task_info->tgid = current->group_leader->pid;
+	get_task_comm(vm->task_info->process_name, current->group_leader);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2cd86d2bf73f..c693772f8942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -190,10 +190,11 @@ struct amdgpu_vm_pte_funcs {
 };
 
 struct amdgpu_task_info {
-	char	process_name[TASK_COMM_LEN];
-	char	task_name[TASK_COMM_LEN];
-	pid_t	pid;
-	pid_t	tgid;
+	char		process_name[TASK_COMM_LEN];
+	char		task_name[TASK_COMM_LEN];
+	pid_t		pid;
+	pid_t		tgid;
+	struct kref	refcount;
 };
 
 /**
@@ -356,7 +357,7 @@ struct amdgpu_vm {
 	uint64_t		pd_phys_addr;
 
 	/* Some basic info about the task */
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 
 	/* Store positions of group of BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
@@ -492,8 +493,19 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			     struct amdgpu_task_info *task_info);
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
+
+void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
+				   struct amdgpu_task_info *task_info,
+				   u32 pasid);
+
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
+
+void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info,
+				   struct amdgpu_vm *vm);
+
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..d9e895cb0c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1027,7 +1027,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm->task_info.tgid,
+						    vm->task_info ? vm->task_info->tgid : 0,
 						    vm->immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a5a05c16c10d..e00b2a53b192 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -105,7 +105,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	uint32_t status = 0;
 	u64 addr;
 
@@ -157,18 +157,26 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev,
+			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+			entry->vmid_src ? "mmhub" : "gfxhub",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	} else {
+		dev_err(adev->dev,
+			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, no process info)\n",
+			entry->vmid_src ? "mmhub" : "gfxhub",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid);
+	}
 
-	dev_err(adev->dev,
-		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-		entry->vmid_src ? "mmhub" : "gfxhub",
-		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
-		addr, entry->client_id,
-		soc15_ih_clientid_name[entry->client_id]);
+			addr, entry->client_id,
+			soc15_ih_clientid_name[entry->client_id]);
 
 	if (!amdgpu_sriov_vf(adev))
 		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 23d7b548d13f..3dda6c310729 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -126,19 +126,28 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+		struct amdgpu_task_info *task_info;
+
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		if (task_info) {
+			dev_err(adev->dev,
+				"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+				entry->vmid_src ? "mmhub" : "gfxhub",
+				entry->src_id, entry->ring_id, entry->vmid,
+				entry->pasid, task_info->process_name, task_info->tgid,
+				task_info->task_name, task_info->pid);
+			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+		} else {
+			dev_err(adev->dev,
+				"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, no process info)\n",
+				entry->vmid_src ? "mmhub" : "gfxhub",
+				entry->src_id, entry->ring_id, entry->vmid,
+				entry->pasid);
+		}
 
-		dev_err(adev->dev,
-			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-			entry->vmid_src ? "mmhub" : "gfxhub",
-			entry->src_id, entry->ring_id, entry->vmid,
-			entry->pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
-			addr, entry->client_id);
+				addr, entry->client_id);
+
 		if (!amdgpu_sriov_vf(adev))
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ff4ae73d27ec..aa3887c3bb35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+		struct amdgpu_task_info *task_info;
+
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		if (task_info) {
+			dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
+				entry->src_id, entry->src_data[0], task_info->process_name,
+				task_info->tgid, task_info->task_name, task_info->pid);
+			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+		} else {
+			dev_err(adev->dev, "GPU fault detected: %d 0x%08x (no process info)\n",
+				entry->src_id, entry->src_data[0]);
+		}
 
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
-			entry->src_id, entry->src_data[0], task_info.process_name,
-			task_info.tgid, task_info.task_name, task_info.pid);
 		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
-			addr);
+				addr);
 		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
 			status);
+
 		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry->pasid);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2ac5820e9c92..075d633109e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
 	uint32_t status = 0, cid = 0, rw = 0;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
@@ -626,15 +626,23 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev,
+			"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+			hub_name, retry_fault ? "retry" : "no-retry",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	} else {
+		dev_err(adev->dev,
+			"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, no process info)\n",
+			hub_name, retry_fault ? "retry" : "no-retry",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid);
+	}
 
-	dev_err(adev->dev,
-		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-		hub_name, retry_fault ? "retry" : "no-retry",
-		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3d68dd5523c6..515d1a1ff141 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
@@ -2116,15 +2116,23 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev->dev,
+			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+			"pasid:%u, for process %s pid %d thread %s pid %d\n",
+			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	} else {
+		dev_dbg_ratelimited(adev->dev,
+			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+			"pasid:%u, no process info\n",
+			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid);
+	}
 
-	dev_dbg_ratelimited(adev->dev,
-		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
-		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
-		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
-		   entry->pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0f24af6f2810..d7e23bd90f7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
@@ -1654,15 +1654,23 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev->dev,
+			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+			"pasid:%u, for process %s pid %d thread %s pid %d\n",
+			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	} else {
+		dev_dbg_ratelimited(adev->dev,
+			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+			"pasid:%u (no process info)\n",
+			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid);
+	}
 
-	dev_dbg_ratelimited(adev->dev,
-		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
-		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
-		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
-		   entry->pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d9953c2b2661..0dfe4b3bd18a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -238,16 +238,16 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 {
-	struct amdgpu_task_info task_info;
-
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
-	/* Report VM faults from user applications, not retry from kernel */
-	if (!task_info.pid)
-		return;
-
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
-			  task_info.pid, task_info.task_name);
+	struct amdgpu_task_info *task_info;
+
+	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
+	if (task_info) {
+		/* Report VM faults from user applications, not retry from kernel */
+		if (task_info->pid)
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
+					 task_info->pid, task_info->task_name);
+		amdgpu_vm_put_task_info_pasid(dev->adev, task_info, pasid);
+	}
 }
 
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
-- 
2.43.0


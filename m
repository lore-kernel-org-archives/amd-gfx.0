Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF75CDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 17:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E7010E1C7;
	Mon, 16 Oct 2023 17:09:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB0210E1C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 17:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcB2TD/FAXyn0kGvKgduXW23UOtlf4GaNDqbp1gu0QWP9JQhO0WA9b9lI79n25saOlokAsJvg2UqU2FGWRt+6dzV23bgTzLLCFvfc7NpJWhw/cwz9POZ6kQvrhdLVGDPuWhJvyUZmWS57z7+9qwxtHVcfR+Ci31I6KLHyJZcdCotIFwZYXRy0qgpbiRv1QyHh2wIQcnV0ufi4fgiHee9LJyHKo9wDPbd2ucUBd7ToYIjsTox6KiqNXItezDqfen2JRFeM2SSrF+6RHQA13IxGL+EPtz5L7h1MjHiqxWugVhBNWqHgNT1QPZF+RGEt5VIkDJeHVncJbVZcjhcI01JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhDfUoRRjHO9wro/O73pWe0Q09lpJtV8LpN66zIYWR8=;
 b=R+NsQN7NHoDvFJdWBHBR/wIjs+rnoxj7rqU786XpHdymkZKO9puh9Ph6yV/z+rru7M427NNMfyNnh0MfgwOqDIoqePg3Cqi61Y8NXlnEcIy71DbMehhF+RcqD3TSG+8+9aLdINr+SiF2LYA/5sPS7JexcWWKIfyRfYbakX6A/wheKWPJTl4XTqGsxANrO3OWT/Nzgx8pfLxkqtQ6ZraVCQvn315KQAhn/tS3X8zjrxeD2HxlRbdMXh6QOH6KtWugRV3YnIly4nqaK7kfKQY6JQKejsTg3y6HR7SBYlc8xtLQBnWLKj1pa84Zb8bhxzVhRCIemX4n9rjQtNwAa+G+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhDfUoRRjHO9wro/O73pWe0Q09lpJtV8LpN66zIYWR8=;
 b=QZ/LpY3X3Prx2nOS3uNubnT6aWwAuzdpOsLaINRitzALGIlp86IOTA7cc30b+gi2OWs3M3ekN5kkouQBmDETO5uiTTpKFYi66xLTCcOpxmPCsPrezKx4RX7NarfyhwxCrFg1nXk+bvdESS4bWZ+PcX2HQHZUA/tKuf7LmCUiqqA=
Received: from BL1PR13CA0084.namprd13.prod.outlook.com (2603:10b6:208:2b8::29)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 17:08:56 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::3a) by BL1PR13CA0084.outlook.office365.com
 (2603:10b6:208:2b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Mon, 16 Oct 2023 17:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 17:08:55 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 12:08:53 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move task_info to amdgpu_fpriv
Date: Mon, 16 Oct 2023 19:08:20 +0200
Message-ID: <20231016170820.979-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 55587f62-05a6-49da-4e9e-08dbce6a949a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NHT8G6Csh+11GSxt8DwmnY+DbVnshmti87rdtgjAjPyny1V3aUo+Gl6GJsjTS7dkGK59o8lIgUZz3Q8PsgJ3PTdl4fqou8V+h3ayU+yZWle6duE6pDWlkH05g5IuPb2L68nTH3JkplNV0qsWXd3n83BwIY16jGcL26vSOfldJK1GmG+V0Hsmg1MNILEEjW+mrlsDT1L+dJBE4PJ2A3j1R1tlLzN3vSat7l/wxcu4ES1pU+OlXTmHU6v+pN/EgOaaMaKalgR7QX0feMCFVZJoVI8Kma+75tqwbCxnT/1rBXElLzv6MipHE1j4HPxOQG1YhpWwg0Cezt3KLCsMMLcI+sZ7XIqbMAdKYgqeAG4+IJjUg/zSRVYy4kmXQTjwGGwRnM3IIxmbKyRWXuCtGMCbjZzI3RIktZ2ZRUFf3fhGieZQFXw5DSw3gn0Pm8oz4lfE5kIbDQFhIA9/VJho7o24SmewR8W7wUpFSE5iajTZqVl7Br/QjikfhOj7vbJp+6PSIZk1qzjCzhZRs824SLIytjiW4sWb3ekE1eyr7FqfbI+L4OjsOIxUhLWWEC34b02anPkKHp0qeuSMmsUuqSPeCjKZ/lzc3TXR5zvb+Fn//69FAfVd+0YO0kzW+qZGjGJ9G/GUbJUDdfJDtGBEP05xqrYEAclIh1nxaygbLTld5Q/Hg3cA9UNa6e7kEq5tdObmsjTdDYyza418SEtx8ivqZIQIZuI+DHRYxcTLt98JwWAyOI4WMRPa+2+vJ5hTIrMtWkfF+o+uGNJcuVIe9wUkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(30864003)(6916009)(478600001)(6666004)(54906003)(70206006)(70586007)(1076003)(26005)(16526019)(336012)(426003)(2616005)(7696005)(316002)(8936002)(4326008)(8676002)(2906002)(5660300002)(41300700001)(44832011)(36756003)(86362001)(81166007)(356005)(47076005)(36860700001)(83380400001)(82740400003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 17:08:55.7740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55587f62-05a6-49da-4e9e-08dbce6a949a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch does the following:
- moves vm->task_info struct to fpriv->task_info.
- makes task_info allocation dynamic.
- adds reference counting support for task_info structure.
- adds some new helper functions to find and put task_info.
- adds respective supporting changes for existing get_task_info consumers.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 16 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 87 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 19 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 18 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 17 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 19 +++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      | 19 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    | 20 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 14 ++--
 14 files changed, 186 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc2d53081e80..a90780d38725 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -469,6 +469,8 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	struct amdgpu_task_info *task_info;
+
 	/** GPU partition selection */
 	uint32_t		xcp_id;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a4faea4fa0b5..6e9dcd13ee34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1763,9 +1763,11 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file->driver_priv;
 		struct amdgpu_vm *vm = &fpriv->vm;
+		struct amdgpu_task_info *task_info = fpriv->task_info;
 
 		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
-				vm->task_info.pid, vm->task_info.process_name);
+				task_info ? task_info->pid : 0,
+				task_info ? task_info->process_name : "");
 		r = amdgpu_bo_reserve(vm->root.bo, true);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3f001a50b34a..b372a87b9b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4872,6 +4872,27 @@ static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
 	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
 }
+
+static void
+amdgpu_reset_dev_coredump(struct amdgpu_device *adev, struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_task_info *ti;
+	struct amdgpu_vm *vm;
+
+	if (!reset_context->job || !reset_context->job->vm)
+		return;
+
+	vm = reset_context->job->vm;
+
+	/* Get reset task info and save a copy of data to be consumed later */
+	ti = amdgpu_vm_get_task_info(adev, vm->pasid);
+	if (ti) {
+		adev->reset_task_info = *ti;
+		amdgpu_reset_capture_coredumpm(adev);
+	}
+
+	amdgpu_vm_put_task_info(adev, vm->pasid);
+}
 #endif
 
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
@@ -4976,12 +4997,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 #ifdef CONFIG_DEV_COREDUMP
 				tmp_adev->reset_vram_lost = vram_lost;
-				memset(&tmp_adev->reset_task_info, 0,
-						sizeof(tmp_adev->reset_task_info));
-				if (reset_context->job && reset_context->job->vm)
-					tmp_adev->reset_task_info =
-						reset_context->job->vm->task_info;
-				amdgpu_reset_capture_coredumpm(tmp_adev);
+				amdgpu_reset_dev_coredump(tmp_adev, reset_context);
 #endif
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 78476bc75b4e..99cf30c0bce6 100644
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
@@ -48,7 +48,6 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-	memset(&ti, 0, sizeof(struct amdgpu_task_info));
 	adev->job_hang = true;
 
 	if (amdgpu_gpu_recovery &&
@@ -58,12 +57,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
 	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
-		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
-		  ring->fence_drv.sync_seq);
-	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
-		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
+		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
+		   ring->fence_drv.sync_seq);
+
+	ti = amdgpu_vm_get_task_info(ring->adev, job->pasid);
+	if (ti)
+		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
+			   ti->process_name, ti->tgid, ti->task_name, ti->pid);
+	amdgpu_vm_put_task_info(ring->adev, job->pasid);
 
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f5daadcec865..aabfbb8edb2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2335,6 +2335,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
+	amdgpu_vm_put_task_info(adev, vm->pasid);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2491,26 +2492,44 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
+static struct
+amdgpu_task_info *amdgpu_vm_find_task_info(struct amdgpu_device *adev, u32 pasid)
+{
+	unsigned long flags;
+	struct amdgpu_vm *vm;
+	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_task_info *task_info = NULL;
+
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	if (vm) {
+		fpriv = container_of(vm, struct amdgpu_fpriv, vm);
+		task_info = fpriv->task_info;
+	}
+
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	return task_info;
+}
+
 /**
  * amdgpu_vm_get_task_info - Extracts task info for a PASID.
  *
  * @adev: drm device pointer
  * @pasid: PASID identifier for VM
- * @task_info: task_info to fill.
+ *
+ * returns the task_info* (refrence counted) set under the vm_pasid
+ * user must call amdgpu_vm_put_task_info when done with the task_info ptr
  */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			 struct amdgpu_task_info *task_info)
+struct amdgpu_task_info *amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid)
 {
-	struct amdgpu_vm *vm;
-	unsigned long flags;
-
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	struct amdgpu_task_info *ti;
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm)
-		*task_info = vm->task_info;
+	ti = amdgpu_vm_find_task_info(adev, pasid);
+	if (ti)
+		kref_get(&ti->refcount);
 
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	return ti;
 }
 
 /**
@@ -2520,17 +2539,49 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
  */
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 {
-	if (vm->task_info.pid)
-		return;
+	struct amdgpu_fpriv *fpriv = container_of(vm, struct amdgpu_fpriv, vm);
+	struct amdgpu_task_info *task_info;
 
-	vm->task_info.pid = current->pid;
-	get_task_comm(vm->task_info.task_name, current);
+	if (fpriv->task_info)
+		return;
 
-	if (current->group_leader->mm != current->mm)
+	task_info = kzalloc(sizeof(*task_info), GFP_KERNEL);
+	if (!task_info) {
+		DRM_ERROR("OOM while task_info creation\n");
 		return;
+	}
+
+	kref_init(&task_info->refcount);
+	task_info->pid = current->pid;
+	get_task_comm(task_info->task_name, current);
+
+	if (current->group_leader->mm != current->mm) {
+		task_info->tgid = current->group_leader->pid;
+		get_task_comm(task_info->process_name, current->group_leader);
+	}
+
+	kref_get(&task_info->refcount);
+	fpriv->task_info = task_info;
+}
+
+static void amdgpu_vm_free_task_info(struct kref *kref)
+{
+	kfree(container_of(kref, struct amdgpu_task_info, refcount));
+}
+
+/**
+ * amdgpu_vm_put_task_info - reference down the task_info ptr.
+ *
+ * @adev: drm device pointer
+ * @pasid: PASID identifier for VM
+ */
+void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_task_info *ti;
 
-	vm->task_info.tgid = current->group_leader->pid;
-	get_task_comm(vm->task_info.process_name, current->group_leader);
+	ti = amdgpu_vm_find_task_info(adev, pasid);
+	if (ti)
+		kref_put(&ti->refcount, amdgpu_vm_free_task_info);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 204ab13184ed..40a8c532a5ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -187,6 +187,7 @@ struct amdgpu_task_info {
 	char	task_name[TASK_COMM_LEN];
 	pid_t	pid;
 	pid_t	tgid;
+	struct kref refcount;
 };
 
 /**
@@ -333,9 +334,6 @@ struct amdgpu_vm {
 	/* Valid while the PD is reserved or fenced */
 	uint64_t		pd_phys_addr;
 
-	/* Some basic info about the task */
-	struct amdgpu_task_info task_info;
-
 	/* Store positions of group of BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
@@ -466,8 +464,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			     struct amdgpu_task_info *task_info);
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid);
+void amdgpu_vm_put_task_info(struct amdgpu_device *adev, u32 pasid);
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 96d601e209b8..3d7a9ad963a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1023,21 +1023,24 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			uint64_t upd_end = min(entry_end, frag_end);
 			unsigned int nptes = (upd_end - frag_start) >> shift;
 			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
+			struct amdgpu_task_info *task_info;
 
 			/* This can happen when we set higher level PDs to
 			 * silent to stop fault floods.
 			 */
 			nptes = max(nptes, 1u);
 
+			task_info = amdgpu_vm_get_task_info(adev, vm->pasid);
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm->task_info.tgid,
+						    task_info ? task_info->tgid : 0,
 						    vm->immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
 						   nptes, incr, upd_flags);
 
+			amdgpu_vm_put_task_info(adev, vm->pasid);
 			pe_start += nptes * 8;
 			dst += nptes * incr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fa87a85e1017..14ded13c8b09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	uint32_t status = 0;
 	u64 addr;
 
@@ -155,15 +155,18 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
-	dev_err(adev->dev,
-		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+	dev_err(adev->dev, "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 		entry->vmid_src ? "mmhub" : "gfxhub",
 		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
+	if (task_info)
+		dev_err(adev->dev, "for process %s pid %d thread %s pid %d\n",
+				   task_info->process_name, task_info->tgid,
+				   task_info->task_name, task_info->pid);
+	amdgpu_vm_put_task_info(adev, entry->pasid);
+
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e3b76fd28d15..2d96567171bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -120,17 +120,21 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+		struct amdgpu_task_info *task_info;
 
 		dev_err(adev->dev,
-			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 			entry->vmid_src ? "mmhub" : "gfxhub",
 			entry->src_id, entry->ring_id, entry->vmid,
-			entry->pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
+			entry->pasid);
+
+		task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
+		if (task_info)
+			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
+				task_info->process_name, task_info->tgid,
+				task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info(adev, entry->pasid);
+
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 			addr, entry->client_id);
 		if (!amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 5af235202513..8759ef1c5ea5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1446,14 +1446,19 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
+		struct amdgpu_task_info *task_info;
 
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+			entry->src_id, entry->src_data[0]);
+
+		task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
+		if (task_info) {
+			dev_err(adev->dev, "for process %s pid %d thread %s pid %d\n\n",
+				task_info->process_name, task_info->tgid,
+				task_info->task_name, task_info->pid);
+		}
+		amdgpu_vm_put_task_info(adev, entry->pasid);
 
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
-			entry->src_id, entry->src_data[0], task_info.process_name,
-			task_info.tgid, task_info.task_name, task_info.pid);
 		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
 			addr);
 		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f9a5a2c0573e..75b849d69875 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	bool retry_fault = !!(entry->src_data[1] & 0x80);
 	bool write_fault = !!(entry->src_data[1] & 0x20);
 	uint32_t status = 0, cid = 0, rw = 0;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
@@ -625,16 +625,19 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
 	dev_err(adev->dev,
-		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 		hub_name, retry_fault ? "retry" : "no-retry",
 		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
+	if (task_info)
+		dev_err(adev->dev, " process %s pid %d thread %s pid %d\n",
+			task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+	amdgpu_vm_put_task_info(adev, entry->pasid);
+
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index cd37f45e01a1..d3b9fe74332a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
@@ -2124,15 +2124,16 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
 	dev_dbg_ratelimited(adev->dev,
-		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
-		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
-		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
-		   entry->pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
+		   instance, addr, entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
+	if (task_info)
+		dev_dbg_ratelimited(adev->dev, "for process %s pid %d thread %s pid %d\n",
+				    task_info->process_name, task_info->tgid,
+				    task_info->task_name, task_info->pid);
+	amdgpu_vm_put_task_info(adev, entry->pasid);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index f413898dda37..56c2f744d64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
@@ -1645,15 +1645,17 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
 	dev_dbg_ratelimited(adev->dev,
-		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
-		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
-		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
-		   entry->pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
+		   instance, addr, entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info(adev, entry->pasid);
+	if (task_info)
+		dev_dbg_ratelimited(adev->dev, "for process %s pid %d thread %s pid %d\n",
+				    task_info->process_name, task_info->tgid,
+				    task_info->task_name, task_info->pid);
+	amdgpu_vm_put_task_info(adev, entry->pasid);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d9953c2b2661..6b51262811f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -238,16 +238,18 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 {
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
 	/* Report VM faults from user applications, not retry from kernel */
-	if (!task_info.pid)
-		return;
+	task_info = amdgpu_vm_get_task_info(dev->adev, pasid);
+	if (!task_info || !task_info->pid)
+		goto unref;
 
 	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
-			  task_info.pid, task_info.task_name);
+			  task_info->pid, task_info->task_name);
+
+unref:
+	amdgpu_vm_put_task_info(dev->adev, pasid);
 }
 
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
-- 
2.42.0


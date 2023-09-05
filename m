Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE04C83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 15:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D6510E07B;
	Tue,  5 Sep 2023 15:37:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D73410E191
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 15:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwUo9MabrV22oHA9bcQhixhN/VUvAUYI7i41+vDDSfP9JpU+/rNLMAGpKP//4Q9qtOtfTRxQK1BbkQXXskuTep2L2OWxs9Y5W73nJ4kRrHJgfzRchb/M0pKjibm+U3xmuM2U6o07njN04B3PG6tKH8TmWjzJCy2q+34t7eOTBZOAMLfxS1Z8TrDurx10c8RjUp9TduL1zwaJj6MuHuMeZTqKs4b9OYEfdV+mlQJJhr+ynBSZ0CxBeIlWroCBxf0zr5y3i1kg/1K0o+djtzmEiCWIHU9ms/pLFWBYxeepLVbWXmE2eP/TE/hW/3W5Sai/qoKeDS5AFyaFjIVQEX6Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ3blVH3rUhi9zSmEs/FhS4IWV0qZcnQOprXqYjVBkg=;
 b=mPiy3QWSqc5mmeY7KIXXaXEUOeTU4psABUNkG5zaiQp7gNqx66tNupEhSwRCNSfvij/YCyWyosbuTz9JbNMP7LoHCaSpDE2H7aIqje/m1kUHQfyrJQoeyGVXzwTuoR8gI3DThd2+BTkwqpus5iSamG2pZk1syHIr8JtRM/GdtoNZx+G6xkKn7AqyG2ORICqlHiQ3xQsyJQjXzYldyR8p4dBJY4SO0zIe0QqH+5naxTsjBxcJvdTq6csnNYlfIehRtTQzWKWbXh2vXRwnxR1egOdrxLlYJVfhQi8aGrz1Bh4fhtQsDsYOf5nJMhvn++WYn0XdtD6X5MlH6ZSEeP1woQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ3blVH3rUhi9zSmEs/FhS4IWV0qZcnQOprXqYjVBkg=;
 b=Tz+G2HVp6ufgEbFs52GAMeOUAnTp947GDZbZ3kGwXLBD0F5SR05IXhkBd9CGtalUnnID94GFfhuev8cAYPr5fY3w38j/G6ygybRZBBCe/NG2+PoRqhYnAt8ZLMOgesUrW21L0rh1uSZcDApAjdy81THPfaC2F5jEor4vn2yub2M=
Received: from CY5P221CA0049.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::28) by
 CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.33; Tue, 5 Sep 2023 15:36:58 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::84) by CY5P221CA0049.outlook.office365.com
 (2603:10b6:930:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 15:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 15:36:58 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 10:36:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move task_info out of amdgpu_vm
Date: Tue, 5 Sep 2023 17:36:36 +0200
Message-ID: <20230905153636.2107-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CH0PR12MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b2b38b-2d12-4e90-bd01-08dbae25f122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gNcl3ZnNaFv7vVYfbdBWesp73FH7iwQY7sZt37VD/jh4CUk0KJBypxese0Ked4wodmeV+oDXM5L0NOkIp7/mLOIpWq6+udjmgZ5CQue/+UEPYY9LsksbxfxLWfC37JrqiZxSqAmMFgS3Ny9WYUsrQWTsWGBmy2D3XavJ+Efgvlzz+S/XgXpjohZVFiHestUnW27BONv6zL0dLDhragV6SiPPfsYpWFr/SvmtaWR7k674R76w3BWHg+3XoTxm2D4oDNQaJdfvkrAFqEcszjkI2j3e2ZHTF3ruEx8cTnrfXp4vcesr06C4sr5MFpmIdDdamFzsFBZslgQGyF0CpnuzWYR9SFK9I9c99bcyTHQ8zYkksZwgpUUcAOVb2nJB8MHkC6RWo3y4/2MCBxjMA7iaJL7VPW7/aM6Vl2FsH1lFEebi1MuEgB9S9rb10gKinems/Ca4d9PObJy3wYX+E2hJE0Z1v17jhgTv2ZBJap9j1Er4ZOf8lbPkJiNQxYtWwuVqSiz/4ceDNsOdMY4+RdJt1IBu2Zngsuu4ec7v2eQdpMlefyr8rslxoH/hBM2Q7+1sXoeNpnhHIunnCFHEp/DVpxmR0+FiO4Ud2ExUtKXErESoPER6734casNFii6nA+OVrNYaCjbT20vWTQPFg4L/5PloeOi87lEa2vURPUhu61LYEua0/s22rRhX9Yj/rsO7fpkN1Q0vEC6j1OaRuLSPqW+N+NwBYjnCwVzVVYgymHpaBcLY1QFd+f44+uElzZKOXfVVKh6oCLQFTqc/rbhnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(186009)(451199024)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(70586007)(54906003)(70206006)(6916009)(44832011)(40480700001)(7696005)(316002)(41300700001)(478600001)(4326008)(8676002)(1076003)(40460700003)(2616005)(26005)(16526019)(5660300002)(36756003)(36860700001)(82740400003)(356005)(81166007)(426003)(336012)(2906002)(8936002)(86362001)(47076005)(83380400001)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:36:58.4572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b2b38b-2d12-4e90-bd01-08dbae25f122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It has been observed that task_info struct makes it difficult to
handle amdgpu_vm during a GPU reset, due to it's parameters like
task_name and process name.

This patch:
- removes task_info struct from amdgpu_vm and moves it into vm_mgr
  as an Xarray.
- creates a PID vs task_info mapping to index task_info from this
  Xarray (similar to how it is being done for PASID to vm indexing).
- adds additional changes to support these changes.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 64 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 12 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  4 +-
 9 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d34c3ef8f3ed..8568ced570c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1539,7 +1539,7 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	amdgpu_vm_set_task_info(avm);
+	amdgpu_vm_set_task_info(adev, avm);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index fb78a8f47587..24b9a841db54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -316,7 +316,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	kvfree(chunk_array);
 
 	/* Use this opportunity to fill in task info for the vm */
-	amdgpu_vm_set_task_info(vm);
+	amdgpu_vm_set_task_info(p->adev, vm);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 56e89e76ff17..cd8aef1135e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1762,9 +1762,10 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file->driver_priv;
 		struct amdgpu_vm *vm = &fpriv->vm;
+		struct amdgpu_task_info ti = {0, };
 
-		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
-				vm->task_info.pid, vm->task_info.process_name);
+		amdgpu_vm_get_task_info(adev, vm->pasid, &ti);
+		seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti.pid, ti.process_name);
 		r = amdgpu_bo_reserve(vm->root.bo, true);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6238701cde23..44fb16eba749 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5192,8 +5192,9 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				memset(&tmp_adev->reset_task_info, 0,
 						sizeof(tmp_adev->reset_task_info));
 				if (reset_context->job && reset_context->job->vm)
-					tmp_adev->reset_task_info =
-						reset_context->job->vm->task_info;
+					amdgpu_vm_get_task_info(tmp_adev,
+							    reset_context->job->vm->pasid,
+								&tmp_adev->reset_task_info);
 				amdgpu_reset_capture_coredumpm(tmp_adev);
 #endif
 				if (vram_lost) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 78476bc75b4e..3985b9b10b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -58,7 +58,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
+	amdgpu_vm_get_task_info(ring->adev, job->vm->pasid, &ti);
 	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
 		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
 		  ring->fence_drv.sync_seq);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 12414a713256..cb3bde5ce682 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1329,8 +1329,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
-	if (pasid)
+	if (pasid) {
+		amdgpu_vm_free_task_info(adev, fpriv->vm.pid);
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
+	}
 	amdgpu_bo_unref(&pd);
 
 	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ec1ec08d4058..95bea7690bb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -161,7 +161,6 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		vm->pasid = pasid;
 	}
 
-
 	return 0;
 }
 
@@ -2439,6 +2438,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #endif
 
 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	xa_init_flags(&adev->vm_manager.tasks, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -2453,6 +2453,9 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
 	xa_destroy(&adev->vm_manager.pasids);
 
+	WARN_ON(!xa_empty(&adev->vm_manager.tasks));
+	xa_destroy(&adev->vm_manager.tasks);
+
 	amdgpu_vmid_mgr_fini(adev);
 }
 
@@ -2498,6 +2501,20 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
+/**
+ * amdgpu_vm_free_task_info - Finds and frees task_info ptr
+ *
+ * @adev: drm device pointer
+ * @pid: pid of the process in vm
+ */
+void amdgpu_vm_free_task_info(struct amdgpu_device *adev, u32 pid)
+{
+	struct amdgpu_task_info *task_info;
+
+	task_info = xa_load(&adev->vm_manager.tasks, pid);
+	kfree(task_info);
+}
+
 /**
  * amdgpu_vm_get_task_info - Extracts task info for a PASID.
  *
@@ -2508,14 +2525,18 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			 struct amdgpu_task_info *task_info)
 {
+	struct amdgpu_task_info *ti;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
 	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm)
-		*task_info = vm->task_info;
+	if (vm) {
+		ti = xa_load(&adev->vm_manager.tasks, vm->pid);
+		if (ti)
+			*task_info = *ti;
+	}
 
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
 }
@@ -2523,21 +2544,44 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 /**
  * amdgpu_vm_set_task_info - Sets VMs task info.
  *
+ * @adev: drm device pointer
  * @vm: vm for which to set the info
  */
-void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
+void amdgpu_vm_set_task_info(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	if (vm->task_info.pid)
+	struct amdgpu_task_info *task_info, *old;
+
+	if (!vm->pasid)
 		return;
 
-	vm->task_info.pid = current->pid;
-	get_task_comm(vm->task_info.task_name, current);
+	if (vm->pid == current->pid)
+		return;
 
-	if (current->group_leader->mm != current->mm)
+	task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
+	if (!task_info) {
+		DRM_ERROR("OOM while setting task info\n");
 		return;
+	}
+
+	task_info->pid = current->pid;
+	get_task_comm(task_info->task_name, current);
+
+	if (current->group_leader->mm == current->mm) {
+		task_info->tgid = current->group_leader->pid;
+		get_task_comm(task_info->process_name, current->group_leader);
+	}
+
+	/* Replace and free if there is an existing task_info entry */
+	old = xa_store_irq(&adev->vm_manager.tasks, task_info->pid, task_info, GFP_KERNEL);
+	if (xa_err(old) < 0) {
+		DRM_WARN("Failed to update task info, pid=0x%x pasid=0x%x\n",
+			  task_info->pid, vm->pasid);
+		kfree(task_info);
+		return;
+	}
 
-	vm->task_info.tgid = current->group_leader->pid;
-	get_task_comm(vm->task_info.process_name, current->group_leader);
+	kfree(old);
+	vm->pid = task_info->pid;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ffac7413c657..33f333d864b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -302,6 +302,7 @@ struct amdgpu_vm {
 	struct dma_fence	*last_unlocked;
 
 	unsigned int		pasid;
+	unsigned int		pid;
 	bool			reserved_vmid[AMDGPU_MAX_VMHUBS];
 
 	/* Flag to indicate if VM tables are updated by CPU or GPU (SDMA) */
@@ -325,9 +326,6 @@ struct amdgpu_vm {
 	/* Valid while the PD is reserved or fenced */
 	uint64_t		pd_phys_addr;
 
-	/* Some basic info about the task */
-	struct amdgpu_task_info task_info;
-
 	/* Store positions of group of BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
@@ -374,6 +372,11 @@ struct amdgpu_vm_manager {
 	 * look up VM of a page fault
 	 */
 	struct xarray				pasids;
+
+	/* PID to task_info mapping, will be used in reset context to
+	 * look up PID/TID of a reset
+	 */
+	struct xarray				tasks;
 };
 
 struct amdgpu_bo_va_mapping;
@@ -465,7 +468,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
 
-void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
+void amdgpu_vm_set_task_info(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+void amdgpu_vm_free_task_info(struct amdgpu_device *adev, u32 pid);
 
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 5431332bbdb8..3704556210d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -992,16 +992,18 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			uint64_t upd_end = min(entry_end, frag_end);
 			unsigned int nptes = (upd_end - frag_start) >> shift;
 			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
+			struct amdgpu_task_info ti = {0, };
 
 			/* This can happen when we set higher level PDs to
 			 * silent to stop fault floods.
 			 */
 			nptes = max(nptes, 1u);
+			amdgpu_vm_get_task_info(adev, vm->pasid, &ti);
 
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm->task_info.tgid,
+						    ti.tgid,
 						    vm->immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
-- 
2.42.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2069C4828D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Feb 2024 17:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CC910FAD3;
	Mon,  5 Feb 2024 17:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GC76tq/s";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E7310FAD0
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Feb 2024 17:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuA1DYUCto7X1PdwmNqRyyGGL9XkOvA3LgXqMqgyDJKF7eIXbmyIhq/Kb/tJMdTBSPCfObF/7FPzZ1yaRiaZjzbvjX3r64o72A7LkM2fqXP409OTcqLXKPUc7ZooJoYLflF2yK5bmx/KcrGKcxn5h/lQcRgJ/4++deVyauZRPmbNwyQ3V+dMPr9baEJc2LcncrMC3/h3u52+FOthHbrn5pJYaXUIhKNAMx6uJU7qIFg5UNJOhsF114cVGqGibkvjFdx79aT5AxoSd/4ZEdp4sILtHvYqgKbjBONCpGG9c6sr2ngIX6X3Hif4S+Y3UiVeO8un/CqjQ3GaGk/XyPMPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLIuGEBxNE1+ZFz1+HTy3iCriHgwRNhY8xUWTk7ZBg0=;
 b=gwkG+S8OAT2GTDDsAg7k/7f0hVbVg92iAcJ1LgzjDAR2cwLKyQWrsInoXoDAJvN/W+IQYjSKfQRgyQL0W1dg5msUzf0OROLf9RopVevBA1QC6SedqkpZZkr/mL1ohW5UKrlrObfJDQaH5KtsE0fQ4BabfoRWAQclPw7sFLVyZmqOHMgbl8rUH23FuBazE+SqAU6msW7U9Naet5tBU3jl0nZWBaxCKxEk6ctCIceJymqGLqe6B3NHOwbbEINP663Yr5lwF+zMzlovUu25WcLfNG3P4lKDg3zxa/vAcF2RFOjeJ0J7QiSvyOh/lf3ObZJNbmERReDijyO4QfTwPPK3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLIuGEBxNE1+ZFz1+HTy3iCriHgwRNhY8xUWTk7ZBg0=;
 b=GC76tq/sdJLwYb/W8CwQZDKcAMHcB6AEMXlhaEdrTToepMVCtzMzlGMIFXIm/GH3Y4wxn8kt/l4RQ5hOEyhgJ7uOksOjuwC39mCuR+Li2Hta/c1Bc8p6+GF09DPOTCiFMcyyIhJyyEOsuYbv+MWx9s3Gw9csCAIQ/fPGZv6kbHU=
Received: from BYAPR07CA0027.namprd07.prod.outlook.com (2603:10b6:a02:bc::40)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Mon, 5 Feb
 2024 17:05:36 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::93) by BYAPR07CA0027.outlook.office365.com
 (2603:10b6:a02:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 17:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 17:05:36 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 11:05:34 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <Felix.Kuehling@amd.com>
Subject: [PATCH v3] drm/amdgpu: change vm->task_info handling
Date: Mon, 5 Feb 2024 18:05:08 +0100
Message-ID: <20240205170508.974-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1ef326-4154-4dee-6d03-08dc266cac13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7aNgfGax0nfRkO49XCOn66YMXEyAOvYofghnkM8Fe/zpdshJNmAtM3S8rx5zlfW1ISuPf7D04cKRiqjHjO0OxjZ5rsUjmBmaY9h9GMrWO9RzC3U1WSdMUmzvsrgxFq92EeU6rBiNwKnOP0v5y7vn9FS0qUPBU0XG+leUpPjpNGN6NfzEDSzgn+8oIcg6DOH4tnugxOv40vXuDpHNCaPznaQa+6s88HI6RA0le+oIgcyOwjp7cmPTPzfuEjpz1Z/Ixw+/2zRky9r8KG11QCcu0agycBmABgDyw2TntL+TreldrgdybFfkYZ/nt0lLoGgByf4VDLtl80GXEAdFK4LGXMdy0Vq5HFVpcGohG7BM2drIHD/d5qJoNNMo5hlqiwi/u74ouVZRMMqy8Wp46P6mj2580ExYwAmk3rx+w4B64QdF1wX1gSxxTekDR0FZanb8SW5SFR0v2ownm9+AuZbNjRpZBxsLiLyFbdL7arF9nYp1DiBWx/RnpXLvcwYaDgafNerElm9LLkCi/MEtxBETp/w1ZncK8yxG6PailupCKreuofNBUOLASW9FRJ9frhof1XO/TDWdc4o8Ca55tyUYXLzzZp5zS6xvpxLC78yKCa4GxK8Ijz/WPCynYjpJPnJ4bv7imS0U1L7jnrEhSJjUhcBnLUES3BxB00J7O+d1kXyCXiFx1+br2KVhcDX0xl4uu9ON/Cezn3wzQFbpvtshnzoTYnM94brtaPZ7Nds0uZFlUpqS1Rz/hHdiQExODrqMp3s3B+1lGISGwXlQoNUkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(81166007)(40480700001)(1076003)(2616005)(40460700003)(16526019)(26005)(47076005)(36860700001)(41300700001)(336012)(6916009)(54906003)(478600001)(316002)(83380400001)(7696005)(6666004)(426003)(356005)(36756003)(70206006)(2906002)(82740400003)(30864003)(8936002)(4326008)(44832011)(5660300002)(8676002)(70586007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:05:36.3639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1ef326-4154-4dee-6d03-08dc266cac13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
V3: (Felix)
   - Fix wrong indentation
   - No debug message for -ENOMEM
   - Add NULL check for task_info
   - Do not duplicate the debug messages (ti vs no ti)
   - Get first reference of task_info in vm_init(), put last
     in vm_fini()

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 158 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  24 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  23 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  20 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  22 +--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
 13 files changed, 251 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e61ebdb3f3e..f9eb12697b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1775,9 +1775,14 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file->driver_priv;
 		struct amdgpu_vm *vm = &fpriv->vm;
+		struct amdgpu_task_info *ti;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		if (ti) {
+			seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, ti->process_name);
+			amdgpu_vm_put_task_info(ti);
+		}
 
-		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
-				vm->task_info.pid, vm->task_info.process_name);
 		r = amdgpu_bo_reserve(vm->root.bo, true);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1f357198533f..e6e6d56398f2 100644
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
+		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
+		   ring->fence_drv.sync_seq);
+
+	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
+	if (ti) {
+		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
+			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
+		amdgpu_vm_put_task_info(ti);
+	}
 
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..a59364e9b6ed 100644
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
+			amdgpu_vm_put_task_info(ti);
+		}
+	}
 
 	coredump->adev = adev;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d1b8afd105c9..8414567af683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2127,6 +2127,117 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
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
+ * amdgpu_vm_put_task_info - reference down the vm task_info ptr
+ *
+ * @task_info: task_info struct under discussion.
+ *
+ * frees the vm task_info ptr at the last put
+ */
+void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info)
+{
+	kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
+}
+
+/**
+ * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
+ *
+ * @adev: drm device pointer
+ * @pasid: PASID identifier for VM
+ *
+ * Returns the reference counted task_info structure, which must be
+ * referenced down with amdgpu_vm_put_task_info.
+ */
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_vm *vm;
+	struct amdgpu_task_info *ti = NULL;
+
+	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
+	if (vm) {
+		ti = vm->task_info;
+		kref_get(&vm->task_info->refcount);
+	}
+
+	return ti;
+}
+
+/**
+ * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
+ *
+ * @vm: VM to get info from
+ *
+ * Returns the reference counted task_info structure, which must be
+ * referenced down with amdgpu_vm_put_task_info.
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
+	if (!vm->task_info)
+		return -ENOMEM;
+
+	kref_init(&vm->task_info->refcount);
+	kref_get(&vm->task_info->refcount);
+	return 0;
+}
+
+/**
+ * amdgpu_vm_set_task_info - Sets VMs task info.
+ *
+ * @vm: vm for which to set the info
+ */
+void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
+{
+	if (!vm->task_info)
+		return;
+
+	if (vm->task_info->pid == current->pid)
+		return;
+
+	vm->task_info->pid = current->pid;
+	get_task_comm(vm->task_info->task_name, current);
+
+	if (current->group_leader->mm != current->mm)
+		return;
+
+	vm->task_info->tgid = current->group_leader->pid;
+	get_task_comm(vm->task_info->process_name, current->group_leader);
+}
+
 /**
  * amdgpu_vm_init - initialize a vm instance
  *
@@ -2212,6 +2323,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
+	r = amdgpu_vm_create_task_info(vm);
+	if (r)
+		DRM_DEBUG("Failed to create task info for VM\n");
+
 	amdgpu_bo_unreserve(vm->root.bo);
 	amdgpu_bo_unref(&root_bo);
 
@@ -2351,6 +2466,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
+	amdgpu_vm_put_task_info(vm->task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2507,48 +2623,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
-/**
- * amdgpu_vm_get_task_info - Extracts task info for a PASID.
- *
- * @adev: drm device pointer
- * @pasid: PASID identifier for VM
- * @task_info: task_info to fill.
- */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			 struct amdgpu_task_info *task_info)
-{
-	struct amdgpu_vm *vm;
-	unsigned long flags;
-
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
-
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm)
-		*task_info = vm->task_info;
-
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
-}
-
-/**
- * amdgpu_vm_set_task_info - Sets VMs task info.
- *
- * @vm: vm for which to set the info
- */
-void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
-{
-	if (vm->task_info.pid)
-		return;
-
-	vm->task_info.pid = current->pid;
-	get_task_comm(vm->task_info.task_name, current);
-
-	if (current->group_leader->mm != current->mm)
-		return;
-
-	vm->task_info.tgid = current->group_leader->pid;
-	get_task_comm(vm->task_info.process_name, current->group_leader);
-}
-
 /**
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2cd86d2bf73f..a74b94c3c9ba 100644
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
@@ -492,8 +493,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			     struct amdgpu_task_info *task_info);
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
+
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
+
+void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
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
index a5a05c16c10d..7098f0be83c7 100644
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
 
@@ -157,18 +157,22 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
 	dev_err(adev->dev,
-		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
 		entry->vmid_src ? "mmhub" : "gfxhub",
-		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev,
+			" in process %s pid %d thread %s pid %d\n",
+			task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
-		addr, entry->client_id,
-		soc15_ih_clientid_name[entry->client_id]);
+			addr, entry->client_id,
+			soc15_ih_clientid_name[entry->client_id]);
 
 	if (!amdgpu_sriov_vf(adev))
 		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 23d7b548d13f..bff88070bb00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -126,19 +126,24 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
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
-			entry->src_id, entry->ring_id, entry->vmid,
-			entry->pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
+			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		if (task_info) {
+			dev_err(adev->dev,
+				" in process %s pid %d thread %s pid %d)\n",
+				task_info->process_name, task_info->tgid,
+				task_info->task_name, task_info->pid);
+			amdgpu_vm_put_task_info(task_info);
+		}
+
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
-			addr, entry->client_id);
+				addr, entry->client_id);
+
 		if (!amdgpu_sriov_vf(adev))
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ff4ae73d27ec..ba1f18978487 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
+		struct amdgpu_task_info *task_info;
 
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
+		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
+			entry->src_id, entry->src_data[0]);
+
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		if (task_info) {
+			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
+				task_info->process_name, task_info->tgid,
+				task_info->task_name, task_info->pid);
+			amdgpu_vm_put_task_info(task_info);
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
index 2ac5820e9c92..cc0968f553a1 100644
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
@@ -626,15 +626,20 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
 	dev_err(adev->dev,
-		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-		hub_name, retry_fault ? "retry" : "no-retry",
-		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n", hub_name,
+		retry_fault ? "retry" : "no-retry",
+		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev,
+			" for process %s pid %d thread %s pid %d)\n",
+			task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
 		addr, entry->client_id,
 		soc15_ih_clientid_name[entry->client_id]);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3d68dd5523c6..43775cb67ff5 100644
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
@@ -2116,15 +2116,20 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
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
+			   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
+			   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			   entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev->dev,
+				    " for process %s pid %d thread %s pid %d\n",
+				    task_info->process_name, task_info->tgid,
+				    task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0f24af6f2810..51a17d7076ec 100644
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
@@ -1654,15 +1654,19 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
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
+			    "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
+			    instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			    entry->pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev->dev, " for process %s pid %d thread %s pid %d\n",
+				    task_info->process_name, task_info->tgid,
+				    task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d9953c2b2661..06ac835190f9 100644
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
+		amdgpu_vm_put_task_info(task_info);
+	}
 }
 
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
-- 
2.43.0


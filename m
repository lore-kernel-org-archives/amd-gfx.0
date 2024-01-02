Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7CFC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 11:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED6410E138;
	Tue,  2 Jan 2024 11:13:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE3B10E138
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 11:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYS/QO85/wBmc1/TTAfY9+zlkC+I+lv7TmAelbg7L7DDwkXq7s4GE79JjmgXmf4r+B9JkmY2cw2ocGTZIX83Do/nj56wK2iuwzFUJBcakDNgQLqo8UvhY5JecmkLWxtZaSKaEA1onxBVxe0jPeFvfpM+QZ/WpZigb5XAgpykgm0JkGOayJt7rNAwIHizpe9p72gyPIwFlX1zFN9IthMfcU/XdC5dEMPCjEdu8OIN4Mn64jEg/cE+0HuQmjlw1I7Ya6UqOV8/qdGyNDNOxI+4GtqRyZivXVRwBZCsiqjDp4QPZrsbo0BkC0z7EeD2KGE4Xo/8dFg/7V5MYV40jyD5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyMeBaLV/cpZhbJCWY42f2u5e77CSovNmNcqggOxGyQ=;
 b=UpEh6KzoZQ/lIkPu7OgumYgeTr8LfegyKbHKyRtAz8NKm59QJDgTzBapRwxtCGcr7e/9fMPBMGusi8aFZp9RQ6N1TizajHuzzBK5qCg7M5L3Jb9H9P/WjPdMDs4YR8UmN22+r7XkSMN78osJ2LkH5/riD35myIqzfnDV4gGzXO/DyrgVRKyVznOG0dYXYB7nuD+GZBkaRfO0gC3Z/P1z2sjW5tDAr7cw+KkSPcak56dWr0RgakZon19d3qyQx8IEyuCjneo4uImBz6UjZzW1smKKAlC1nQReiQ48NNUN3UR5vwJQnsrHtknWmCaFGW5cxakBYIMoaR80ZgSq2YrceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyMeBaLV/cpZhbJCWY42f2u5e77CSovNmNcqggOxGyQ=;
 b=MzMd7wsQA0jn9EXB85sAcLW+wjyL0M9QMnPskCfvdmZSbJe7qqqFzbxZNJ6sKShW6v/wjbw0SLMy3G9dhcP0SjVY/0etp/W7WUDqZwF43ypsPeh5jSqcrKr9AwdM5zzUTWGDEGJajCKKFfXlQuGrLy3yu7u+QyubBkfWlw/vRIo=
Received: from DS7PR03CA0250.namprd03.prod.outlook.com (2603:10b6:5:3b3::15)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 11:13:24 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::b) by DS7PR03CA0250.outlook.office365.com
 (2603:10b6:5:3b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27 via Frontend
 Transport; Tue, 2 Jan 2024 11:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 11:13:24 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 05:13:21 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change vm->task_info handling
Date: Tue, 2 Jan 2024 12:12:35 +0100
Message-ID: <20240102111235.137-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa60c6c-d96c-483c-0dfc-08dc0b83d62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LRVWra4jIy0k3pLgx4B89BPXbcdLBI1gGCLpA+1qiqTO3vq+8QjTwaEUKnTEkN8ARI1BC2TlFYphLN8PsslVbvNnLzg6/ekTRenaJuGqFSuaCA6oIITrg7jXY1K1+ROuWr4yydAlDptDqjmktdzTjlK9NXHJp5pvdOIBxtKK82DranFY/EzFTChY9HQ+g6HH2jV/p38hx96Sv0ucMNOeKvFsv/fIdz4IKSL7kHCFdPESjx8Xyb9Dk/5Pnv9NBMLbaxNJM6i8No9cCebYXEYGH40XRbxtBm6+R9fkoFCihOWkFQKsPjSfPU6n/nAL3JnHrGfKsrcxiCZ0CraYwfudwQrIAzwsXbdP03TUvi+fc6LkqbBNH96FkUdGXlnqqxJMARB75D6eM1fcPA8ebJf9IhG026jqC6uYewIW3xRtarfqtgy9A8TXc54CjRCx2kqbG+OBtP1MKScLbckCooeK5aORoXatX+EgwUec/Gy1R9eNmGpH5PxfpoaCZecoCFzc8D51w3bRjiMlGWNon7Z4HkiHOh3Zgvypeo4yQaUq/glW01ob48RwP90I8IRc9iIpBKDv0uD64V/VkqBK0LgJVjBHCNRd+o5QvPjTNlRH6/lCAMfN9GYOU5tWaWFk00vR+3UE+seL/ZyEVRIlbrb6QsdhxYTgiOZMszcop79TNwrJAZNPAq32Oz0KuYtllhl94be23icL556i7Iq0vKdOAhLla5CAkcKlZ/W/jk8GJgFdNLCC8Yy0Hv7lt8qyg0JhhWM3YQCfh0DnawXAOuyEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(40460700003)(70206006)(6916009)(70586007)(7696005)(86362001)(16526019)(336012)(83380400001)(41300700001)(82740400003)(81166007)(356005)(1076003)(2616005)(47076005)(26005)(426003)(2906002)(4326008)(5660300002)(30864003)(6666004)(478600001)(44832011)(36860700001)(316002)(54906003)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 11:13:24.0688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa60c6c-d96c-483c-0dfc-08dc0b83d62a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
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

drm/amdgpu: change vm->task_info handling

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

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  15 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  17 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 142 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  24 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  27 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  28 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  26 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  28 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  20 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  19 +--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  17 +--
 13 files changed, 259 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index a4faea4fa0b5..111f8afb03a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1763,9 +1763,12 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b8356699f23..00516fa178b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4952,10 +4952,17 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				tmp_adev->reset_vram_lost = vram_lost;
 				memset(&tmp_adev->reset_task_info, 0,
 						sizeof(tmp_adev->reset_task_info));
-				if (reset_context->job && reset_context->job->vm)
-					tmp_adev->reset_task_info =
-						reset_context->job->vm->task_info;
-				amdgpu_reset_capture_coredumpm(tmp_adev);
+				if (reset_context->job && reset_context->job->vm) {
+					struct amdgpu_task_info *ti;
+					struct amdgpu_vm *vm = reset_context->job->vm;
+
+					ti = amdgpu_vm_get_task_info_vm(vm);
+					if (ti) {
+						tmp_adev->reset_task_info = *ti;
+						amdgpu_reset_capture_coredumpm(tmp_adev);
+						amdgpu_vm_put_task_info_vm(ti, vm);
+					}
+				}
 #endif
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 78476bc75b4e..b89ee6ab7db9 100644
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
@@ -58,12 +58,15 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
-	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
-		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
-		  ring->fence_drv.sync_seq);
-	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
-		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
+	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
+	if (ti) {
+		DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
+			  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
+			  ring->fence_drv.sync_seq);
+		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
+			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
+		amdgpu_vm_put_task_info_pasid(ring->adev, ti, job->pasid);
+	}
 
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 82f25996ff5e..0d655bffad7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2332,6 +2332,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	if (vm->task_info)
+		amdgpu_vm_put_task_info_vm(vm->task_info, vm);
+
 	flush_work(&vm->pt_free_work);
 
 	root = amdgpu_bo_ref(vm->root.bo);
@@ -2492,26 +2495,129 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
@@ -2521,17 +2627,23 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
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
index 204ab13184ed..c2dce85d4f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -183,10 +183,11 @@ struct amdgpu_vm_pte_funcs {
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
@@ -334,7 +335,7 @@ struct amdgpu_vm {
 	uint64_t		pd_phys_addr;
 
 	/* Some basic info about the task */
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 
 	/* Store positions of group of BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
@@ -466,8 +467,17 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
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
+struct amdgpu_task_info *amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
+
+void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info, struct amdgpu_vm *vm);
+
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 96d601e209b8..f8323957d8bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1032,7 +1032,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm->task_info.tgid,
+						    vm->task_info ? vm->task_info->tgid : 0,
 						    vm->immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fa87a85e1017..12c624876243 100644
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
 
@@ -155,18 +155,19 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
-	dev_err(adev->dev,
-		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-		entry->vmid_src ? "mmhub" : "gfxhub",
-		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
-		addr, entry->client_id,
-		soc15_ih_clientid_name[entry->client_id]);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev,
+			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+			entry->vmid_src ? "mmhub" : "gfxhub",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
+			addr, entry->client_id,
+			soc15_ih_clientid_name[entry->client_id]);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	}
 
 	if (!amdgpu_sriov_vf(adev))
 		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e3b76fd28d15..ec61e371120a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -120,19 +120,21 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
-		dev_err(adev->dev,
-			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-			entry->vmid_src ? "mmhub" : "gfxhub",
-			entry->src_id, entry->ring_id, entry->vmid,
-			entry->pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
-		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
-			addr, entry->client_id);
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
+			dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
+				addr, entry->client_id);
+			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+		}
+
 		if (!amdgpu_sriov_vf(adev))
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 5af235202513..a33a5659713d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1446,18 +1446,20 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
-		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
-			entry->src_id, entry->src_data[0], task_info.process_name,
-			task_info.tgid, task_info.task_name, task_info.pid);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
-			addr);
-		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
-			status);
+		struct amdgpu_task_info *task_info;
+
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+		if (task_info) {
+			dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
+				entry->src_id, entry->src_data[0], task_info->process_name,
+				task_info->tgid, task_info->task_name, task_info->pid);
+			dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
+				addr);
+			dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
+				status);
+			amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+		}
+
 		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry->pasid);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f9a5a2c0573e..fefaa57d8669 100644
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
@@ -625,19 +625,19 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-
-	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
-	dev_err(adev->dev,
-		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
-		hub_name, retry_fault ? "retry" : "no-retry",
-		entry->src_id, entry->ring_id, entry->vmid,
-		entry->pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
-	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
-		addr, entry->client_id,
-		soc15_ih_clientid_name[entry->client_id]);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_err(adev->dev,
+			"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
+			hub_name, retry_fault ? "retry" : "no-retry",
+			entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
+			addr, entry->client_id,
+			soc15_ih_clientid_name[entry->client_id]);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	}
 
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
 		dev_err(adev->dev, "  cookie node_id %d fault from die %s%d%s\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index cd37f45e01a1..02c8d4364c87 100644
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
@@ -2125,14 +2125,16 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
-
-	dev_dbg_ratelimited(adev->dev,
-		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
-		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
-		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
-		   entry->pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev->dev,
+			"[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
+			"pasid:%u, for process %s pid %d thread %s pid %d\n",
+			instance, addr, entry->src_id, entry->ring_id, entry->vmid,
+			entry->pasid, task_info->process_name, task_info->tgid,
+			task_info->task_name, task_info->pid);
+		amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index f413898dda37..b62a9bef72e2 100644
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
@@ -1646,14 +1646,17 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
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
index d9953c2b2661..f6ed68fdff81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -238,16 +238,17 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 {
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 
 	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
-	/* Report VM faults from user applications, not retry from kernel */
-	if (!task_info.pid)
-		return;
-
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
-			  task_info.pid, task_info.task_name);
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD6C7115E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7236210E48C;
	Tue, 17 Jun 2025 03:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="it0iVS5N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E75910E485
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjzoiWXmwJAEQME2z/NoURnwPivqCUVLNZtadHnXDiOX0EKu59al4vzQVNNRi2m2g7rbc2IkdYXsaX4ZVUhzkBHeFkfDkXkZEdFWqVNnkOaZuAPRAPtkzR4QiU3VKt6NYI6PWSTHHwcvvPtsgJAadZrQgEUoIASvgGV55mV2HF5gcW8gGnCzywBPJQ2XW9qP/ihiBbH+4vWfpcnNPM8XcRW6iHdyaMJ7rE2Pe+MNqfv9boyNSrdkxTIIiScgdd55Pr7NkhUAUeSc5ZclH5+5mcRD6Dx/xaJJS5YQmR0dWturKM2Jv79MJuN0h5tQKfBGrRW7bGlpI3zoP16ksbHwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIxL1bjwi3L2fg2RBsPLqLFVGPMZGH3D7l04na8vDBs=;
 b=mvRIsPQJvAf2pFwnH3ejgVGWpuVJAxAIhwJQmuIxjM3l3l3GL67VQoNv0Ky++SamM/nRiFuCSSYHaTCRDm1erq8/GdPEvrwUhmXD4cZcUd64nRW2q/Dtfxyc+cV7hHyvrbPPYyzTH7MFDZLwiTiz149Ts8GSy66xt9X4vUJjExo/n574pFU73z9wLf38VdVc8kSCPE8UjamlsOwsE6TC3kiKke0MguQON3ksFWTsGklg+O4MniL8I5yF4vusIm/ptNtGSfFKzaIQAoiOmbyIAjny0ptonl3viAwHhOawCh1YvJEbQso3Cc35jHoA81tKarQMU/pVLl6UwBT3JWU65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIxL1bjwi3L2fg2RBsPLqLFVGPMZGH3D7l04na8vDBs=;
 b=it0iVS5N70C0HVnIUAGytnt5o8Byfm7dbBBB4va2sWz71oSeAPEWHRJBhxiT2w4UyjyYLxuZe+RtUAvMUWH4rG0yqlM6EVTf1jPv6Mi9j9auL2vCUynRleEqOdBv+kitZHx0u5GwBLh4wJuyizdtt1T93TAtC0Aqx5QY6mmQauU=
Received: from MW4PR03CA0151.namprd03.prod.outlook.com (2603:10b6:303:8d::6)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:43 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::e) by MW4PR03CA0151.outlook.office365.com
 (2603:10b6:303:8d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/36] drm/amdgpu: track ring state associated with a job
Date: Mon, 16 Jun 2025 23:07:52 -0400
Message-ID: <20250617030815.5785-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 1367b2e0-ed6b-4ba4-f735-08ddad4c4481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FnlOXOaApexQ5I3/68E9nB9YZgLqhMxuIJavjJFwOkNDzd3BZGzeBZVS6kU0?=
 =?us-ascii?Q?sY8u7f3SNLjgzrMCFGtTvWA4/LquJeTqXYBUydzl3hXLlZcgDrLKJS5JUZGn?=
 =?us-ascii?Q?UB88vfhjHnlSj4D3E76ebIKvOnP4iybje39/CVHGi9kMWaCGbhRF7HkZJp1T?=
 =?us-ascii?Q?ABCeedRiIVv0cO98qOtP+dJ6qzVOXhNcp6JUuqzrcnya1IVcRyIqMl3XD8Xw?=
 =?us-ascii?Q?0jcZczAIdJF46GAKVtnf9EGdR03xYwLwRcaXKTA4fb5Re5/6+jJ3VmhRdyQu?=
 =?us-ascii?Q?UqDcNDa1NVM5cqzL5oNXNlrPcvVTv0Zo9EUhq/WC64DyNH9r6r8St1DRdG7C?=
 =?us-ascii?Q?sqdCXuhB3g307Pbi6FFFhkN5F0pTr5YpqYcyrKLk/AtC2lKO450qPkV3NLDq?=
 =?us-ascii?Q?v6dYOMnZNXsAcuWNqYMk7QQnAIpGcnB4vZc8511rqf1D2yUiYuWTYBwjtGfn?=
 =?us-ascii?Q?e4ieL89XIe/WKTM5ZYDHxPNcp+IriVIB8yjNOhhPBLT9mWXQY0CFMfzBbmfP?=
 =?us-ascii?Q?AwxwdHRD67sAK0PvCshAw/eaMnJxD4IyCRR6afsnkBSN4zThr+hbCPZ/U1GJ?=
 =?us-ascii?Q?OBhekTLs1IWpProiOWl+SDUVhG0vsSmd+/zPjrcJAmZNwp+L6K5Ar0clkW05?=
 =?us-ascii?Q?BfGpskT0ArJ9NTPtU4BkML9Ev1qW1qAT8LRvb4jFSyqtR61is+IeImkwPh92?=
 =?us-ascii?Q?xcadb77aLuuW0QcWUA+MK+O2rWN5OC84ujUXRCKz7ooYT7i/wubNzHO68KEM?=
 =?us-ascii?Q?pQofanMFysK3dhkVzg5xUdvVYfyDwd64mJSZSIQqqTnkK/3zT+0z5zArlAve?=
 =?us-ascii?Q?NHpxMkMEr9iduiWt46A9wmd6A+GX2qFJDpOYtOvBhWGNkmENRZcpxtsX0tQu?=
 =?us-ascii?Q?+3Mmfuwmn7GNvSlBxCN37LRzz8+rzF4ZM9O7lCby/3x/z6Al7gEYlypZPa6K?=
 =?us-ascii?Q?FckIpOSBzBBpKtVSq0OscodoFHavnQzw0/cvhHZPNuRjzljNm7Lk8NFh1bZI?=
 =?us-ascii?Q?e8ZOwChRb1qFNI0girVxgEKuLlnEzly8lD/pKepqwmIXR5DG/eKD7+9018xS?=
 =?us-ascii?Q?q6g7pDH9AJkO8zgxeOugMKmmCkl/ipZlevskGABx873541kdz603eUbdr4VV?=
 =?us-ascii?Q?LfRz6E7FtPuhDXVnn6zfkgRqFjarIxID21WLHbxeHYNn6Ge1tyIg6gswAHXp?=
 =?us-ascii?Q?3q8bQYU5y0BY1o8DcJ4WpIYuiq5ziTCypc1SAw7FnPuWlvvyIc9hS8wYL4Ys?=
 =?us-ascii?Q?CtSACEolREI/puteL+WJNZgnfTrQzMdZpM8YiKgTj1ptcGQNUap4l1qvfPYG?=
 =?us-ascii?Q?hKmAs1dMxNkstx0YcKWVkhmwUrgBQvGQSmEJ5i1X7+zzphNmQE1xhL2Bzw8w?=
 =?us-ascii?Q?yFAdHDFyRkfYu7F7itOoSqYu+4mbeWplY5JGhtlkNsHbGTRUmwVrbV4NFo7U?=
 =?us-ascii?Q?wgMnZ/gkrsAIQsV/ZBIxSc+P5RFOAi71aO5IFSi2DhmFj8hXSGdgU6MCs9aH?=
 =?us-ascii?Q?doayxrVHN3DRJv/g2XBqoSQyjlTdsJWdfqYP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:43.3614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1367b2e0-ed6b-4ba4-f735-08ddad4c4481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

We need to know the wptr and sequence number associated
with a job so that we can re-emit the unprocessed state
after a ring reset.  Pre-allocate storage space for
the ring buffer contents and add helpers to save off
and re-emit the unprocessed state so that it can be
re-emitted after the queue is reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 90 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 14 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 59 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 17 +++++
 5 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 5555f3ae08c60..b8d51ee60adcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -120,11 +120,13 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		am_fence = kmalloc(sizeof(*am_fence), GFP_KERNEL);
 		if (!am_fence)
 			return -ENOMEM;
+		am_fence->context = 0;
 	} else {
 		am_fence = af;
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
+	am_fence->wptr = 0;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (af) {
@@ -253,6 +255,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
+		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -265,6 +268,9 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
+		am_fence = container_of(fence, struct amdgpu_fence, base);
+		if (am_fence->wptr)
+			drv->last_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -725,6 +731,90 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 }
 
+/**
+ * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ *
+ * @fence: fence of the ring to signal
+ *
+ */
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+{
+	dma_fence_set_error(&fence->base, -ETIME);
+	amdgpu_fence_write(fence->ring, fence->base.seqno);
+	amdgpu_fence_process(fence->ring);
+}
+
+void amdgpu_fence_save_wptr(struct dma_fence *fence)
+{
+	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
+
+	am_fence->wptr = am_fence->ring->wptr;
+}
+
+static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
+						   unsigned int idx,
+						   u64 start_wptr, u32 end_wptr)
+{
+	unsigned int first_idx = start_wptr & ring->buf_mask;
+	unsigned int last_idx = end_wptr & ring->buf_mask;
+	unsigned int i, j, entries_to_copy;
+
+	if (last_idx < first_idx) {
+		entries_to_copy = ring->buf_mask + 1 - first_idx;
+		for (i = 0; i < entries_to_copy; i++)
+			ring->ring_backup[idx + i] = ring->ring[first_idx + i];
+		ring->ring_backup_entries_to_copy += entries_to_copy;
+		entries_to_copy = last_idx;
+		for (j = 0; j < entries_to_copy; j++)
+			ring->ring_backup[idx + i + j] = ring->ring[j];
+		ring->ring_backup_entries_to_copy += entries_to_copy;
+	} else {
+		entries_to_copy = last_idx - first_idx;
+		for (i = 0; i < entries_to_copy; i++)
+			ring->ring_backup[idx + i] = ring->ring[first_idx + i];
+		ring->ring_backup_entries_to_copy += entries_to_copy;
+	}
+}
+
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence)
+{
+	struct amdgpu_fence *fence;
+	struct dma_fence *unprocessed, **ptr;
+	u64 wptr, i, seqno;
+
+	if (guilty_fence) {
+		seqno = guilty_fence->base.seqno;
+		wptr = guilty_fence->wptr;
+	} else {
+		seqno = amdgpu_fence_read(ring);
+		wptr = ring->fence_drv.last_wptr;
+	}
+	ring->ring_backup_entries_to_copy = 0;
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			/* save everything if the ring is not guilty, otherwise
+			 * just save the content from other contexts.
+			 */
+			if (fence->wptr &&
+			    (!guilty_fence || (fence->context != guilty_fence->context))) {
+				amdgpu_ring_backup_unprocessed_command(ring,
+								       ring->ring_backup_entries_to_copy,
+								       wptr,
+								       fence->wptr);
+				wptr = fence->wptr;
+			}
+		}
+		rcu_read_unlock();
+	}
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 206b70acb29a0..4e6a598043df8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -139,7 +139,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
-
 	unsigned int i;
 	int r = 0;
 
@@ -156,6 +155,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
 		af = &job->hw_fence;
+		if (job->base.s_fence) {
+			struct dma_fence *finished = &job->base.s_fence->finished;
+			af->context = finished->context;
+		} else {
+			af->context = 0;
+		}
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -309,6 +314,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
+
+	/* This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * fence.
+	 */
+	amdgpu_fence_save_wptr(*f);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index f0b7080dccb8d..45febdc2f3493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -89,8 +89,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_task_info *ti;
 	int idx, r;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
@@ -135,7 +135,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
-		r = amdgpu_ring_reset(ring, job->vmid, NULL);
+		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..0985eba010e17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	/*  Initialize cached_rptr to 0 */
 	ring->cached_rptr = 0;
 
+	if (!ring->ring_backup) {
+		ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
+		if (!ring->ring_backup)
+			return -ENOMEM;
+	}
+
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
@@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 					    (void **)&ring->ring);
 		if (r) {
 			dev_err(adev->dev, "(%d) ring create failed\n", r);
+			kvfree(ring->ring_backup);
 			return r;
 		}
 		amdgpu_ring_clear_ring(ring);
@@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	amdgpu_bo_free_kernel(&ring->ring_obj,
 			      &ring->gpu_addr,
 			      (void **)&ring->ring);
+	kvfree(ring->ring_backup);
+	ring->ring_backup = NULL;
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
@@ -753,3 +762,53 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+static int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring)
+{
+	unsigned int i;
+	int r;
+
+	/* re-emit the unprocessed ring contents */
+	if (ring->ring_backup_entries_to_copy) {
+		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
+		if (r)
+			return r;
+		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+			amdgpu_ring_write(ring, ring->ring_backup[i]);
+		amdgpu_ring_commit(ring);
+	}
+
+	return 0;
+}
+
+void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
+				    struct amdgpu_fence *guilty_fence)
+{
+	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+	drm_sched_wqueue_stop(&ring->sched);
+	/* back up the non-guilty commands */
+	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
+}
+
+int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence)
+{
+	int r;
+
+	/* verify that the ring is functional */
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	/* signal the fence of the bad job */
+	if (guilty_fence)
+		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+	/* Re-emit the non-guilty commands */
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+	/* Start the scheduler again */
+	drm_sched_wqueue_start(&ring->sched);
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 6aaa9d0c1f25c..dcf20adda2f36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
 	/* sync_seq is protected by ring emission lock */
 	uint32_t			sync_seq;
 	atomic_t			last_seq;
+	u64				last_wptr;
 	bool				initialized;
 	struct amdgpu_irq_src		*irq_src;
 	unsigned			irq_type;
@@ -141,6 +142,11 @@ struct amdgpu_fence {
 	/* RB, DMA, etc. */
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
+
+	/* wptr for the fence for resets */
+	u64				wptr;
+	/* fence context for resets */
+	u64				context;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -284,6 +292,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	/* backups for resets */
+	uint32_t		*ring_backup;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -550,4 +561,10 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
+void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
+				    struct amdgpu_fence *guilty_fence);
+int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
+				 struct amdgpu_fence *guilty_fence);
 #endif
-- 
2.49.0


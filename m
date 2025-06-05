Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBE7C61DB8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D00110E841;
	Thu,  5 Jun 2025 01:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJTMt2BJ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 203B310E7C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm3jP6xP4aVzTx5jEJbBhOT7L5fiIcUHG6D2jFlN+4TDW0wcZOintV+uRgQveOAuB4DYcf2YwUEPTZUTC7mVxsL1xT7QPA4qgxldjdRiGKqkdcYl3hfQ2gDEZa9tNQiq7MjRfYH5u99afB1Bq57mBkB/YDoUxaUr5KHyU1nzve+3Pmxx6hEUrbXAB93CYa2SyNAFx+hvUljspw6tHbJACVy1GQzC3xeED4rBF6RdSN2m2ve3T2dmmHrlVCdEpBGEJd00D5Kd8lNVqTE+GvL+AnTrcK8jcmSTiVqTlenjOr5z/eBSgmjLFMgU39G86gWVlC9MR9EIwTjcITQP4jz3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPpfZhPoQcay6Wjf4hWB0KgU7Dlps7m+ETc2kzqL7jY=;
 b=cG6fEexDDjANb1d0jaBKmWzvZmgw5os68LfsMyvsrV+lggsqNmH+kG57JpP/mScQv8beq65bTb2+7cFeDAqVVPEFXUzwmgXuwgcWI91E36u3UpX6fZF8g3t2uQxr0Dnt00ddJMhT4bcRtz4d3f6OagemEO/qnrZwGpBoWPCwPWwXxrYq1wB8HTgNTRJXpghTKu2ajwG/hVX7X6DLm1MSganxxlgtKMJbYCwLjWRThx8cGH3DxiQL3IjpObI1fu6OU67+7QuKUyS1j2wt6vD7q7NKJ2fiUJX31hHXokx+8WfDz7jCLDKWVgBEQNc8O1T5nYTNJRIxIS2r1T/nRF15bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPpfZhPoQcay6Wjf4hWB0KgU7Dlps7m+ETc2kzqL7jY=;
 b=qJTMt2BJiUYBfRSczIfphewT2IhzyaDUoESWtqpc9rcnLOo6bba/r6u5rt9ykYRgS0KU+1IGBNhB60vHg0q8c/i0lMeJjS2H6L5Mq82Z0/eD+qZnhDne6hAMPGBlAMtwxfv7kTMxacR/3cZ2ZkPvc80MUozP0QuR9kS5SVAU4mE=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:26 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::1c) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/31] drm/amdgpu: track ring state associated with a job
Date: Wed, 4 Jun 2025 21:45:38 -0400
Message-ID: <20250605014602.5915-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f051ccf-7715-470e-8b3d-08dda3d2c8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x5YNgcqwWfYY2AaEApiWuNtpNR3y5cgYSA1fbFO2nIJ4Si9WFScZlboaDJDn?=
 =?us-ascii?Q?xQHef0YeTx/GTdGCMcXYU6OssxKwwqOpRcsrWwAX21aVFWvEfMC1FCWXO2xq?=
 =?us-ascii?Q?IJorRNAmj6WZ1qovalh5jaAoXuRzbN67fDx/PppMWBmNakK5cIFF5zNDF8CQ?=
 =?us-ascii?Q?56TVqf3COReZdvP1yLzZzMGamB92TjjD+FyeKCWx+2YBB9maHNd96IxsCq6i?=
 =?us-ascii?Q?pkbUhjJxlEBt/OXpCMxEAMtvtjEYmUw+LcQvzy8q6+9vxK7+MejczRv7bPqC?=
 =?us-ascii?Q?IiiJEppy03oH1elvwI5QKKu6fZOGmR6KVaY3D1M1mhBSJ0adV8CW9NhLTFp0?=
 =?us-ascii?Q?lOfVfHPhzwDrqhN5ysJDEV7WbC1+z0NEZjpYnIJnTYkVYtydgaLyK8wc2uuM?=
 =?us-ascii?Q?t/v6Fg4UYCy6z+AoQnAgQla3/DP4OzMRjjhzP8z3OgIzUP4tHyNL8v8r2hNT?=
 =?us-ascii?Q?XWMX7WFmKqvSvL/KDTNfkMuGzqAzWcDSttMXB6q/9FKjYYGWKIH3tUMrH+VT?=
 =?us-ascii?Q?7k2jZiDPv4VIQUf9OdK8xJl/Tov4fOxgkykO/+29xRcGdqdyihU9iC0ToRB6?=
 =?us-ascii?Q?YwEW5/Vs1aYcVEJOc2OEO73dYOV5Uv2irYjAcjCluOtnbM3Wb0Hd6Ztmvo27?=
 =?us-ascii?Q?JKwbhEN6VBJ7u+8Jg90/glpWj9sAvJwiwmrj4W3apA+vkeLMatiLGVXcwc7G?=
 =?us-ascii?Q?0GsNPiHdrr5aLu5Fo8XxNmw0+bwNgdPvYSZtb2h60Yo00WXoG/VsIz0lLcHE?=
 =?us-ascii?Q?GIZz9yn9yw1VYAskp8AH+FQqcS3f+g120v+yKCOWLFLg/jrGKdATUt4OV4Ye?=
 =?us-ascii?Q?J7YVjYZsG2bvbjJ5bsTDxrS64FyNfiC6PS2xxkouVUT4jNZllgeT/z5P6MU5?=
 =?us-ascii?Q?HA1LYBwnvAks4m7UFSXiNCBblcaC1XpW8CZPKnGf/VqDyNhtiYB8ATVIoILA?=
 =?us-ascii?Q?n7dkhO48ao2on4jopaNCh/UZozTsCfHcNbfiRWtyFj1updqnazK8+MDA04RJ?=
 =?us-ascii?Q?7tgDWvDVGfuNI2+KJH474z9dnZ6d4SJzuTNXQ2O4I1/lU6iYNm6xZIiYPsTH?=
 =?us-ascii?Q?dyB8ch0QDXHsaL52d7WDV2RA3hzqtznJgQSEuG/ttSOPmN3fMBhITPISMp6o?=
 =?us-ascii?Q?L65anGlkxpdqDoEGwEcblvfClf68CB72gnJzXCxWqNfWygVF7PCCsA91tLeY?=
 =?us-ascii?Q?iudQMFIrjHid9z4pSjzICEVUF5Ns/EDcnBSslnZlp1FMgHJPl+88JwWuXaos?=
 =?us-ascii?Q?ZQfTQW9dSCp0/FmgJqJr6YQpb7YWaKPoy6R7n6QAVqnRxLV7sg/Hz+29jr0d?=
 =?us-ascii?Q?3lShOwlbLOAf7MDADntzEvi56Tvc/Zb5J8ZT7dyqIogw9L81d3eYfclFZ1HS?=
 =?us-ascii?Q?LztobJpe+YGtKl3x0Yeg69e+ctygRhhybCcwZOqfCYzF29CN+w0vANz7BJZU?=
 =?us-ascii?Q?CHwlOc1msPKa2v88Gx75d1kgHVg0ZWg6BELg5SaPZ/o9dHNpz967Zml6tFO6?=
 =?us-ascii?Q?u8FBTMK3dGnDeEb+ryiNrCh3MIrq8Xw9Efu7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:26.2906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f051ccf-7715-470e-8b3d-08dda3d2c8ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
the ring buffer contents and add a helper to save off
the unprocessed state so that it can be re-emitted
after the queue is reset.

Add a helper that ring reset callbacks can use to verify
that the ring has reset successfully and to reemit any
unprocessed ring contents from subsequent jobs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 15 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 11 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 92 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 15 ++++
 5 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 569e0e5373927..25a664273bf0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -141,6 +141,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
+	am_fence->start_ring_wptr = 0;
+	am_fence->end_ring_wptr = 0;
+	am_fence->context = 0;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (job && job->job_run_counter) {
@@ -748,6 +751,18 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 }
 
+/**
+ * amdgpu_fence_driver_seq_force_completion - force signal of specified sequence
+ *
+ * @ring: fence of the ring to signal
+ *
+ */
+void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring, u32 seq)
+{
+	amdgpu_fence_write(ring, seq);
+	amdgpu_fence_process(ring);
+}
+
 /*
  * Common fence implementation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b39..636941697a740 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,7 +126,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		       struct dma_fence **f)
 {
 	struct amdgpu_device *adev = ring->adev;
+	u64 start_ring_wptr, end_ring_wptr;
 	struct amdgpu_ib *ib = &ibs[0];
+	struct amdgpu_fence *am_fence;
 	struct dma_fence *tmp = NULL;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
@@ -138,7 +140,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
-
 	unsigned int i;
 	int r = 0;
 
@@ -187,6 +188,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
 		return r;
 	}
+	start_ring_wptr = ring->wptr;
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
@@ -306,6 +308,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
+	/* This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * fence.
+	 */
+	end_ring_wptr = ring->wptr;
+	am_fence = container_of(*f, struct amdgpu_fence, base);
+	am_fence->start_ring_wptr = start_ring_wptr;
+	am_fence->end_ring_wptr = end_ring_wptr;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 23b6a0fc0c691..73c26e2e01647 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -89,8 +89,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info *ti;
+	struct amdgpu_fence *am_fence = &job->hw_fence;
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_task_info *ti;
 	bool set_error = false;
 	int idx, r;
 
@@ -154,7 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
-		if (is_guilty)
+		amdgpu_ring_backup_unprocessed_jobs(ring, is_guilty, am_fence);
+		if (is_guilty) {
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 			set_error = true;
 		}
@@ -409,6 +411,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	struct amdgpu_ring *ring = to_amdgpu_ring(sched_job->sched);
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence = NULL, *finished;
+	struct amdgpu_fence *am_fence;
 	struct amdgpu_job *job;
 	int r = 0;
 
@@ -433,6 +436,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 				"Error scheduling IBs (%d) in ring(%s)", r,
 				ring->name);
 	}
+	if (fence && finished) {
+		am_fence = container_of(fence, struct amdgpu_fence, base);
+		am_fence->context = finished->context;
+	}
 
 	job->job_run_counter++;
 	amdgpu_job_free_resources(job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..3a0e0883bd8e7 100644
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
@@ -753,3 +762,86 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+static void amdgpu_ring_backup_unprocessed_job(struct amdgpu_ring *ring,
+					       unsigned int idx,
+					       u64 start_wptr, u32 end_wptr)
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
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 bool is_guilty,
+					 struct amdgpu_fence *bad_fence)
+{
+	struct amdgpu_fence *fence;
+	struct dma_fence *old, **ptr;
+	int i;
+
+	ring->ring_backup_entries_to_copy = 0;
+	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
+		ptr = &ring->fence_drv.fences[i];
+		rcu_read_lock();
+		old = rcu_dereference(*ptr);
+
+		if (old && !dma_fence_is_signaled(old)) {
+			fence = container_of(old, struct amdgpu_fence, base);
+			/* save everything if the ring is not guilty, otherwise
+			 * just save the content from other contexts.
+			 */
+			if (!is_guilty || (fence->context != bad_fence->context))
+				amdgpu_ring_backup_unprocessed_job(ring,
+								   ring->ring_backup_entries_to_copy,
+								   fence->start_ring_wptr,
+								   fence->end_ring_wptr);
+		}
+		rcu_read_unlock();
+	}
+
+	ring->ring_bad_seq = bad_fence->base.seqno;
+}
+
+int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
+{
+	unsigned int i;
+	int r;
+
+	/* verify that the ring is functional */
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	/* re-emit the unprocessed ring contents */
+	if (ring->ring_backup_entries_to_copy) {
+		r = amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
+		if (r)
+			return r;
+		/* signal the fence of the bad job */
+		amdgpu_fence_driver_seq_force_completion(ring, ring->ring_bad_seq);
+		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+			amdgpu_ring_write(ring, ring->ring_backup[i]);
+		amdgpu_ring_commit(ring);
+	} else {
+		/* signal the fence of the bad job */
+		amdgpu_fence_driver_seq_force_completion(ring, ring->ring_bad_seq);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e1f25218943a4..69b71401adb7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -141,6 +141,12 @@ struct amdgpu_fence {
 	/* RB, DMA, etc. */
 	struct amdgpu_ring		*ring;
 	ktime_t				start_timestamp;
+
+	/* wptrs for the fence for resets */
+	u64				start_ring_wptr;
+	u64				end_ring_wptr;
+	/* fence context for resets */
+	u64				context;
 };
 
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
@@ -148,6 +154,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring,
+					      u32 seq);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -284,6 +292,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	uint32_t		*ring_backup;
+	unsigned int		ring_backup_entries_to_copy;
+	uint64_t		ring_bad_seq;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -550,4 +561,8 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 bool is_guilty,
+					 struct amdgpu_fence *bad_fence);
+int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
 #endif
-- 
2.49.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33174C71159
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB9D10EA65;
	Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJ9hY9Qr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A6D10EA62
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNFT2ZOBaap8tW7l4H/Pdd9dRfoxLd/9HsVuFVhldSAmUXRkx080o2Qsv9K126NXSJAHIhuTkziwa5MN5RcZc83LmcVHZ4qdUVlGw2HxenlTyNlX4koF4mWUFPIzOL9HpwWhyRiEJkEfJRwFP2OBm8BhyONwV6AVz3u7ZjdP/LK3E+w0VkxAlO5tNpElQzHwT4aSGwF9fZ9/K3dhxafB6Bh1ssA56A19qzvu4CN7Q9RJKj249ofkm4Fdhud5dusiVy03zfmoZX46k4ek0bD2LvgCM6Pl2b34xX9oqKLa3/lHPArjKcV8L7mCHdlRU26C7oBjIRX1ewM2RLdkAAxg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsQZqz1RxH2ouUU5XCcqjH2meiIZsY95g2029fvDhuI=;
 b=g5SsSprvBmZZh9c9AIrXMYbDrq6KQXjngzsIuwFN5vnlagcRoCyfZUUNgSzQgKBCAaEPDjFsEXujbPZjYh6b26tJiLvx6itVk5hlv+DbM0NZ5+1ei3Q02lx5ihHHbzqqqU76fnnxiEYHOhchLk0EhZmA+SD3jJ1JvbAJyz1oALttCdsA/HivJYM4lGB0lIRkwEdSbh8Vk4i7RHe+6Fx6B399UIPnO1LtTFprMAScyb7WjjHmLvjsp1UyVOKwI1f7MYfpWjD03jdn02Jquvo30AU20m7KHK7804f38yJn+LqFNfF5dPEa7M0QxyzFUxrzNubENN8aMxIeJJJGy8KQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsQZqz1RxH2ouUU5XCcqjH2meiIZsY95g2029fvDhuI=;
 b=RJ9hY9Qr/7RoZYwza6sdZcl2rOE6EVfy8RIs5XlliZNUbxa57xdSJXLdp/6Yn66JV5JKTdKEsfWCGmk34Q7fL1cfVBZEtIuB6/pErKY4oaA2b7PJFp04la5q7dgpPZ+RYT5+T0mpboLHCAX3w95Io9gRQnKiGB61ya5Hue4A8mg=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 21:48:10 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::84) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/27] drm/amdgpu: track ring state associated with a job
Date: Fri, 13 Jun 2025 17:47:29 -0400
Message-ID: <20250613214748.5889-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f15c2d-f79c-4ef0-017e-08ddaac3fd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CXacUNJS6gIbitmnT7CseNGWCxJonoODaGM5ZNno+CONX9WfKjwf1cnefl3N?=
 =?us-ascii?Q?+6JdayJ2B5QlhuTdXn2MxsNf9Usn4Bwlgm8hwQL57r/c3C0htM6ZKiXG4qQn?=
 =?us-ascii?Q?TlvrM5NXzj+j+n51p05VIChfs6HCjHgMANdMIUi+nyQhoAKe3v3ZqtYe6Qxs?=
 =?us-ascii?Q?K//YI2VvB2iMaOTT7OPlUm8zDK9SELwMWVo4gNiP2umVbVNeK+Ojm5zY/xgq?=
 =?us-ascii?Q?TckqLv5kAeJiSsReL8bsNVssR4lNduouRPJPORWasJY/00CUF+6Zfk99pJzk?=
 =?us-ascii?Q?ujvzKZjMjF1cIiS6At3GgVfb68plES8x235Vv+4WXOQIdgUko2gM9v80RzZh?=
 =?us-ascii?Q?H2WYFNm594HVbjVYCZoccPXwFp3uB7X/JfRgIqh1G84tLHynvoQbU6l5oQZ+?=
 =?us-ascii?Q?Ie0R5I0LPZKTqbY7JMzjir4V00S0ZCMTfhazCArL+5jDk5g1nufGP5n5wGuG?=
 =?us-ascii?Q?XjMIfDkJTelCx5aIwzRlV+cooIQ8/deejSzA2xIElEhx96n4mz84150vL7H1?=
 =?us-ascii?Q?Dsf/Y5oz6k0mQp+DczbbbV+XesiXBkmsIjS3SmV0U7SJF9xaOgp+Z+W7SBG2?=
 =?us-ascii?Q?wp2wuZl+FWhZKGRHA0pSQepJ6wfAtVJnZiqiLkPw39wEYzidJGLpVbVkr5hB?=
 =?us-ascii?Q?aVC+QrG/8u7oBprh88QiRk7NqzUioMvd9AeEqKjwP1OmewrinZaz5mhx3uqf?=
 =?us-ascii?Q?8qAD0MyzcWnUZQWCF7V2hZviGV7qvO4L5gKtWLBdpE5fuqYQsQgaflIczXKv?=
 =?us-ascii?Q?nkntiRCKTp0hfxIFrrEWAtEKehhgoZ6KervYAEvZGs/swJC8cCeku0pO0DDT?=
 =?us-ascii?Q?KbtHyBstVADWTbUG6LLblpprnTOgh4vwH3fpcpPL49rUlzNAgxzA+vKNqDZE?=
 =?us-ascii?Q?8vQctYRWwpFaDIaNDMgiy9vT0x+e/xdZFj9MmxQjeTy8engVe7pQDIHiXYLb?=
 =?us-ascii?Q?0hiCXYtWEi4QpVDqaFRsuhXzpgCCfPhqH6r6WceNsW5wa8b/VLIwwkIey4Sm?=
 =?us-ascii?Q?3Tec5+6D7+lS6qUgO+t+8r1MWqV+EA0yJOt9BE3bo1HTnIsnqnVdtAXW+3uZ?=
 =?us-ascii?Q?Ibabbq5DH6bIAkZMYPXtO/Sc3dbVodJa+b5Uy3fo+7nr7v/Fe6omYhKVfoMI?=
 =?us-ascii?Q?Ya4MRCn8wP0qz10HdXEVCu8dPDuzqXlTRBr9dl/Bw/ZKJD3XLzARkfoMsueR?=
 =?us-ascii?Q?v5jieaaItAmfKRN1gq9fkZ3vp4ZnMx+OZbsCTqY/Gs3HtMEqiHpDGSvq4e+z?=
 =?us-ascii?Q?HCsb0KPpQXp7OUkpyfrSEiYE3YN0Nto3FBCmaUZynysNtvEYYD9IGm3OWAVq?=
 =?us-ascii?Q?2QytarFxFM30/kIBOl8o3EM7ezwsJtPduTscQazXa3lvkv+5e7KhNl/tHfdS?=
 =?us-ascii?Q?hX0WDHCg0jHVxeMNTp5YBvP3NmYjqGhJ5IbRF5bSwaKYyhj1uqvigqTfk30y?=
 =?us-ascii?Q?BvKt7VNfrP+pr7VrnM2mj8t5C5kFqFDxTCZU2bq78c6sWQvqB4ozj9CIVKxi?=
 =?us-ascii?Q?TIIzHopy55XJwAYegZgyn+VTdWHkCov24tQ4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:10.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f15c2d-f79c-4ef0-017e-08ddaac3fd5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 96 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 27 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 14 ++++
 5 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 569e0e5373927..d9e75d38bebf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -135,12 +135,20 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
 		if (am_fence == NULL)
 			return -ENOMEM;
+		am_fence->context = 0;
 	} else {
 		/* take use of job-embedded fence */
 		am_fence = &job->hw_fence;
+		if (job->base.s_fence) {
+			struct dma_fence *finished = &job->base.s_fence->finished;
+			am_fence->context = finished->context;
+		} else {
+			am_fence->context = 0;
+		}
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
+	am_fence->wptr = 0;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (job && job->job_run_counter) {
@@ -276,6 +284,7 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 
 	do {
 		struct dma_fence *fence, **ptr;
+		struct amdgpu_fence *am_fence;
 
 		++last_seq;
 		last_seq &= drv->num_fences_mask;
@@ -288,6 +297,9 @@ bool amdgpu_fence_process(struct amdgpu_ring *ring)
 		if (!fence)
 			continue;
 
+		am_fence = container_of(fence, struct amdgpu_fence, base);
+		if (am_fence->wptr)
+			drv->last_wptr = am_fence->wptr;
 		dma_fence_signal(fence);
 		dma_fence_put(fence);
 		pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
@@ -748,6 +760,90 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
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
index 802743efa3b39..789f9b2af8f99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -138,7 +138,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	int vmid = AMDGPU_JOB_GET_VMID(job);
 	bool need_pipe_sync = false;
 	unsigned int cond_exec;
-
 	unsigned int i;
 	int r = 0;
 
@@ -306,6 +305,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
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
index 680cdd8fc3ab2..af45b4a1e0c83 100644
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
@@ -142,7 +142,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
 
-		r = amdgpu_ring_reset(ring, job->vmid, NULL);
+		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
 		if (!r) {
 			drm_sched_wqueue_start(&ring->sched);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..736ff5bafd520 100644
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
@@ -753,3 +762,21 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index c1d14183abfe6..7a61f3b74c69f 100644
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
@@ -550,4 +561,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct amdgpu_fence *guilty_fence);
+int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring);
 #endif
-- 
2.49.0


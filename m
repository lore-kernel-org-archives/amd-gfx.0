Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DCFC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A083A10E810;
	Fri,  6 Jun 2025 06:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v8HSDiXD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2EA10EA07
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/F+mRvXO29zCsp4hOfrGun5lRgkq4kjCQcI2zzgQhTJmiFfSZkV8jVLFjLHZ8q7TyBlTfThb1M8gqSjffNjxaML42RxQ5+TdGgn2kXX749RmvBKJu50PCcd6MA+ebqOZmAEVE/ijuATK6/M7k0LqeChowKHNTp4tkLQKDhp9n9sbOtaWvJoul2NBFFzsQYJIFBglBCGBYW/i3g50HtT3C862lJcjEIl3y4OmSCZdXq6Ujg+0mVpZ5N/mKVIKcPGY3lDPXJRvQdltrbD6c8RJ5mlz5i/itzrYUh/2rJGz8mU97nBifJVdWhHHdu8tiHHoa4rzlNPTANDi2gvsgwn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw9POYxFCep/5YFyUj+Dp7EdI5MEiIGwaijnkwclvnk=;
 b=M1q+T1JoS6FSKy4pXnqWUEf7C85NOy/CxTJjFn3z/+J3THW5izIAGyiuwCTEYdsFsdEoBhPI6DmtEFKHrMx/JtON5uae+5XhwHm74Oyy6JlXbNBbTXQq8pztvo/wQSuI6f8HbW5eb+Ivy5rDaPst1FN30Xj9155kCyMElE8DZDcIAqoEIK7PzSBgiBQQU0rBbZNR7khjIcuCVIzFvNlLV7SGzxYTm/GfAmBKQ+F185p7YAHyZjtYCDznGd5uzEv6kKq+QxihtpFDjwcHY9Z8YGJpw3LcIVBlbZAlsvREsemBeE4vOkYr/c7eDFj4SlF2f/TpBHIwk/WY0Fg2x8Jb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw9POYxFCep/5YFyUj+Dp7EdI5MEiIGwaijnkwclvnk=;
 b=v8HSDiXDXfayZpPh9C2iBglbFC2EUMDOzHfDQtptCTic9PNKmaKjAETOHf8xiaYRHhk88JPX+h51UvkVgWyLp+Y0JC1Db6GgDYj5gIbCqquUBWgjldlzcwjoKl+rkhUfvIgeCnbofeHTAMR4h+Am0IXQVa/2ZmQBcbUC3q2ok+A=
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:17 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::5f) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/29] drm/amdgpu: track ring state associated with a job
Date: Fri, 6 Jun 2025 02:43:35 -0400
Message-ID: <20250606064354.5858-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 08616bc9-ac63-4905-3771-08dda4c58ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uf/VXYNvF+4drCnKPBu8clUTvrZ0Hiq3FipMjszY549yo/SRm2Q6681eKELb?=
 =?us-ascii?Q?IFi9AJWiQiVTSDAF4kYNMec72Qdaq8gEtRinAJyadmzgUZwYOEfBHs4wtXKX?=
 =?us-ascii?Q?/gbFkJPN8Uyg1dtKERQn3CHBkv7bT9U0U6xFuezNoUHDKVh6OE29JbRthHjg?=
 =?us-ascii?Q?ItlQ2v8Dag1lRrqciBjmJ4yxWsFUjhIqQjAyF1Asogurns0C/pphsORS7NKZ?=
 =?us-ascii?Q?h4yEK8xNKEqDtH5NweovpELpBbSVCZZYZDGAjpCocW0xKWk5Wbskf+S3LiU8?=
 =?us-ascii?Q?5nfjQWEa2HaQhGtTaN/qYP3Vd44L3NuJuEK5oj3kylHbNdtvTDhpuSj/UDPe?=
 =?us-ascii?Q?HNWwugNeGjjNfE0AN/Hx+AON3XBB9UAzE/7iX1bjA8X0hYKXv/7dqxmBjD0j?=
 =?us-ascii?Q?QXGVxO81Hto6kCM4tWedM7kdeeZn6vH2Q8Ps36otkA/RY3Bf72IRRj/FWTyL?=
 =?us-ascii?Q?+DKcmWCKA+l9NydJ4tjLDq930iPI/jTW/+GxNRvqy2wA60BKGlmsGsrzDA7c?=
 =?us-ascii?Q?FkyzmXzq73MfL7usY7f9FeixPEjQm4uIwjCJ/RT7DdEy6EvnVNZ2pbCqDdkG?=
 =?us-ascii?Q?E/JcJzLHmE3Y0/MTWed7tyFDwgHiNGr4raY3OdzS2y95iCiKQms9b7OidKBB?=
 =?us-ascii?Q?/pzq6O6izrjXO0+Q+TR0er96yhNkhoJFyhPtSEQW4eGxK4UfwrFmXBpmgD8t?=
 =?us-ascii?Q?h91i3v8jw5Dp7nAijZT4EHM7uUlpu4L8o+IT7fXwouQD7LKQ3xFvaDJ6DNT5?=
 =?us-ascii?Q?nt5JKpsAaWL4KjSNHBw3IvDGPJTAY23yNQxR7IYU0lteb7Dav5Ex+ZBbvo7K?=
 =?us-ascii?Q?1tYo/3XpKH0M3XXjH+84dJHFpPTemPzRxA5l6Q2SacJ6kRckY+849Egz65wI?=
 =?us-ascii?Q?oCi1wShk+gkqn9IB6pcWmhgyouv1wccrBDBEdIcr0CyEU+ujCPR8mz3yV3cJ?=
 =?us-ascii?Q?5EmYQj6XRUdcrBzGwB6WqNuTuioYqkHlhCD2KE2jlMl5TNWLcjyVU0t9OlIk?=
 =?us-ascii?Q?L1nZ/Ux1qZMOn3DA33Nqktmawea2BP0qcIEzT+oKw3gRJl5FnldTT6dFESNi?=
 =?us-ascii?Q?RlB6UsCknPd7KkKXdxnmOg/EVYxxL6HnSyQDrTvjzsCxvzt+opgatuPCc4TX?=
 =?us-ascii?Q?5MLnWW2WYoQJ6x3QIpCXns3CO2UZMSJabbLdGp/h5VUXqaJARWMJQfTDu56e?=
 =?us-ascii?Q?hsonnXy5qyuimJkPzERCGKBd3KXpsuH/GzWR48mkLCxtQQk5+O2GQxk+XYB0?=
 =?us-ascii?Q?OSYDi2P5xEex5uj7qER+lgQ53s/AefZdizHUaCw8Jeq1QUEaO78Nb5ZAqjhg?=
 =?us-ascii?Q?BzyEPXYGf8L+lpVbt6WjU+wGFbg3Nkx+AvRk7I9a+MLUuMpTJjsirq3OsbNL?=
 =?us-ascii?Q?WWkc8dBuYPuM3VGrAYFcJbihSkQKyGvWymKaJLjRNs4b3JNn487N88vWV5Cc?=
 =?us-ascii?Q?uVM7xQeYBjSfM14KCG5MeNe5Qv0PJtTrrh7US+aWS0hVg8mqKlbCpQ72N4R4?=
 =?us-ascii?Q?1QJVOHP8dtBVnEJAed3Xs00KGRxJdio8VdGc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:16.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08616bc9-ac63-4905-3771-08dda4c58ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 27 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 14 ++++
 5 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 569e0e5373927..da87a5539a90b 100644
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
@@ -748,6 +756,88 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 	amdgpu_fence_process(ring);
 }
 
+/**
+ * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ *
+ * @fence: fence of the ring to signal
+ *
+ */
+void amdgpu_fence_driver_guilty_force_completion(struct dma_fence *fence)
+{
+	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
+
+	amdgpu_fence_write(am_fence->ring, fence->seqno);
+	amdgpu_fence_process(am_fence->ring);
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
+					     struct dma_fence *f,
+					     bool is_guilty)
+{
+	struct amdgpu_fence *bad_fence =
+		container_of(f, struct amdgpu_fence, base);
+	struct amdgpu_fence *fence;
+	struct dma_fence *unprocessed, **ptr;
+	u64 wptr, i;
+
+	wptr = bad_fence->wptr;
+	ring->ring_backup_entries_to_copy = 0;
+	for (i = bad_fence->base.seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
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
+			    (!is_guilty || (fence->context != bad_fence->context))) {
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
index 308d3889e46ca..0ac51d7b4d78a 100644
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
index 2b3843f5218c8..b73894254bb8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -141,6 +141,11 @@ struct amdgpu_fence {
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
@@ -148,6 +153,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_guilty_force_completion(struct dma_fence *fence);
+void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -283,6 +290,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	/* backups for resets */
+	uint32_t		*ring_backup;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -549,4 +559,8 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
+					     struct dma_fence *f,
+					     bool is_guilty);
+int amdgpu_ring_reemit_unprocessed_commands(struct amdgpu_ring *ring);
 #endif
-- 
2.49.0


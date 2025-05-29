Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A3C5B552
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7768810E75D;
	Thu, 29 May 2025 20:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eahd3Ta/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075EB10E221
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+3VAukp/TYhVoj+FsIhPBaQdLJ0GrtdDPZIV66c6ptA7uxzvo3eLcjr9wGOA6uZ3gGzERA965Itt8wTcAURGmo3Bk5uS9E9//Gi7E8kyfQlYLfT6twPWiZyIq0KUycsQlPhkKr1oH+bDJ/GHwTra1bu920zkr+b2KllIn5S2JFCqKjRwIWgqHQnx4KBQZDBsNNPFw8x6NYTq7EJNP9uf+NWhF1k0uHi3VDdwZItnbZY7akMFHW8enis3Dqwsl+DUslda/UOQHKzLKi0x3ckLKHzMJe/MTc37tIvtEZ4ym2oHAHMH7ZD23kiEZeNhAii9R4B2ZTt+PDdkNGgEuuyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Bj7APyB7Q+qRN1VN+uiTJQPBPx1CWys5apONgbVHFs=;
 b=guuz06uVtVqbB+uI9e52vM19vC/1PpS3UQu56xBwC5oeGrYULCMUd2YiIlFoUKRpsy3nz784Cf6MV5i+pSMNXFyXZFx6uXsTPADrq0PnyXmAeE9yD/jhuVKa/iX2AlzBUsZGdIKyXvjIKXwv1Ln1G76bhGQccnI7tC+VBrOrJhbvn+mejf2fk+oSt+2pHHMufG3PYCI2JaZsJw7NWrwa+ed60L8foueOZTdqjmSVNUPuauUXMxn4ITFnppjaNBWz0HcXgA34URgx7xSTBk/1Z9XA/cTYhA+z1XJv2wKZvgHjuOO1WYDoyN+H6NLc9A355moQOQov5au9JvL3WNIlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Bj7APyB7Q+qRN1VN+uiTJQPBPx1CWys5apONgbVHFs=;
 b=Eahd3Ta/i+mCwPvcJ0Lf6IHGoUC/UWrHeJT1Ytg5FFrenGW9716NNNBI+/5A6QG/KG9bER5kPl3OaSd6grE7JRFcipG9cOweDFqPrWnWfKBPci5XPaOHlyg+kRiVzPs8/hFWoYZPepMLEEYHxAQSmQzeiH6C68Wy1NpkJeFFRlY=
Received: from MW4PR03CA0059.namprd03.prod.outlook.com (2603:10b6:303:8e::34)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 20:08:25 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::33) by MW4PR03CA0059.outlook.office365.com
 (2603:10b6:303:8e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 20:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/28] drm/amdgpu: track ring state associated with a job
Date: Thu, 29 May 2025 16:07:37 -0400
Message-ID: <20250529200758.6326-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: af529c45-55c2-4e78-18a5-08dd9eec9174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hLUJCg1he6ic4Z2IlFsiiID70tamwv0aGcxB8+HH51r/KTts4/MgwGe8dczk?=
 =?us-ascii?Q?ecuhhKykOwAOOAWmml5oo/OC5O0Tzn5i7Vd3Zp9F20tWGzb6vUGtLdy/uYOY?=
 =?us-ascii?Q?07tcVcfxToDHTg4CB4efl+HrES8UH29Fxw5OlCRxGAVJprAfzLEfiVIO7XaK?=
 =?us-ascii?Q?/shyvklsQblJL6hlwSC+P7qaqNaEhP7HUtbChb1DnPDlp8E/5oMroLLI+t6j?=
 =?us-ascii?Q?2b12fkB03T7W/pIOMvBmQu6epjqN1bN6x2fUoGV6+oUIxH6i6EqNqCjDfNHN?=
 =?us-ascii?Q?FixqVdcHkA3o+8sx7q7UDS1I6fSr/tLWlUKnkZ6pfcyS+CYwtfFIAh9K6G5X?=
 =?us-ascii?Q?yxKGE3UdiOuj2pYRiyQR1XaYdJZcFx80PdGmoHEBSJTU4RLf/PUWGoVauwSc?=
 =?us-ascii?Q?TYJB+h+jj2iuk+eA76zM7JsEG24MUZd1qt9crsTw6jgt3wTY8qZv5puEYjbx?=
 =?us-ascii?Q?CVWNhjfpuzJTJlsBe0DefMRxUdT9AuJt7RQcmXhgtLdFudBZ38TvtoHt/UbI?=
 =?us-ascii?Q?f7YcfIsUlMKj0Rdi+Mqm8mwrwXfJiB8mcvqaovY5TzhFgwq2J/1osZiDW0Jx?=
 =?us-ascii?Q?n7dVYgVqrk2wXwTNHf0LJ3vq1IaN2jZI3OQZW+2xL7azP0Td4qsJ8esHYK0k?=
 =?us-ascii?Q?pdQQSyL8xoSxvWIyCnb2f+SdYOMyKolEwzVuH1SjNL4cuRgtR9LkCBTV0aaw?=
 =?us-ascii?Q?jPn1dNP/MarXWLOWQiRXJoiPwcTKL/HoIBZVC/FfZZhtPuloQtMJkhQQiaTq?=
 =?us-ascii?Q?Y1EPXkgoNoZ70KfYLtlvVYRgVFHPiJqeAuuNTa64/1Qep8YGgKDvdI60DjSX?=
 =?us-ascii?Q?1zwubl7ModOV70G4d3oU5A2WcoSX8uca5vgMBctCvoIxWT46kiSIynCmkddm?=
 =?us-ascii?Q?InVvNbiWzCGCAu93PYSvtIBxUQC15YsNA/T8fFkg1oEQwoFGkLBVMIkalbQu?=
 =?us-ascii?Q?ERctYu0OtUqRkmqMBKI/MefWPCoARRROA3joZ4xfFC/kv0dasKwvWsOviS0+?=
 =?us-ascii?Q?q+G6wo8DAmgITtHYDNjm2X6rZpIwJcvTol8NIVNrWBPpci0WniZ2ADukpGbS?=
 =?us-ascii?Q?vJNBEOjMMJlCynZYQvEZ5UVYU50K/gZP+I63LB5M7uzUFbAFidK4nuys2NLq?=
 =?us-ascii?Q?DDq2Kvn3TDPzH2gQZC1E6tChvkMDx2QIUD/I6uvFadhuFagwppeq1cJasrVS?=
 =?us-ascii?Q?IJkvlbgF42hZ1ktqK7IPW6hGJt34TZQ39G7690NJ0qNBgignmfam+ZxdeLMx?=
 =?us-ascii?Q?SANWC6/ZaEhkWhYnAVogHftCXKM0wJtHHHik4Xvji2wWJP0Z93Tt8IA8nV+X?=
 =?us-ascii?Q?aZNYcc0CWsPfE/hgFXkk9C2v2BY0xvJPNPSFr1s8kvgGrjxHMtWmavMyLQ2H?=
 =?us-ascii?Q?rBvz7yda9R7GiVQHEPLcN8R5AoaZPjvFGdrVEGGSBXKwL3i2Fz+1W0AloUSB?=
 =?us-ascii?Q?u25PQrtYPArkL1xJwmjgEzgQg3ucLTIGmEu9wxkUhaICpXKU9TqotopjmI7Z?=
 =?us-ascii?Q?33gSkgR0i1LStSSGexHalWjQ7fsky/l7Jrkt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:24.4999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af529c45-55c2-4e78-18a5-08dd9eec9174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 12 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 46 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  8 ++++
 6 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf6..319548ac58820 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -764,6 +764,18 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
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
index 802743efa3b39..67df82d50a74a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -306,6 +306,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
+	/* This must be last for resets to work properly
+	 * as we need to save the wptr associated with this
+	 * job.
+	 */
+	if (job)
+		job->ring_wptr = ring->wptr;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index a0fab947143b5..f0f752284b925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
+	struct dma_fence *fence = &job->hw_fence;
 	int idx;
 	int r;
 
@@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		else
 			is_guilty = true;
 
-		if (is_guilty)
+		if (is_guilty) {
+			amdgpu_ring_backup_unprocessed_jobs(ring, job->ring_wptr, fence->seqno);
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+		}
 
 		r = amdgpu_ring_reset(ring, job->vmid);
 		if (!r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index f2c049129661f..c2ed0edb5179d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -79,6 +79,8 @@ struct amdgpu_job {
 	/* enforce isolation */
 	bool			enforce_isolation;
 	bool			run_cleaner_shader;
+	/* wptr for the job for resets */
+	uint32_t		ring_wptr;
 
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 426834806fbf2..909b121d432cb 100644
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
@@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
 	return true;
 }
+
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 u64 bad_wptr, u32 bad_seq)
+{
+	unsigned int entries_to_copy = ring->wptr - bad_wptr;
+	unsigned int idx, i;
+
+	for (i = 0; i < entries_to_copy; i++) {
+		idx = (bad_wptr + i) & ring->buf_mask;
+		ring->ring_backup[i] = ring->ring[idx];
+	}
+	ring->ring_backup_entries_to_copy = entries_to_copy;
+	ring->ring_backup_seq = bad_seq;
+}
+
+int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
+{
+	unsigned int i;
+	int r;
+
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_seq_force_completion(ring, ring->ring_backup_seq);
+	/* verify that the ring is functional */
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+	/* re-emit the unprocessed ring contents */
+	if (ring->ring_backup_entries_to_copy) {
+		if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
+			return -ENOMEM;
+		for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
+			amdgpu_ring_write(ring, ring->ring_backup[i]);
+		amdgpu_ring_commit(ring);
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b95b471107692..fd08449eee33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
+void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring,
+					      u32 seq);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
@@ -268,6 +270,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	uint32_t		*ring_backup;
+	uint32_t		ring_backup_seq;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 u64 bad_wptr, u32 bad_seq);
+int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
 #endif
-- 
2.49.0


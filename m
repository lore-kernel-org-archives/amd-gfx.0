Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46023C5B552
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F6010E65E;
	Wed, 28 May 2025 17:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kjh6hH35";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53C9C10E6AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkdAnLEfwwzOV32gFkzSrqsdqxLdrx5Zhbm53MHi3WE2moBUKqNNMw9Gwlj/QVQgh4idpWimWpAucM8sVh+8RFAv1kSHUObEYOYBKDmZmGVwVJO6Bym20NMAAW4LkJFyfSwUMll/a3H2mhyiP75ugO0AJT049LdbnIhEsmlRXnsfoeiNj+onUfljNNl3u2+JNHwZU3J2IQEwKPSNn7WIvuVLX9brIqRWji0F+/uOp5McmWDQllQj3OSBrSYNK3SCSsOKb+jyNjr+/pI/1FHXZsYaw4a4Jg+2nVaOpvUi0fciwPlSaCk40ffrqtNYu40UIB1xti1xywKiAR0yBOBFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3LnbttwIYkbLLWhFJ3qfSTzcSRW1aFib/jP0mtSGto=;
 b=Ev/AioWuKU+YDRC5UtgAAdk5pwfSkPi7JYAaiYXlt/EpTgBS0zLLgbIy5h8ddL0pOw5fiTMaGmXbJW9ufTh/JjElp+sGih0YOuIaSznGM9g8Kzhl6F0FP0jAYBoUPgZgHXZmCrOUF5cKbSdsogXTPO8JlJwovsHGamJkwtRD5YcdnSNktY7qtKYXrVqzjcn89a3QCBQORzMdhx5O7Pbd+M3tumsLx74fKsWjTQPjh3B43jNbnpYyquUCB+hL/AwP/8g8h5eqt/zzi2vm0qCAPqtLvcROmoyzjLOnCQ1DY8vVrP7rb08HusfkiLYqLb7wbr4sQazcffLWtT/s9g0S1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3LnbttwIYkbLLWhFJ3qfSTzcSRW1aFib/jP0mtSGto=;
 b=kjh6hH352Mw2wEJFRfi3/lz6sCdHtQQsUSdfyxAYrPv2OiQGnaQkG2kR3hIQFcGFoZj/NEt3jSn47a2piGlUd0ok3pzZstFVcxIGmsgWAOIhHSZ7RDUt1KmebAzu4ZxqQZXpha/T77Bd7CHXwKUqKUf3WNPM+3vwe56kDm7Kst8=
Received: from BL1P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::34)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 17:28:22 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::d) by BL1P222CA0029.outlook.office365.com
 (2603:10b6:208:2c7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 17:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/16] drm/amdgpu: track ring state associated with a job
Date: Wed, 28 May 2025 13:27:53 -0400
Message-ID: <20250528172801.34424-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 6976b96e-f726-491f-7360-08dd9e0d0be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rDnyk7UiWq4xXsydjbJjzORBeOJdJEiGZk8zlcqKw/Hy1fIt4D4/Vx91IGmU?=
 =?us-ascii?Q?WuLylJpzExpwUlOugbskBGk3aS00c9NipES1Lrf6VvZn4yuw/q7hCfZNr8CX?=
 =?us-ascii?Q?iVRSiWeMhWETYcVOlIxi0OigCzdpC0T/6xTXiEDnw0l+rK53s4RZ7U2xbabi?=
 =?us-ascii?Q?5o9w6FVGCEXtMPy2qCrj2MfjEWzAC1suBoWUucvSlFORCY6K395uQAR8oaLB?=
 =?us-ascii?Q?xyw+fA7QyKSdiEhdfHt/8vaxLLacGdNVhUoEShLPgEMQFM2szp0dFbR0ZMjy?=
 =?us-ascii?Q?dvQsDb+G9apsXKgJeyaSuvHfwFxqq7QA8+lqoU7eX/frmnYdjTdKZAeZiq2c?=
 =?us-ascii?Q?XVYkLcSEvI2csP4sAro1bqkqdZlytGvRVWrfzIi9aKhb5BTCyirz3fLOc4+5?=
 =?us-ascii?Q?kR9dfnNEsXE1eFda5qKAIwhAkKWEzkQnhdIkNnUnChuCoso6Ds/fcmLpmzWq?=
 =?us-ascii?Q?jqtTiiFR7gnXdagddxgCaTigJI2l8jtMpoDmf+ryWQOW/mSKfEPyUKG2tSPW?=
 =?us-ascii?Q?ehmh29cd3jMTd3J6EsjJm63C14rpdhbsnna35EnJtzpq/eFnvqn9tCyAae57?=
 =?us-ascii?Q?vvZNF1rdO5FgeRpmvgJZJ5K2a8ptIxkLd+plM1lWbTOCjUYAwEmzwMDtHx3M?=
 =?us-ascii?Q?8QqhiqlGsQ6gL1At78ZClvDns0ixHT1r1tW1pCVRUfPJmFka/+jHhDpu7bZG?=
 =?us-ascii?Q?juSmvWp0aH7sxDZINIQtX+94u2FFZDpe+JKRbmJCGg1CiQ9NPn5OyKCnf9he?=
 =?us-ascii?Q?1dEh4dz1w07rsvpuLTlWM3cfbRO2f0XOmm2o4XivIp/xv6dAMFWapCuuAPqc?=
 =?us-ascii?Q?Xq6416ruBzQymM2teieiebZ8rGNbAA2aRhy/3H0yFesCzSVMC0U0Q9O6HgbE?=
 =?us-ascii?Q?hy9BMtg7kFH0RD8qTyCkIx5V/Ru5kEeDoLsyqaQc4t9EpiAeZvbuYIoSVb9P?=
 =?us-ascii?Q?DhZ/GBmXSv+mX/8qrZuwDX8D8m+eC/9UZegisQ/t5ILp2xZggcNjBVWHzEUc?=
 =?us-ascii?Q?Za5cgHJ0pYl5bnMagOOwj0KOyY5DcVaupWn+nuzWTjDElpQ/8gtfr7p1Nkn/?=
 =?us-ascii?Q?kuYVhLK6GkZl+8ZXsZyz9A6z3Ym3DAOjQzxrZcn2VPGE7ur+vgR50dKfl1H4?=
 =?us-ascii?Q?lQ8Vg380S8G/3b/6umXcC/EOR8RS0udvj4Ve1xIjVfVxEVuxS/SAWmYxi/j9?=
 =?us-ascii?Q?DQAv75TGFHMxFir5487/PIqpjx6M/r6p4JlD71N/u3BwLWiSUtFREJfgwO/A?=
 =?us-ascii?Q?GZWn95X86TwO7/wR+NblSv4ll6heXxI3CdkNcUemDrcpJ3gi5McMctKEDXxx?=
 =?us-ascii?Q?6ThSYqVAchKE/HzryK8IxBOCprZaCkyFM3GJBn4NuE3zCqkd9usv/QOm79nU?=
 =?us-ascii?Q?AHVWSFpP5Pr11X0MydAgMbFY95gj98kRTrQd06NDrn1xmqe6MLR5ogJpeBAT?=
 =?us-ascii?Q?sGBeK30RUGuGc7oR0iC78DSzKqXfTUYtyNiDyfS0jsdVHpcir6dYHSn45ChR?=
 =?us-ascii?Q?a3uXEIYRZaQlw5hdyUkE1lioq5aGHKFbYCy/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:22.6859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6976b96e-f726-491f-7360-08dd9e0d0be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +++++
 5 files changed, 40 insertions(+), 1 deletion(-)

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
index 0b9086a747c0a..c549e7c598459 100644
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
index 426834806fbf2..f5833ac8026a8 100644
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
@@ -753,3 +762,17 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b95b471107692..a6e386a62b45d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,6 +268,9 @@ struct amdgpu_ring {
 
 	struct amdgpu_bo	*ring_obj;
 	uint32_t		*ring;
+	uint32_t		*ring_backup;
+	uint32_t		ring_backup_seq;
+	unsigned int		ring_backup_entries_to_copy;
 	unsigned		rptr_offs;
 	u64			rptr_gpu_addr;
 	volatile u32		*rptr_cpu_addr;
@@ -534,4 +537,6 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
 void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
 int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
 bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
+void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
+					 u64 bad_wptr, u32 bad_seq);
 #endif
-- 
2.49.0


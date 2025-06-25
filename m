Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A3C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E647710E7D4;
	Wed, 25 Jun 2025 21:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p7Who05E";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B071A10E23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=se1V5/mx04iHIkyQhj7DcS8cYZz66l1fNhDhQV/SeM1Gmv3p+SFDQkpulEjRul8v9G/G+9n0IZFeEGh59U1PQCNAkB/WlvgdrSCo9LXqBjeuOAkxxe90PtREhMmEmNqtjTyDtkgYVYtF1g7tG1b1JieNA//s7lfAj9qwaLPLrMUKXjqROzs7QBsdGYfVLXQe8zdeQ4MXk2vevduVYSYbmuU0Y+2gd6x7OIrAEFdRvgi89xgRc0Z3DQoMwbK2+hI7CfSlrW9FkSwe18cTzXC+wKJdoTnoDWIdN5ABGZ4p7edkFugW3VOsdVTjsSbozbg2u+fn1NQoQJM8tJIQwLlBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL9OBQko5KoAmTZKqEuwrExdAZTg7xwGnzpCe1DHOCM=;
 b=QPVbzQ2uDuuJi1rkwR7bm4t5b1E0m5pE87FzDtN7F3FvO4vgfFVC9QNJpRGrZI+bY2uu3FP5igSrJZaH/mVcGg3yhdJLRpf8LIbyvNaYuetmjXhymTUS41lwWipHYZQlW52tcSNZ9gNMu3burI6O4OIE47MXJs0o8jxwsf6a5fjmz+TyOtv1Dme4ryp1aja+EdWRMNVbFv/mor+cRdbKHG5FYo2B5/iGfHv9nvPBUGKBVYhOrxgyY9W9l1t1l91ARpVvu09L8qAaCV6073vWeshDFZpN9CLRq7ZojTz8KCbQN0Sxi3sRcQaINsCsEHI3K9G2fW57qyNwHyVzHyvn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL9OBQko5KoAmTZKqEuwrExdAZTg7xwGnzpCe1DHOCM=;
 b=p7Who05EiiHRzGApT7ENcGGQFhM/I2ZfELVu5bNjfmG//an0OE+5puC07ZL26fcvzk3s+UcoPSEDnj8EF0Vkow/gwIBEw0Q2oTylbZax+Im+vxJYXcUFq33KN7OuOcKeDeOTf70uerVx1L3nXTrhmHrkcGutBgwXUGa9PAlamjI=
Received: from BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37) by
 MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 21:06:55 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::b9) by BYAPR01CA0024.outlook.office365.com
 (2603:10b6:a02:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:06:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/30] drm/amdgpu: remove job parameter from
 amdgpu_fence_emit()
Date: Wed, 25 Jun 2025 17:06:09 -0400
Message-ID: <20250625210638.422479-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 066f08f7-d4b7-48dc-c513-08ddb42c3691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8E/SZ0VbP3R7kLlrtEVxZO8EE7QltcgoPkMTlwapAktGDMFUv4Us1Smo7NHP?=
 =?us-ascii?Q?B6ADxcldO/EsDvtfAQ00oLAQ4gzZUf+xvVNIq8unponvS4Jbw7iQYWomNXle?=
 =?us-ascii?Q?O40wXyNqBLcXLuTVVmtXZGq9Q0LKt8+qWULysUib5C/X1qg5zYtKwXJNqaKU?=
 =?us-ascii?Q?ybjKVjxube4FQnHyjW0zNbBbAV8+/Jngi8j37O7mHIVY05d9Ewl1SElND5U3?=
 =?us-ascii?Q?quM+8uWFtoFvWCP4Nu3NYjplXmCnRsEr9e1/uYVHsSdFkmzt+qZxqCZsI4EK?=
 =?us-ascii?Q?CWMx2dM01jNdHZ9v7dXsgSsL0jqgNliDPld9CnmNv2V7R3Pkb8upYPs3oje+?=
 =?us-ascii?Q?6T86L1vC9ij2Z5VC3WEAuLr30ue9nX1ldTtPgcNr9djxV0s8g5LBc14bQHZX?=
 =?us-ascii?Q?jTZDHE2OIuuGfCE0aDUifJClP8oDIkxcMbJCr1Sy54+qz43J8sxXZHoKYoe5?=
 =?us-ascii?Q?8tFOb4lVU6xY2DCQlASO96ivvuiAawjmcIYpslEg12IaYQnet8pt+d9xYTUO?=
 =?us-ascii?Q?Scc5GwBJTV9tqHCKWCl4qbQ+RkmzbSJlUtHIuwqH2mYwg5I5nr8b9XgB6OeV?=
 =?us-ascii?Q?bN+uyK5F8orRCGeqLKcQO2C7wL1vVDrYSN6CDK0a326SzZIz1tSAThhET+wO?=
 =?us-ascii?Q?Fw1vyjWULoRBhHVz1mCW0R/1iH37v6xjZPiUNKJctwv848kGcaCFg1LzxafQ?=
 =?us-ascii?Q?KvXVNh145YwSdnQESuzjI+4p0dc775GESRYUu26ZIxv+Vkl45ccjUyiDHRll?=
 =?us-ascii?Q?X/FugxemyUYpCSB0wJgv7tGlo0WNzdQ7Wg5e+HufNkD+Rl8qVmXG1lu0Eqa0?=
 =?us-ascii?Q?t533pzIUrLipWbAukHZQKEEA9jauzPWyp7PkEFW3DMM2PDTgBiKZY92Fv81F?=
 =?us-ascii?Q?9eLYCr/Ukwg8jIlAn6OCs73Xgzjugxqb1NRL96KJy2yTZ1Wh+DWU1hy4GF0m?=
 =?us-ascii?Q?KszxrxJhMuKO0/XcQfJTzs9+8dwSIEe3aU81YFRQR//jcCzcUml1bIYKyiF1?=
 =?us-ascii?Q?PnpGiYPRUVvKsp6Ca/jlctAKmJHM28DH/YHZB/koceiC3jr7ZtR68oBbpSzp?=
 =?us-ascii?Q?zcCU77ez+vjaUBWSwPOay9AGXjM1QgCB9Zwjk76KhMhhwo53SY/x0YrvnfCz?=
 =?us-ascii?Q?2+bHIa8Hu8kWiQhl2fBZYMQXGbfDTP+ppMO2sW4pp0pm8IypEmh7VlQ+/Wjf?=
 =?us-ascii?Q?O3jO/rncn2Hhrs05GLuM+P0PTgIbnoI/KqeUUWWMM33nYxKV012GW7A58SFK?=
 =?us-ascii?Q?eVC5735/kQ30gwh70BItrZafdRKNz6SnMW3khfTfa6LmXZGio08G8KQ0qzDJ?=
 =?us-ascii?Q?MNCjJJOUzflbaPMQS6qoidcvY8PPJ8uvYKBRXAmwEy7yxpdN2gfV2u1I7NJ/?=
 =?us-ascii?Q?0ES9SGmeiAXebAWn9+iFUhmzr2z56/EXDgOQL+gP+kbNSHz3cIPjvXccIDra?=
 =?us-ascii?Q?Nu8BsMIDOZUq+auU59VW4i1yMI5j6Fz1Pe0ZTXz9V9y8+PXYzz4UmM3lBDww?=
 =?us-ascii?Q?WbJbIThNeUBCWejxbd4JUNk92WymuGgNTwEO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:06:54.2219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066f08f7-d4b7-48dc-c513-08ddb42c3691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
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

What we actually care about is the amdgpu_fence object
so pass that in explicitly to avoid possible mistakes
in the future.

The job_run_counter handling can be safely removed at this
point as we no longer support job resubmission.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 34 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c    |  5 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  4 +--
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index dc92952bf1269..2d6b2b486baf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -99,14 +99,14 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  *
  * @ring: ring the fence is associated with
  * @f: resulting fence object
- * @job: job the fence is embedded in
+ * @af: amdgpu fence input
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
-		      unsigned int flags)
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+		      struct amdgpu_fence *af, unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
@@ -115,36 +115,28 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	uint32_t seq;
 	int r;
 
-	if (job == NULL) {
+	if (!af) {
 		/* create a separate hw fence */
 		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
 		if (!am_fence)
 			return -ENOMEM;
 	} else {
-		/* take use of job-embedded fence */
-		am_fence = &job->hw_fence;
+		am_fence = af;
 	}
 	fence = &am_fence->base;
 	am_fence->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
-	if (job && job->job_run_counter) {
-		/* reinit seq for resubmitted jobs */
-		fence->seqno = seq;
-		/* TO be inline with external fence creation and other drivers */
+	if (af) {
+		dma_fence_init(fence, &amdgpu_job_fence_ops,
+			       &ring->fence_drv.lock,
+			       adev->fence_context + ring->idx, seq);
+		/* Against remove in amdgpu_job_{free, free_cb} */
 		dma_fence_get(fence);
 	} else {
-		if (job) {
-			dma_fence_init(fence, &amdgpu_job_fence_ops,
-				       &ring->fence_drv.lock,
-				       adev->fence_context + ring->idx, seq);
-			/* Against remove in amdgpu_job_{free, free_cb} */
-			dma_fence_get(fence);
-		} else {
-			dma_fence_init(fence, &amdgpu_fence_ops,
-				       &ring->fence_drv.lock,
-				       adev->fence_context + ring->idx, seq);
-		}
+		dma_fence_init(fence, &amdgpu_fence_ops,
+			       &ring->fence_drv.lock,
+			       adev->fence_context + ring->idx, seq);
 	}
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b39..206b70acb29a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -128,6 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib *ib = &ibs[0];
 	struct dma_fence *tmp = NULL;
+	struct amdgpu_fence *af;
 	bool need_ctx_switch;
 	struct amdgpu_vm *vm;
 	uint64_t fence_ctx;
@@ -154,6 +155,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = job->csa_va;
 		gds_va = job->gds_va;
 		init_shadow = job->init_shadow;
+		af = &job->hw_fence;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -161,6 +163,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		csa_va = 0;
 		gds_va = 0;
 		init_shadow = false;
+		af = NULL;
 	}
 
 	if (!ring->sched.ready) {
@@ -282,7 +285,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
 	}
 
-	r = amdgpu_fence_emit(ring, f, job, fence_flags);
+	r = amdgpu_fence_emit(ring, f, af, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e1f25218943a4..9ae522baad8e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -157,8 +157,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
-		      unsigned flags);
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+		      struct amdgpu_fence *af, unsigned int flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
 bool amdgpu_fence_process(struct amdgpu_ring *ring);
-- 
2.50.0


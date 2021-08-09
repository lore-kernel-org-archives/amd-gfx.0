Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CCAC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 03:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAB060234
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 03:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CAB060234
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A718F89B00;
	Mon,  9 Aug 2021 03:00:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4869989AC3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 03:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b90+4HrI9j361sAs32SLfkIlbiEVSuz3mU16K0N9Wh8qmF9MUlwFdxg05AThQpGWoEQYlkG+6tx+RSo2s/bEFqLvLX27L40xw7muv4nTi4hCuBH2HOGAi0+qQWb3dCC5n3+oXRwiY4VMKq0V6BSUA1/G3HTiWhv83TBFHj9YWFJwmmlBFiJZQtjbUZ2AH2aEKCgoqbIx/M7wCPXdowZaI9B7YKBKyakmC39ubZq4+iFOoZf22kc86ykqelk0aakYZYsPKwBU7Q0D9ZCpGsG8CLRLk7bDYS1Zmemez+hyHIlDkygDVr8xSke7Egs/d6IE6YeQw5uN2mp0wy1X7zx3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwAll4ywbnsGnZ+aH9LTm8pb93RZgrpSaQv8qFf4+Z4=;
 b=TAfxahGnvCJkUs5IBDZhJliibgZLYB2p1F/205LsX3/7YvfcfGew6dDuwnhYgho9TqG/zPF3+x/eacFlIiUCYNgLTJdnUVjSDo5Xp7MxB0ypDeMARtd76OZpKr47pBbCKGsPvXA5ubk1D8sG3z+JU8ugt0j2ee3+BCKy85ejihiv47HubQLGnJasHp4ChkRVcIwfeSpn/9af2kdBWP85N/X0jsV3qZB/VHxkNbz1QD09lfLVamF4+2hxXzJDZ0VgisFRXqSl4m9ioYMKTeO0Of4Vp+2xryUKfN6dIYrdxBQ8np7Tb+b2Kukq6RCLXJ1aBMONI36KIafkIrDaS9XoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwAll4ywbnsGnZ+aH9LTm8pb93RZgrpSaQv8qFf4+Z4=;
 b=cGVVU4ajSt20guI9Kjl3mjXe5fGSvpT0PTphR78U/XzGZkMIhkMOQSHu1tB6oNDbFDoqmgIYya4tZuiZp5v3grU9HIwmDSK/Z+mE2z9wozr3SLepw0KU5vqtUf4HuOyywHuNXdqOLy62vg8yW1r5pWfbJsS9uBznP23CN3/NQgU=
Received: from DM5PR13CA0061.namprd13.prod.outlook.com (2603:10b6:3:117::23)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 03:00:19 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::6a) by DM5PR13CA0061.outlook.office365.com
 (2603:10b6:3:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend
 Transport; Mon, 9 Aug 2021 03:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 03:00:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 8 Aug
 2021 22:00:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 8 Aug
 2021 22:00:18 -0500
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Sun, 8 Aug 2021 22:00:16 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, Jack Zhang <Jack.Zhang1@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Jack Zhang <Jack.Zhang7@hotmail.com>
Subject: [PATCHv3 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job
Date: Mon, 9 Aug 2021 10:59:50 +0800
Message-ID: <20210809025949.10278-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e2330f8-f39b-4193-12d0-08d95ae1d237
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29378F65CFF1D7DB87D1D873B7F69@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUUAxYa2OxpFVks0fD+nJJktgRimDB1M+8e0243niqjZlPiMXdegpzQYPnpc3zRik68vUfJqbBPulu9Lkprl7V6Zb3i4VThIyEPnIdTlrxBI0TEk365NzpVhH0FkKCzE2OuoWUwCac3JbIXcmuP+3oUSmV41+YZzj4faxCikzQPIKhSBIYuGiopVvyaJWzOjHE/p5CRKdhyU1hIKeOhxIwIQUYmIkymQcq3m1R/yNL50w3t0ilSqoek2s4f/pGva/ui5OP7a1IgkxXu2/neNkzgOoLsbxsqIJquizTgI6HyRI0xgHP2XFA/H6Sac2gB39/fMrgeOqASqfVfihT+1LPwksQnByTcTrI568Drs6zq96toTkoGq8UzVv9a6CthaH6DF8fpGlY/U2aFV1BNh1st2JUMf2HZO+W2f7851qVvJ5zZDEo1jimUx5WlmM1mO1rMF6V0hqXcaxdH2nXSwvGyUC89+e4PC7FWlhy4q5yOdiNiq6LWv91yN2csj3TuIF/MKWLawLXQ3Mpvz1xQI72tCOzMi3zX/mJTbmei01j4lkpaqKJmK6sdLK1jrXV6MuYTSamW24OIHXHK/2bZyIW53wuTcIAt/qqb+0y7DiuKWh+a70pTHi9Os2nofuu17VAJt4BzjHY5idyQvbUUY6ykDCselIsV+Sf96uWYxowKXRqnYB8akO/0a+dlOMZBx7YE/1kAyiGd8Nip8i0cObfWRVnu0d83rGG1c9LFM7RmrdDKHl/5B2+zXpM+sqEwl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(356005)(70586007)(26005)(36756003)(32650700002)(30864003)(186003)(5660300002)(82310400003)(316002)(45080400002)(4326008)(508600001)(7696005)(6666004)(86362001)(54906003)(34020700004)(36860700001)(336012)(1076003)(83380400001)(81166007)(2906002)(426003)(2616005)(6916009)(8936002)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 03:00:18.9402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2330f8-f39b-4193-12d0-08d95ae1d237
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
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

From: Jack Zhang <Jack.Zhang1@amd.com>

Why: Previously hw fence is alloced separately with job.
It caused historical lifetime issues and corner cases.
The ideal situation is to take fence to manage both job
and fence's lifetime, and simplify the design of gpu-scheduler.

How:
We propose to embed hw_fence into amdgpu_job.
1. We cover the normal job submission by this method.
2. For ib_test, and submit without a parent job keep the
legacy way to create a hw fence separately.
v2:
use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is
embeded in a job.
v3:
remove redundant variable ring in amdgpu_job

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 62 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 35 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 8 files changed, 82 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7b46ba551cb2..3003ee1c9487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 	ret = dma_fence_wait(f, false);
 
 err_ib_sched:
-	dma_fence_put(f);
 	amdgpu_job_free(job);
 err:
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 536005bff24a..277128846dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted && job->fence == fence)
+		if (preempted && (&job->hw_fence) == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 7495911516c2..c26eec660ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -129,30 +129,45 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  *
  * @ring: ring the fence is associated with
  * @f: resulting fence object
+ * @job: job the fence is embeded in
  * @flags: flags to pass into the subordinate .emit_fence() call
  *
  * Emits a fence command on the requested ring (all asics).
  * Returns 0 on success, -ENOMEM on failure.
  */
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
 		      unsigned flags)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_fence *fence;
+	struct dma_fence *fence;
+	struct amdgpu_fence *am_fence;
 	struct dma_fence __rcu **ptr;
 	uint32_t seq;
 	int r;
 
-	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
-	if (fence == NULL)
-		return -ENOMEM;
+	if (job == NULL) {
+		/* create a sperate hw fence */
+		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
+		if (am_fence == NULL)
+			return -ENOMEM;
+		fence = &am_fence->base;
+		am_fence->ring = ring;
+	} else {
+		/* take use of job-embedded fence */
+		fence = &job->hw_fence;
+	}
 
 	seq = ++ring->fence_drv.sync_seq;
-	fence->ring = ring;
-	dma_fence_init(&fence->base, &amdgpu_fence_ops,
+	dma_fence_init(fence, &amdgpu_fence_ops,
 		       &ring->fence_drv.lock,
 		       adev->fence_context + ring->idx,
 		       seq);
+
+	if (job != NULL) {
+		/* mark this fence has a parent job */
+		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
+	}
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
@@ -175,9 +190,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
 	 */
-	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
+	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = &fence->base;
+	*f = fence;
 
 	return 0;
 }
@@ -621,8 +636,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 {
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	return (const char *)fence->ring->name;
+	struct amdgpu_ring *ring;
+
+	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
+		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+
+		ring = to_amdgpu_ring(job->base.sched);
+	} else {
+		ring = to_amdgpu_fence(f)->ring;
+	}
+	return (const char *)ring->name;
 }
 
 /**
@@ -656,8 +679,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 static void amdgpu_fence_free(struct rcu_head *rcu)
 {
 	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	kmem_cache_free(amdgpu_fence_slab, fence);
+
+	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
+	/* free job if fence has a parent job */
+		struct amdgpu_job *job;
+
+		job = container_of(f, struct amdgpu_job, hw_fence);
+		kfree(job);
+	} else {
+	/* free fence_slab if it's separated fence*/
+		struct amdgpu_fence *fence;
+
+		fence = to_amdgpu_fence(f);
+		kmem_cache_free(amdgpu_fence_slab, fence);
+	}
 }
 
 /**
@@ -680,6 +715,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
 	.release = amdgpu_fence_release,
 };
 
+
 /*
  * Fence debugfs
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index ec65ab0ddf89..c076a6b9a5a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
 	}
 
-	r = amdgpu_fence_emit(ring, f, fence_flags);
+	r = amdgpu_fence_emit(ring, f, job, fence_flags);
 	if (r) {
 		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
 		if (job && job->vmid)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d33e6d97cc89..65a395060de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -127,11 +127,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	struct dma_fence *f;
+	struct dma_fence *hw_fence;
 	unsigned i;
 
-	/* use sched fence if available */
-	f = job->base.s_fence ? &job->base.s_fence->finished : job->fence;
+	if (job->hw_fence.ops == NULL)
+		hw_fence = job->external_hw_fence;
+	else
+		hw_fence = &job->hw_fence;
 
+	/* use sched fence if available */
+	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
 	for (i = 0; i < job->num_ibs; ++i)
 		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
 }
@@ -142,20 +147,27 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	drm_sched_job_cleanup(s_job);
 
-	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	kfree(job);
+
+    /* only put the hw fence if has embedded fence */
+	if (job->hw_fence.ops != NULL)
+		dma_fence_put(&job->hw_fence);
+	else
+		kfree(job);
 }
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
 	amdgpu_job_free_resources(job);
-
-	dma_fence_put(job->fence);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	kfree(job);
+
+	/* only put the hw fence if has embedded fence */
+	if (job->hw_fence.ops != NULL)
+		dma_fence_put(&job->hw_fence);
+	else
+		kfree(job);
 }
 
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
@@ -184,11 +196,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 
 	job->base.sched = &ring->sched;
 	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
-	job->fence = dma_fence_get(*fence);
+	/* record external_hw_fence for direct submit */
+	job->external_hw_fence = dma_fence_get(*fence);
 	if (r)
 		return r;
 
 	amdgpu_job_free(job);
+	dma_fence_put(*fence);
+
 	return 0;
 }
 
@@ -246,10 +261,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
-	/* if gpu reset, hw fence will be replaced here */
-	dma_fence_put(job->fence);
-	job->fence = dma_fence_get(fence);
 
+	dma_fence_get(fence);
 	amdgpu_job_free_resources(job);
 
 	fence = r ? ERR_PTR(r) : fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 81caac9b958a..7228172fb026 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -46,7 +46,8 @@ struct amdgpu_job {
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
 	struct amdgpu_ib	*ibs;
-	struct dma_fence	*fence; /* the hw fence */
+	struct dma_fence	hw_fence;
+	struct dma_fence	*external_hw_fence;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	uint32_t		num_ibs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9c11ced4312c..03d4b29a76d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -48,6 +48,9 @@
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
 
+/* fence flag bit to indicate the face is embeded in job*/
+#define AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT		(DMA_FENCE_FLAG_USER_BITS + 1)
+
 #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
 
 #define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
@@ -118,7 +121,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
 int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
 void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2a88ed5d983b..2af8860d74cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1218,7 +1218,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
 	if (vm_flush_needed || pasid_mapping_needed) {
-		r = amdgpu_fence_emit(ring, &fence, 0);
+		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
 	}
-- 
2.25.1


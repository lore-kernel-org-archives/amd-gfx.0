Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A01C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AB260E95
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1AB260E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE996E02A;
	Fri, 23 Jul 2021 04:42:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71926E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 04:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaVSj0gS9Y+9U/F4LQnKgY1xJNtVKQwmKv2Dqxx48AaCr8oRp6PCix2Y0dui3PDR7x9WROqmrVR3K8xV7WEowJPJAfUX0K2qHS4k7EnzEdjPDXCi9cmmwAe/H/7k2HWiY0XKe2ypn3WkfeRhH0quTaw4+s3rngtNo2lPigjtQ2xKISLjAxIumr0WBYIPxg8fM4aX23TS53PjZXZBnVVYFrl43/czZUwTqzEBL+x053IHykZ+ncWxJIMTUfIwhnICjs32VE1kR/sA6v2G4zuFIBdE4gJMo/MtDtTNP6iy2IjdBzDDgC0c19tQmF5gpEnKhNFYT1Uvr9Hfh5z58upITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihlp07N65PadTtWw0vv1ydRz8gJ5oyRefNbwfrRI0ek=;
 b=NibRNRsm0e1rQCKCmAulwrSDCtSslExZVSywlb1s/D7WgHzeIKUheWbc9w3mw+T5VroFZqR+ssMF4EiK85u88AcHcj4RK9Qmo1J/WzqM4yVlxMwXWPHATYIibctHvfNE+LCIgusUpCX5dRWiSKbCML6f3OPnSkPHJPRdRjzoDbk6BH5FdoptDjdOuf3Vn7xOXNHJEg+Cey+h5J10dxiph5Kj2RoqLD+kbBVWWAayuqHHjjrNQwDL9z6TqBLwAY2+ZLHgJ0lr+pvuBl5Jaxc8gcssgH52TkTa/zQTX89lcj6pwdtKfmIkX2OWo9H443k8l5nXmOswAfezy64ueW/rBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihlp07N65PadTtWw0vv1ydRz8gJ5oyRefNbwfrRI0ek=;
 b=B9Vm3GvOcyqkvdKdEQhGGwjhFl+idZpEynQyefRjljPc8T+r7psATrk3bBa7Bfd3CBK7I8RkT1BK/pvqEkAqKjMEHq/QpIcgRcU76kHFg54dmEOuqEIzbxIgVhxs67k80sGcZK9GxFHSU5bJj2rwwXyfuMUTRFF9IPnQF0Gus9E=
Received: from MWHPR22CA0059.namprd22.prod.outlook.com (2603:10b6:300:12a::21)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Fri, 23 Jul
 2021 04:41:59 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::af) by MWHPR22CA0059.outlook.office365.com
 (2603:10b6:300:12a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Fri, 23 Jul 2021 04:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 04:41:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 23:41:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 21:41:57 -0700
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 23:41:56 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu embed hw_fence into amdgpu_job
Date: Fri, 23 Jul 2021 12:41:37 +0800
Message-ID: <20210723044137.61682-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbb7cb7a-2fec-4f1c-87e5-08d94d943531
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:
X-Microsoft-Antispam-PRVS: <BYAPR12MB32871A2FF924E422C8C4BFB7B7E59@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUUK1A9neEj1QYwCR7PN5emdsGTXITLj6Dq7ocIcLG9H7mK1kE9UFrmQXiBghwJyi9MQ+pNTzcMoMUJErmkjlL1FCSqju7r3eHEWuZ7KIBbIfDrPDaTXnqzUqq+WXXK9s3wevy30GMXmxbfj+HbJCyLZdr7su7g9MF9JiDaj7wY6B5L6EmEVytrq45ls22uMtg5JIKRkDQxwRZfoCwamF530TlPtvnfYTG2eO2LRYFyh/3QAOu0I34c/1ANpYALSQo5PwXPCiPekMZxIZVawb1qtCNAh5ci4CFWpudN5wTOtkTXE7Kbp5TLu+JMCUvIM6rwlB6MELh4WhHtOIDcByhH20TegaKtAEG2FoVNWIQcsjNVCPycVGmOcnPSwr7MMHLubyCTh9v68iXPkR6b7oYqTK7KkVSbSw7CYziGkz5drBmeYhAvCsYFRbx1cT8BWQHgR7NwZfT6AG3Lh65LN6ZXfouIkuLOCU6IUPYt0gzqNFUcoeB19MYTh/HVa/fI4B+UnJ9vGrbzSsBfSoztQMoIndGStjnetZn8RZ0Z9GOyu8Ktdl7FEmPFZXn+62Wl7lCkGuyUJII3NGPhtYByZxHFdm9lvTWBbfphEarxgXmrXX0g9NCwSQvPuAj44vFyIxYAWlz2eIRnb28r642ZXjxZWFJikU7YIs/eVGgm0axHIPwJl1+UoaBOKDiFFydLpjRteqN/Q9G7TongLK92+pNOSNPIOR0E2UMNbTLqrVlE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(6916009)(70206006)(8936002)(6666004)(316002)(4326008)(5660300002)(30864003)(36756003)(186003)(83380400001)(47076005)(70586007)(86362001)(26005)(1076003)(356005)(82310400003)(82740400003)(36860700001)(2906002)(7696005)(2616005)(336012)(8676002)(54906003)(81166007)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 04:41:59.0803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb7cb7a-2fec-4f1c-87e5-08d94d943531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
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
Cc: andrey.grodzovsky@amd.com, Jack Zhang <Jack.Zhang1@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com,
 ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 62 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 35 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 8 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b6d33f13b476..bad403978bac 100644
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
index 30772608eac6..eecf21d8ec33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -133,25 +133,40 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
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
+		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
+		if (am_fence == NULL)
+			return -ENOMEM;
+		fence = &am_fence->base;
+		am_fence->ring = ring;
+	} else {
+		/* take use of job-embedded fence */
+		fence = &job->hw_fence;
+		job->ring = ring;
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
+		set_bit(DMA_FENCE_FLAG_USER_BITS, &fence->flags);
+	}
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
@@ -174,9 +189,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
 	 */
-	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
+	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = &fence->base;
+	*f = fence;
 
 	return 0;
 }
@@ -636,8 +651,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 {
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	return (const char *)fence->ring->name;
+	struct amdgpu_ring *ring;
+
+	if (test_bit(DMA_FENCE_FLAG_USER_BITS, &f->flags)) {
+		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+
+		ring = job->ring;
+	} else {
+		ring = to_amdgpu_fence(f)->ring;
+	}
+	return (const char *)ring->name;
 }
 
 /**
@@ -671,8 +694,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 static void amdgpu_fence_free(struct rcu_head *rcu)
 {
 	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	kmem_cache_free(amdgpu_fence_slab, fence);
+
+	if (test_bit(DMA_FENCE_FLAG_USER_BITS, &f->flags)) {
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
@@ -695,6 +730,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
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
index 759b34799221..7c426e225b24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -114,11 +114,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
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
@@ -129,20 +134,27 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
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
@@ -171,11 +183,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 
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
 
@@ -233,10 +248,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
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
index 81caac9b958a..92324c978534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -46,7 +46,9 @@ struct amdgpu_job {
 	struct amdgpu_sync	sync;
 	struct amdgpu_sync	sched_sync;
 	struct amdgpu_ib	*ibs;
-	struct dma_fence	*fence; /* the hw fence */
+	struct dma_fence	hw_fence;
+	struct amdgpu_ring *ring;
+	struct dma_fence	*external_hw_fence;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
 	uint32_t		num_ibs;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ca1622835296..2306424cbcb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -118,7 +118,7 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   unsigned irq_type);
 void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);
 void amdgpu_fence_driver_resume(struct amdgpu_device *adev);
-int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
+int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
 		      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
 			      uint32_t timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 358316d6a38c..0670f43ef22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1216,7 +1216,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
 	if (vm_flush_needed || pasid_mapping_needed) {
-		r = amdgpu_fence_emit(ring, &fence, 0);
+		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

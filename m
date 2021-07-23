Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9826C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A880260E95
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A880260E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE326EAD2;
	Fri, 23 Jul 2021 04:42:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5ECC6EAD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 04:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jER2Gj53n21pRptqt31SQCZVXnMMhRrKtvBs7MpLLbkpGbN8ET+BSYYh+o/IZ6dtJ9A/lnonwZnJMTNEwgth+AWpRMixBitrhFY2oPSeE7PgEHRyuGhFh/izk7eyrgDpfdQmBPl7eHRtcRX56vu8Qzr2VKM8HhfWHtT9gspyN9QZPaNrL9dbVE9UAX+fnZZUOF0+RR/SFItqHf9ZC5E+XGNb9bTAkeJTEhNTwMs+IlQWKebc1ik3y8g3QaOgTHfOY4X4FU6ztAIBm2pU3xNcYh8SAEZGMV5ugXq6UfIuhTFL71mpIqBkJBskJ94+dxqtxPvGmv/WjwVu9ebiCPvgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj3ToGx81DFvMkFBcGmNNucN/Bmv0bsB+kCc9+ujrus=;
 b=K/DOq50+7K3IW0WZrHGv041PjcHJIMg3y7ojv0R5u6bzwV0YG0LuObs525f2bLtm8lvTFzQAc9CNj+88VGV3lAuyUce7x7fHBWdUt94/ys3vwCDNDDr62p9Eaip/f+48nQlYs3AqcxMdyW0mwjp6xSOgTQKRroWhA8I1A8mUz3tENhu9DBTlsZTernb3gjeRCf+cAGbdS4X9AZqAQKGblMbKJOPIo2szfOE1xCJP6eDjzWjPAbGH9jzDFq6EUslfRN4jb3Mx/dqyFmhKsNB9QLgkRvo9hmffriuP987sIlMxiE0hZ31L6NrzLtEE/eKr6E3JzfE5+sB4RTrPM/UBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj3ToGx81DFvMkFBcGmNNucN/Bmv0bsB+kCc9+ujrus=;
 b=oQDdrHglZDvF73QNpK6GucfFnDud4PlzaIJjbPjPZuRoINV0OhGKcccPGHpMPjRPdhowPSP0sKlo3nHQhOwURsGEvmsU2AX9fMYJF6npbdBAF7PXd4aKmfc1rqGsV2Dbd/1LuTJUjzQn+xaCND5oV65dV/esimWqi5QgjzElAnw=
Received: from BN9PR03CA0577.namprd03.prod.outlook.com (2603:10b6:408:10d::12)
 by MN2PR12MB2927.namprd12.prod.outlook.com (2603:10b6:208:103::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 04:42:10 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::a7) by BN9PR03CA0577.outlook.office365.com
 (2603:10b6:408:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Fri, 23 Jul 2021 04:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 04:42:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 23:42:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 23:42:10 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 23:42:08 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm: add tdr support for embeded hw_fence
Date: Fri, 23 Jul 2021 12:41:39 +0800
Message-ID: <20210723044137.61682-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723044137.61682-1-Jingwen.Chen2@amd.com>
References: <20210723044137.61682-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5737f9d3-a9f2-4039-bfa3-08d94d943c21
X-MS-TrafficTypeDiagnostic: MN2PR12MB2927:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29271ACE3E27316917DC7C45B7E59@MN2PR12MB2927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLHcdTDgwj1FNCOn2t6nVcTaBdBIWuSSZFrvlzRpOYQ89vRLZomWUx61e7MRaHZmkwIMIuCl6bnTnIZ7chbv/HlfRofcuzKeSpUb7qTl6hp9unbh39zGmXAoqXeH6izZ6rX/if8TQX1GUyKWDqpAgdo+3tdH7Gk/Kctiqd6c968rhxkRLN7viGpK2nP9+l8cjrusTl7Xii/jb9mwk9lNxs9F6QsWHSf9rw5HpRagh8rlQv4wxka/H+OjxRt6s+Y6E/lS1BaL1GEZpSpo+bflp2sv1TezoAHSwhCrsJ/dqPPloFcvSN4fr0opPuKnZsbrUECqT7Ew8Wp4H4y9iWqgJyenrGqUYRDFHyBgf72YYCEe8ZEx5V4NXemurpy57o5xukiIAZYbLnoiZ6D0cl0fIyeHM7fDeR+tiL6rBA0H6+T12/OFUXVxOS163P3KYOOi0Psm51hh5EK/n1Sc00PrXe9rzQUXS2E/yUp/+uPvhrXbY/bdaR7ssC9+JzQfzyn9RCtAl1zLm6MvWkE2j0iy1c/FTOl/5ngx2s+Zuv8kxV5Vc1my6leTJBx/Llt/5Yj/e98+63unUa9398NVecJ7Z540R2N3KIBgf5BRfjL6q/1yCaYfeWt32rzbSj8gISp6VepXAz1sJtbikAlaQaZLGnQQMHgxtzw+3Ady1kLZwYx14R2gglCC9o8Je8P/9vHnHsqSzBpBJViaGUjedH01/exZjfVQ1Ghpa/GPCGVoWqw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(1076003)(4326008)(2906002)(8676002)(54906003)(336012)(36860700001)(2616005)(426003)(316002)(478600001)(5660300002)(6916009)(82740400003)(83380400001)(8936002)(70586007)(70206006)(36756003)(186003)(356005)(6666004)(47076005)(81166007)(86362001)(7696005)(82310400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 04:42:10.8459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5737f9d3-a9f2-4039-bfa3-08d94d943c21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2927
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
Cc: andrey.grodzovsky@amd.com, Jingwen Chen <Jingwen.Chen2@amd.com>,
 Jack Zhang <Jack.Zhang1@amd.com>, monk.liu@amd.com,
 ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
After embeded hw_fence to amdgpu_job, we need to add tdr support
for this feature.

[How]
1. Add a resubmit_flag for resubmit jobs.
2. Clear job fence from RCU and force complete vm flush fences in
   pre_asic_reset
3. skip dma_fence_get for resubmit jobs and add a dma_fence_put
   for guilty jobs.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 13 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  4 +++-
 drivers/gpu/drm/scheduler/sched_main.c     |  1 +
 include/drm/gpu_scheduler.h                |  1 +
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 280b1940e892..df73fe666e87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
-	int i, r = 0;
+	int i, j, r = 0;
 	struct amdgpu_job *job = NULL;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -4406,6 +4406,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!ring || !ring->sched.thread)
 			continue;
 
+		/*clear job fence from fence drv to avoid force_completion
+		 *leave NULL and vm flush fence in fence drv */
+		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
+			struct dma_fence *old,**ptr;
+			ptr = &ring->fence_drv.fences[j];
+			old = rcu_dereference_protected(*ptr, 1);
+			if (old && test_bit(DMA_FENCE_FLAG_USER_BITS, &old->flags))) {
+				RCU_INIT_POINTER(*ptr, NULL);
+			}
+		}
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index eecf21d8ec33..d5b3d5f8f951 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -157,10 +157,15 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 	}
 
 	seq = ++ring->fence_drv.sync_seq;
-	dma_fence_init(fence, &amdgpu_fence_ops,
-		       &ring->fence_drv.lock,
-		       adev->fence_context + ring->idx,
-		       seq);
+	if (job != NULL && job->base.resubmit_flag == 1) {
+		/* reset seq for resubmitted jobs */
+		fence->seqno = seq;
+	} else {
+		dma_fence_init(fence, &amdgpu_fence_ops,
+				&ring->fence_drv.lock,
+				adev->fence_context + ring->idx,
+				seq);
+	}
 
 	if (job != NULL) {
 		/* mark this fence has a parent job */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7c426e225b24..d6f848adc3f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -241,6 +241,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
 
 	if (finished->error < 0) {
+		dma_fence_put(&job->hw_fence);
 		DRM_INFO("Skip scheduling IBs!\n");
 	} else {
 		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
@@ -249,7 +250,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
 
-	dma_fence_get(fence);
+	if (!job->base.resubmit_flag)
+		dma_fence_get(fence);
 	amdgpu_job_free_resources(job);
 
 	fence = r ? ERR_PTR(r) : fence;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index f4f474944169..5a36ab5aea2d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
 			dma_fence_set_error(&s_fence->finished, -ECANCELED);
 
 		dma_fence_put(s_job->s_fence->parent);
+		s_job->resubmit_flag = 1;
 		fence = sched->ops->run_job(s_job);
 		i++;
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 4ea8606d91fe..06c101af1f71 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -198,6 +198,7 @@ struct drm_sched_job {
 	enum drm_sched_priority		s_priority;
 	struct drm_sched_entity         *entity;
 	struct dma_fence_cb		cb;
+	int resubmit_flag;
 };
 
 static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B0C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A48F600CD
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 13:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A48F600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213846E096;
	Wed, 11 Aug 2021 13:05:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8842B6E096
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 13:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqQ8Q7fW2cRGbzP3yC0WSkPYSiNhUBBATxd1/cJdQ0BWZH5ssZinysTItgki3UpjB51sbUQ6C51nTs1vPtLyvWrghtUPlKnWDIL9yp8zA+Z5/Og8mXWNwLoSHJmes9MCphBFNVvFdZKlGH2OfvHs/AG1nT963h+CuRppGm4wF68gJMzXdxeZd45oSmooeF/R1ICPMWwxFZr//bn6cphi34NuCPrkrbzu8XJcQGsBrEb07jtsUT/YPl2rXRG9BYGv1WtW99uqW0veUSRi+NSuj50huSYeXjD3TPbUzRcSGZ2F4hG8PnCkBvFsSXHEGcVsWdbYVEYwjoZkBpX1MrXaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddbQ+SrWxxuTr5ZbinQ6uVvFZqADn5gT4jf8tgHq9FI=;
 b=ATxkFvGXnGWyV7hxUFL/ZJyUjr/FLtL54PNNSS/NZsi3g6qhgsfjgwKd1Genq868k3zCXYPo28MPyCh29UsN5wrI6WvaSOrxY7C+WcnVDnLBN/W2XOu8ytiRA7eCV7/fS2K+2MHd0LbJQ+vBeniFuCtKOQq/J5rbuLUKsQpByDi+H6saSoV657v8kuw1sr144lbI824qy/MwuWjltd9Wphr83CdcTZMfMlXJ2lgBYsoO1gwn/yLcFPPpaJlbgVO1ldI06IYwIgrEowkG/yghX0I5aeiHYrL7WKcwkjzj7/dgj0x2XdtKqVDcfWJEaR4V7jN+7sH40SkKMFqqgSQ7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddbQ+SrWxxuTr5ZbinQ6uVvFZqADn5gT4jf8tgHq9FI=;
 b=4s2tYwljqy14/KlFeaCc9X4wplKLnxIZxGMR1lKYMKW1TK5zATYvNDTNl4IWvizhE0oG+mAoQLH/NxjoVPWDe/8pqlrB2eFbkZ/jCK1BO+XZ+9AW5xPNhWWilSyhSjL/Bh+Slm1B62IadH6opzesm341QFHj33Jmsd7NMNmQjxY=
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 13:05:13 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::f6) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Wed, 11 Aug 2021 13:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 13:05:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 08:05:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 08:05:11 -0500
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 11 Aug 2021 08:05:04 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, Jack Zhang <Jack.Zhang1@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Jack Zhang <Jack.Zhang7@hotmail.com>, "Andrey
 Grodzovsky" <andrey.grodzovsky@amd.com>
Subject: [PATCH v5] drm/amd/amdgpu embed hw_fence into amdgpu_job
Date: Wed, 11 Aug 2021 21:01:57 +0800
Message-ID: <20210811130156.375416-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef596d7-19d5-4598-5b44-08d95cc8a7cd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4917:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49176136DB2AD2F0E84CC860B7F89@BY5PR12MB4917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2G6zbdWaKwHeX1SJ7X4PsPAljVCBNA4+eSI2yeJEDZOYJ5yKyo1zTdcijNUO6ICt/YbebGsbkB87+OGBfxEjuykOuKL03XcQnKfVJ5RYcL7nvL7UcSvFVgPAqwPGSbCbxc1I9vaM+3/10bCe+CynLUOwlbNBwmstLbd6NV7bLYJxl3AfHxDHNFUvsumIvYdjPTb0RsLroWmLYVocQbB8aD39oTV/yDcFxZemi2w2477J+eorZWqSCcUnHwSeDzp/q63uH7TC+9KpmyL36azt51SUrZUWZIZ5Wdh3X5ttw+YoclffQBUhYBXDpZ2ia0VL/80PlwGLhj0oJC9dK1eCHtzZd0bIZarUWrmSC++Owkf3HSUyBNqweJpyQsAuS6CVGrJ/6uoOMlbFiukhpeOYN96V6eB2XzXD2LIHgSl2W5YM5AhPIztUecxvEukcvq5bhHMFIPMYxCMCfWdmSwBDr0+M23lcJtHb9EZVv3/ONhdkgKQij0lqpHPQJaFx4zyHV8G/3RkGV8cLmgXRG4nb3CJaGp0UUuAWin/CyAJ9/QoL/35s5QFgv2oWkqJk+29n7RJgGJnaa4sxa5Czt3NG8opuWZxQyDOIghVpEFl7FwnoGN4AMPndFNDVf/+iR0DAHt7jW17fyF9T0OO9b0w+aaChwGqNzV8IQdEyBY4mvADYv6P/4oFXTanaG5TiwtVZS63EIQyBA5SFyaaaXEjyOHCkgi3gIxQdcIQs/WTicHa03N41W3BAy5/G/T0zlPf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(186003)(83380400001)(478600001)(336012)(45080400002)(34020700004)(6916009)(6666004)(4326008)(82310400003)(81166007)(356005)(54906003)(316002)(36756003)(32650700002)(426003)(8676002)(86362001)(30864003)(36860700001)(1076003)(8936002)(70206006)(70586007)(2616005)(82740400003)(2906002)(5660300002)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 13:05:12.7224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef596d7-19d5-4598-5b44-08d95cc8a7cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
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
embedded in a job.
v3:
remove redundant variable ring in amdgpu_job
v4:
add tdr sequence support for this feature. Add a job_run_counter to
indicate whether this job is a resubmit job.
v5
add missing handling in amdgpu_fence_enable_signaling

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 86 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 39 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
 9 files changed, 119 insertions(+), 37 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4c33985542ed..04a6bed4e5f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4448,7 +4448,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
-	int i, r = 0;
+	int i, j, r = 0;
 	struct amdgpu_job *job = NULL;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
@@ -4472,6 +4472,17 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		if (!ring || !ring->sched.thread)
 			continue;
 
+		/*clear job fence from fence drv to avoid force_completion
+		 *leave NULL and vm flush fence in fence drv */
+		for (j = 0; j <= ring->fence_drv.num_fences_mask; j++) {
+			struct dma_fence *old, **ptr;
+
+			ptr = &ring->fence_drv.fences[j];
+			old = rcu_dereference_protected(*ptr, 1);
+			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
+				RCU_INIT_POINTER(*ptr, NULL);
+			}
+		}
 		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
 		amdgpu_fence_driver_force_completion(ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 7495911516c2..b439eb7d4177 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -129,30 +129,50 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  *
  * @ring: ring the fence is associated with
  * @f: resulting fence object
+ * @job: job the fence is embedded in
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
-		       &ring->fence_drv.lock,
-		       adev->fence_context + ring->idx,
-		       seq);
+	if (job != NULL && job->job_run_counter) {
+		/* reinit seq for resubmitted jobs */
+		fence->seqno = seq;
+	} else {
+		dma_fence_init(fence, &amdgpu_fence_ops,
+				&ring->fence_drv.lock,
+				adev->fence_context + ring->idx,
+				seq);
+	}
+
+	if (job != NULL) {
+		/* mark this fence has a parent job */
+		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
+	}
+
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
 			       seq, flags | AMDGPU_FENCE_FLAG_INT);
 	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
@@ -175,9 +195,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 	/* This function can't be called concurrently anyway, otherwise
 	 * emitting the fence would mess up the hardware ring buffer.
 	 */
-	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
+	rcu_assign_pointer(*ptr, dma_fence_get(fence));
 
-	*f = &fence->base;
+	*f = fence;
 
 	return 0;
 }
@@ -621,8 +641,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
 
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
@@ -635,13 +663,20 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
  */
 static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 {
-	struct amdgpu_fence *fence = to_amdgpu_fence(f);
-	struct amdgpu_ring *ring = fence->ring;
+	struct amdgpu_ring *ring;
+
+	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
+		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+
+		ring = to_amdgpu_ring(job->base.sched);
+	} else {
+		ring = to_amdgpu_fence(f)->ring;
+	}
 
 	if (!timer_pending(&ring->fence_drv.fallback_timer))
 		amdgpu_fence_schedule_fallback(ring);
 
-	DMA_FENCE_TRACE(&fence->base, "armed on ring %i!\n", ring->idx);
+	DMA_FENCE_TRACE(f, "armed on ring %i!\n", ring->idx);
 
 	return true;
 }
@@ -656,8 +691,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
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
@@ -680,6 +727,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
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
index d33e6d97cc89..de29518673dd 100644
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
 
@@ -246,10 +261,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
-	/* if gpu reset, hw fence will be replaced here */
-	dma_fence_put(job->fence);
-	job->fence = dma_fence_get(fence);
 
+	if (!job->job_run_counter)
+		dma_fence_get(fence);
+	else if (finished->error < 0)
+		dma_fence_put(&job->hw_fence);
+	job->job_run_counter++;
 	amdgpu_job_free_resources(job);
 
 	fence = r ? ERR_PTR(r) : fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 81caac9b958a..9e65730193b8 100644
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
@@ -62,6 +63,9 @@ struct amdgpu_job {
 	/* user fence handling */
 	uint64_t		uf_addr;
 	uint64_t		uf_sequence;
+
+	/* job_run_counter >= 1 means a resubmit job */
+	uint32_t		job_run_counter;
 };
 
 int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 9c11ced4312c..e713d31619fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -48,6 +48,9 @@
 #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
 #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
 
+/* fence flag bit to indicate the face is embedded in job*/
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


Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486AEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 05:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE0C64FCD
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 05:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE0C64FCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E216EABC;
	Thu, 11 Mar 2021 05:59:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17456EABC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 05:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqL+UeilFMEh9YukquJvHsKppEmIPF7PTeoajPDtEuTqLoAXVn86Thbpso4YSsK/1QqV2FN1F5dA+fNQca290ZhgXiNrXgU97i/aDX5S2oMCECN6xSJxJtFEMEj43bx2Y1rpF43XYXKeeWaOp/HC7t2TDD9p1koSs5pqxxV+f5Wc9hsamTRbi44gbTFm+HlV0xEJe8LYpioRcd6BgSNDBqHCnl4nlwuJKMEMXwyRK173x1o2GylFJzbN7pRdEjU/h1k3M+2ffEwMQFNtk5Ezpcm4NFUCwiyH6I9hVb2d3haBXo/3hRzvdb1AOL2eo+pcHipLn944YaYfiv+9ZLJCpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VooXserpiORwKXQRRmQ1xeN/sa/l9/nXb14FXdllj94=;
 b=LEfea10OwbzQAitTuRoqgMdG63chiJdyYvmJwnEqL11YhPZ0HuIKiKbFNK10s9eCD1aPBBy3yA1e2GwkGxNcOSY8zs+nOtBl59cEYP+6HIqJPAOEyu0bR9lTUT8vxyrZ2Aub6+xJtPyTYJuXTnj3O4gCoGRE1TbTZeD4POh4ZMiym3yljaQGTp/x/UZwOqSl1XY41UP3ejMcjuO5V0QwyzEfpZp/KCtY0EoBoEuNu9Z5HVeUY4cooXGSkwAMPIQbYVb2SknX1dxxnEbdsPcS/V7JUiq4yI+q4lC5tDNHlmMoWxixi0D1ZRHqVAjOODdJ/XropugpZHjZYSrRK91I/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VooXserpiORwKXQRRmQ1xeN/sa/l9/nXb14FXdllj94=;
 b=4KDKRBRrv7G/PHGAU5wzHS+MWaoaodbDWgjIE6iGl/4hGw9L69P8cS4BqFp2BAj8KdM9fTFFxucu68k4FbpPoOznvpjaCyr2sJWrQBtNLOXJhCRGjFJddG1ORS1wQNLSl9AhodPSO/qMSDELxcqYieQHrNzOA2oGaS38dfjUXis=
Received: from DM5PR19CA0015.namprd19.prod.outlook.com (2603:10b6:3:151::25)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 11 Mar
 2021 05:59:26 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::a3) by DM5PR19CA0015.outlook.office365.com
 (2603:10b6:3:151::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 11 Mar 2021 05:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Thu, 11 Mar 2021 05:59:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 23:59:25 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 23:59:25 -0600
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Wed, 10 Mar 2021 23:59:23 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>
Subject: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode
Date: Thu, 11 Mar 2021 13:58:38 +0800
Message-ID: <20210311055838.980188-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 074bb216-4aa4-4c1c-3dca-08d8e452d3a8
X-MS-TrafficTypeDiagnostic: BL0PR12MB4947:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49471DF39A837CFFE0BDA632BB909@BL0PR12MB4947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwDDJLfGeH/rO5IEeEWjl5xQwyYYEMlgyTCtR7R/yIuPj8owh8mp4/3iVyXQbNfCRLNXSePOwSLrlKuM20aclv7rh2HYdEOoQwgGeoEkSEhFlmnXvo13befW+7y47pL8tHA4OJF0KMMRMk4ip45E2y/B2q4fg5wuYT2KUkAAJQSk+qaWDsemYIfIUXADRQ2JsHpQdDXrbKb61hHwozQ/onAz5SyJIB//gs+pfJZfHxUru4bds13sbYVcye4HzsFGumI37a0wfGFXgrHRPT0YKyLfivhJvy7abcAmaGrXBa75MQHHkOo/wwjks6BHSGS2dAWABpPUg31+I5/5vWMSiFqxLSAzDxOzm3XdHniugbkYcmaZ4n0qnEDXHprJQUWFGtB/NLlxRzSNNsShv/yaJYs+HeUV9vHTbZnXnWEkVODCI5+MBtqpyuu305Nan1RT8SyPQo8w7Du540bnPQ5BedyR/f5mV9IBdKD8srY9drmwpa14gBWLriiVb/+2g00gGtoAbI+zOMmJQIyLU/lpATTloTZGQy1wNsF6yyBg/DK5txmlMa15ZH+d5iM8cNADgWL7aAHwXLiMPGp8/b2DvZ9c0GPHbZpTY+ISU3NhlAxJbuHWksXijldHt5yTJMNqh6O3FDlSFIflInHNXomyr+KgL7iOqntBfXhT7UtMIPCrVZNKBuayu3EmJQILfg2U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(83380400001)(86362001)(316002)(7696005)(4326008)(26005)(36860700001)(356005)(6666004)(70206006)(186003)(82310400003)(5660300002)(81166007)(47076005)(82740400003)(110136005)(70586007)(8936002)(2616005)(8676002)(478600001)(6636002)(2906002)(36756003)(1076003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 05:59:26.1395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074bb216-4aa4-4c1c-3dca-08d8e452d3a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Previous tdr design treats the first job in job_timeout as the bad job.
But sometimes a later bad compute job can block a good gfx job and
cause an unexpected gfx job timeout because gfx and compute ring share
internal GC HW mutually.

[How]
This patch implements an advanced tdr mode.It involves an additinal
synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit
step in order to find the real bad job.

1. At Step0 Resubmit stage, it synchronously submits and pends for the
first job being signaled. If it gets timeout, we identify it as guilty
and do hw reset. After that, we would do the normal resubmit step to
resubmit left jobs.

2. For whole gpu reset(vram lost), do resubmit as the old way.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  63 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
 drivers/gpu/drm/scheduler/sched_main.c     | 107 +++++++++++++++------
 include/drm/gpu_scheduler.h                |   3 +
 4 files changed, 142 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e247c3a2ec08..5b182ade26ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
+	int tmp_vram_lost_counter;
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -4788,6 +4789,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
+	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
 	/* TODO Implement XGMI hive reset logic for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
@@ -4805,6 +4807,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Post ASIC reset for all devs .*/
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 
+		if (amdgpu_gpu_recovery == 2 &&
+			!(tmp_vram_lost_counter < atomic_read(&adev->vram_lost_counter))) {
+
+			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+				struct amdgpu_ring *ring = tmp_adev->rings[i];
+				int ret = 0;
+				struct drm_sched_job *s_job;
+
+				if (!ring || !ring->sched.thread)
+					continue;
+
+				/* No point to resubmit jobs if we didn't HW reset*/
+				if (!tmp_adev->asic_reset_res && !job_signaled) {
+
+					s_job = list_first_entry_or_null(&ring->sched.pending_list, struct drm_sched_job, list);
+					if (s_job == NULL)
+						continue;
+
+					/* clear job's guilty and depend the folowing step to decide the real one */
+					drm_sched_reset_karma(s_job);
+					drm_sched_resubmit_jobs_ext(&ring->sched, 1);
+					ret = dma_fence_wait_timeout(s_job->s_fence->parent, false, ring->sched.timeout);
+
+					if (ret == 0) { /* timeout */
+						DRM_ERROR("Found the real bad job! ring:%s, job_id:%llx\n", ring->sched.name, s_job->id);
+						/* set guilty */
+						drm_sched_increase_karma(s_job);
+
+						/* do hw reset */
+						if (amdgpu_sriov_vf(adev)) {
+							amdgpu_virt_fini_data_exchange(adev);
+							r = amdgpu_device_reset_sriov(adev, false);
+							if (r)
+								adev->asic_reset_res = r;
+						} else {
+							r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
+							if (r && r == -EAGAIN)
+								goto retry;
+						}
+
+						/* add reset counter so that the following resubmitted job could flush vmid */
+						atomic_inc(&tmp_adev->gpu_reset_counter);
+						continue;
+					}
+
+					/* got the hw fence, signal finished fence */
+					atomic_dec(&ring->sched.num_jobs);
+					dma_fence_get(&s_job->s_fence->finished);
+					dma_fence_signal(&s_job->s_fence->finished);
+					dma_fence_put(&s_job->s_fence->finished);
+
+
+					/* remove node from list and free the job */
+					spin_lock(&ring->sched.job_list_lock);
+					list_del_init(&s_job->node);
+					spin_unlock(&ring->sched.job_list_lock);
+					ring->sched.ops->free_job(s_job);
+				}
+			}
+		}
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 865f924772b0..9c3f4edb7532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
  * DOC: gpu_recovery (int)
  * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
  */
-MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
+MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (2 = advanced tdr mode, 1 = enable, 0 = disable, -1 = auto)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
 /**
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d82a7ebf6099..bb0a129d1f40 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -361,40 +361,16 @@ static void drm_sched_job_timedout(struct work_struct *work)
   */
 void drm_sched_increase_karma(struct drm_sched_job *bad)
 {
-	int i;
-	struct drm_sched_entity *tmp;
-	struct drm_sched_entity *entity;
-	struct drm_gpu_scheduler *sched = bad->sched;
-
-	/* don't increase @bad's karma if it's from KERNEL RQ,
-	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
-	 * corrupt but keep in mind that kernel jobs always considered good.
-	 */
-	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
-		atomic_inc(&bad->karma);
-		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
-		     i++) {
-			struct drm_sched_rq *rq = &sched->sched_rq[i];
-
-			spin_lock(&rq->lock);
-			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
-				if (bad->s_fence->scheduled.context ==
-				    entity->fence_context) {
-					if (atomic_read(&bad->karma) >
-					    bad->sched->hang_limit)
-						if (entity->guilty)
-							atomic_set(entity->guilty, 1);
-					break;
-				}
-			}
-			spin_unlock(&rq->lock);
-			if (&entity->list != &rq->entities)
-				break;
-		}
-	}
+	drm_sched_increase_karma_ext(bad, 1);
 }
 EXPORT_SYMBOL(drm_sched_increase_karma);
 
+void drm_sched_reset_karma(struct drm_sched_job *bad)
+{
+	drm_sched_increase_karma_ext(bad, 0);
+}
+EXPORT_SYMBOL(drm_sched_reset_karma);
+
 /**
  * drm_sched_stop - stop the scheduler
  *
@@ -533,15 +509,32 @@ EXPORT_SYMBOL(drm_sched_start);
  *
  */
 void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
+{
+	drm_sched_resubmit_jobs_ext(sched, INT_MAX);
+}
+EXPORT_SYMBOL(drm_sched_resubmit_jobs);
+
+/**
+ * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
+ *
+ * @sched: scheduler instance
+ * @max: job numbers to relaunch
+ *
+ */
+void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max)
 {
 	struct drm_sched_job *s_job, *tmp;
 	uint64_t guilty_context;
 	bool found_guilty = false;
 	struct dma_fence *fence;
+	int i = 0;
 
 	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
 		struct drm_sched_fence *s_fence = s_job->s_fence;
 
+		if (i >= max)
+			break;
+
 		if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
 			found_guilty = true;
 			guilty_context = s_job->s_fence->scheduled.context;
@@ -552,6 +545,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 
 		dma_fence_put(s_job->s_fence->parent);
 		fence = sched->ops->run_job(s_job);
+		i++;
 
 		if (IS_ERR_OR_NULL(fence)) {
 			if (IS_ERR(fence))
@@ -563,7 +557,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 		}
 	}
 }
-EXPORT_SYMBOL(drm_sched_resubmit_jobs);
+EXPORT_SYMBOL(drm_sched_resubmit_jobs_ext);
 
 /**
  * drm_sched_job_init - init a scheduler job
@@ -903,3 +897,52 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	sched->ready = false;
 }
 EXPORT_SYMBOL(drm_sched_fini);
+
+/**
+ * drm_sched_increase_karma_ext - Update sched_entity guilty flag
+ *
+ * @bad: The job guilty of time out
+ * @type: type for increase/reset karma
+ *
+ */
+void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type)
+{
+	int i;
+	struct drm_sched_entity *tmp;
+	struct drm_sched_entity *entity;
+	struct drm_gpu_scheduler *sched = bad->sched;
+
+	/* don't change @bad's karma if it's from KERNEL RQ,
+	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
+	 * corrupt but keep in mind that kernel jobs always considered good.
+	 */
+	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
+		if (type == 0)
+			atomic_set(&bad->karma, 0);
+		else if (type == 1)
+			atomic_inc(&bad->karma);
+
+		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
+		     i++) {
+			struct drm_sched_rq *rq = &sched->sched_rq[i];
+
+			spin_lock(&rq->lock);
+			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
+				if (bad->s_fence->scheduled.context ==
+				    entity->fence_context) {
+					if (entity->guilty) {
+						if (type == 0)
+							atomic_set(entity->guilty, 0);
+						else if (type == 1)
+							atomic_set(entity->guilty, 1);
+						}
+					break;
+				}
+			}
+			spin_unlock(&rq->lock);
+			if (&entity->list != &rq->entities)
+				break;
+		}
+	}
+}
+EXPORT_SYMBOL(drm_sched_increase_karma_ext);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 1c815e0a14ed..4ea8606d91fe 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -321,7 +321,10 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
 void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery);
 void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
+void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int max);
 void drm_sched_increase_karma(struct drm_sched_job *bad);
+void drm_sched_reset_karma(struct drm_sched_job *bad);
+void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type);
 bool drm_sched_dependency_optimized(struct dma_fence* fence,
 				    struct drm_sched_entity *entity);
 void drm_sched_fault(struct drm_gpu_scheduler *sched);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

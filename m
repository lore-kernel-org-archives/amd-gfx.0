Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD56DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 11:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB2B60190
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 11:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB2B60190
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85BB6E18E;
	Wed, 10 Mar 2021 11:19:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2E76E18E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 11:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdOXDrji6l0ka+dSFx6FuiQ7HtGOmchQicohB0f27bZI6m9E6Y+h1e5fodBmOIX7gMarxw47CUY7us6XnJEFYFfz12WNSuds6e4NeN4M5UTVe/B1geBlirTZh/HFc5lFTHZi+89kckChIsK0m8uBHDr7ZugtbarIvLBUvyoRLJuO6AUY4gST7pAKTfVXybAIwDuJbVqP/zi4vKO7/4Z9+6xdE/hd381zowN81DCQ3rkvnocoL8g+2z2VihECV49aSXBQ0u8vJjcE5A5AsqYBdKm2XvEuUAvuzQnZzgWMM2lJd7BzeJvp4fVo6mGdfFveMR9uzxpJu6Z/46p2AgVqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clq/MnjD4w4f6E7pK+2yQl1Gi7pcQ1Z9X2CvBMMdGEI=;
 b=MPZItT4PJnw1fYn+4g6w2rwMgaaCqmcrhSwym4/2GEeKxI3/HPwvg/Tn0/5RUGd6ffAnfjGsa/8fsqJ7t5oVopacNVMltv40FmJQ0pOvQYrDJFDmxbyBwJnF8hwPGDDEcN28R1e7jsHE23GoqvV9fAr8iBTcYf1f9bjEFDR6R4554Vow8t6lDrQx6GnQGfRb+E2awlBwhNwXRsNb1jsIIjisU9dL8mRmoX0XJduxf3ymCAvWykfP9SfH6N2k4piFMqmpkS/xvQfnPPn9NGuikEIcsY4s3L9yMWkT0dnucbhZ80YOla++TsbNpWw2WR2X3LE6Qmz26HBDg0WDcL6zig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clq/MnjD4w4f6E7pK+2yQl1Gi7pcQ1Z9X2CvBMMdGEI=;
 b=uB31sUX4Q9a+BLZW20gFznj2j/nK8Yab7nhXmvXceoWwN3mj8CwlnRoYWYPxVvIQnSq9v8noeSyAlsgo3Y4Cl2QPFJxD9MErXqu2F3xdUy92ib08yRpGUp40Bfg9CmCiBRNmYQ24NoNyoffJ/JHmiQepPuimAw+wtmeniorixQY=
Received: from DM3PR12CA0056.namprd12.prod.outlook.com (2603:10b6:0:56::24) by
 BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.8; Wed, 10 Mar
 2021 11:19:35 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::28) by DM3PR12CA0056.outlook.office365.com
 (2603:10b6:0:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 10 Mar 2021 11:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 11:19:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 05:19:33 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Mar
 2021 05:19:33 -0600
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Wed, 10 Mar 2021 05:19:31 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>
Subject: [PATCH v4] drm/amd/amdgpu implement tdr advanced mode
Date: Wed, 10 Mar 2021 19:19:21 +0800
Message-ID: <20210310111921.928619-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41bcb0a5-1be4-45fa-b7bb-08d8e3b66214
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53229B7CC0EEA9AC13755FE3BB919@BN9PR12MB5322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFW9jpnYAzb8gMChYjbu+P035Jq1CDbUkFPEerfDFr12t5THIm/ujuJf2WR+0hkN1qnUQOU6Tm/OoV4wPq9zbmP8KbgBmbcM11wZG3s6mMi1FY2EZxK3hHhJdV0lWbmj59u/EMvcJ6vyhYPeS/eoFD1nZE0yc66tEjCdUfJUURI+P6PakSaWFoFfeXucOINhgu1CEQd4Cg3S5F1zjaRgmpLMHALs3Kjllp0lsc3i79h4lC4XH/CUwjp6kS0gGQs0+hGV2vo4ghTilXKxSTtho+m0QtUwJY0+naT6b2RYs3QudUCkoI6YaNdtNh/4O/Hj9dpFsWvnNCm36A/xvcoSjNNseVC20ZameICMv51lCF0KIBep6FLy7iVKP5dqCD+AtC8pWmkKeJW/VDWb9qbZnwb+RzkBSESfPMrQ2+fE8f8eakNP9boy10leU2yTSPJZvkb/jzR5JGVUJgnYnumZPiXHnbIM/gcWyc6k72M1cnTcvK/6h44AVgVnpSLAKZeEuHAI455gP9bJtXnkbw8AV+MFT/3Tc0mDPvVveHQmI/nmbM46zy9M8BTBgCxwid92sRz3m1Mlv4rU63iCrRZJW0F+vJPBDG8G57s4r8KObea/bpXm8CKt/j5ERnY0MkntAjf4Jl1kHaiW0LiXBEDFPxy4sJyg7lau9r6NilDDa9Ax1LJ70lNZ3FgnyulPA6/G
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(8936002)(478600001)(6636002)(336012)(2906002)(36860700001)(426003)(26005)(186003)(36756003)(4326008)(2616005)(82310400003)(8676002)(81166007)(82740400003)(70206006)(47076005)(356005)(83380400001)(6666004)(70586007)(1076003)(5660300002)(7696005)(110136005)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 11:19:34.1043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bcb0a5-1be4-45fa-b7bb-08d8e3b66214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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

2. Re-insert Bailing job to mirror_list, and leave it to be handled by
the main reset thread.

3. For whole gpu reset(vram lost), do resubmit as the old way.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
Change-Id: I408357f10b9034caaa1b83610e19e514c5fbaaf2
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c     | 75 ++++++++++++++++++++++
 include/drm/gpu_scheduler.h                |  2 +
 4 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e247c3a2ec08..02056355a055 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4639,7 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
-
+	int	tmp_vram_lost_counter;
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
 	 */
@@ -4689,9 +4689,14 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
 					job ? job->base.id : -1);
 
-		/* even we skipped this reset, still need to set the job to guilty */
-		if (job)
+		if (job) {
+			/* re-insert node to avoid memory leak */
+			spin_lock(&job->base.sched->job_list_lock);
+			list_add(&job->base.node, &job->base.sched->pending_list);
+			spin_unlock(&job->base.sched->job_list_lock);
+			/* even we skipped this reset, still need to set the job to guilty */
 			drm_sched_increase_karma(&job->base);
+		}
 		goto skip_recovery;
 	}
 
@@ -4788,6 +4793,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		}
 	}
 
+	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
 	/* Actual ASIC resets if needed.*/
 	/* TODO Implement XGMI hive reset logic for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
@@ -4805,6 +4811,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
+					drm_sched_resubmit_jobs2(&ring->sched, 1);
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
index d82a7ebf6099..99a6a8bddd6f 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -395,6 +395,81 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
 }
 EXPORT_SYMBOL(drm_sched_increase_karma);
 
+
+void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max)
+{
+	struct drm_sched_job *s_job, *tmp;
+	uint64_t guilty_context;
+	bool found_guilty = false;
+	struct dma_fence *fence;
+	int i = 0;
+
+	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
+		struct drm_sched_fence *s_fence = s_job->s_fence;
+
+		if (i>=max)
+			break;
+
+		if (!found_guilty && atomic_read(&s_job->karma) > sched->hang_limit) {
+			found_guilty = true;
+			guilty_context = s_job->s_fence->scheduled.context;
+		}
+
+		if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
+			dma_fence_set_error(&s_fence->finished, -ECANCELED);
+
+		dma_fence_put(s_job->s_fence->parent);
+		fence = sched->ops->run_job(s_job);
+		i++;
+
+		if (IS_ERR_OR_NULL(fence)) {
+			if (IS_ERR(fence))
+				dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
+
+			s_job->s_fence->parent = NULL;
+		} else {
+			s_job->s_fence->parent = fence;
+		}
+	}
+}
+EXPORT_SYMBOL(drm_sched_resubmit_jobs2);
+
+
+
+void drm_sched_reset_karma(struct drm_sched_job *bad)
+{
+	int i;
+	struct drm_sched_entity *tmp;
+	struct drm_sched_entity *entity;
+	struct drm_gpu_scheduler *sched = bad->sched;
+
+	/* don't reset @bad's karma if it's from KERNEL RQ,
+	 * because sometimes GPU hang would cause kernel jobs (like VM updating jobs)
+	 * corrupt but keep in mind that kernel jobs always considered good.
+	 */
+	if (bad->s_priority != DRM_SCHED_PRIORITY_KERNEL) {
+		atomic_set(&bad->karma, 0);
+		for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_KERNEL;
+		     i++) {
+			struct drm_sched_rq *rq = &sched->sched_rq[i];
+
+			spin_lock(&rq->lock);
+			list_for_each_entry_safe(entity, tmp, &rq->entities, list) {
+				if (bad->s_fence->scheduled.context ==
+				    entity->fence_context) {
+						if (entity->guilty)
+							atomic_set(entity->guilty, 0);
+					break;
+				}
+			}
+			spin_unlock(&rq->lock);
+			if (&entity->list != &rq->entities)
+				break;
+		}
+	}
+}
+EXPORT_SYMBOL(drm_sched_reset_karma);
+
 /**
  * drm_sched_stop - stop the scheduler
  *
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 1c815e0a14ed..01c609149731 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -321,7 +321,9 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
 void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery);
 void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
+void drm_sched_resubmit_jobs2(struct drm_gpu_scheduler *sched, int max);
 void drm_sched_increase_karma(struct drm_sched_job *bad);
+void drm_sched_reset_karma(struct drm_sched_job *bad);
 bool drm_sched_dependency_optimized(struct dma_fence* fence,
 				    struct drm_sched_entity *entity);
 void drm_sched_fault(struct drm_gpu_scheduler *sched);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

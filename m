Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D00C12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E6560FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E6560FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B536E8D1;
	Wed, 21 Jul 2021 03:14:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F303D6E8D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 03:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPqibmIzdkqOfUdiwNZgpsIU3IhBXGmlJ7ueB+IuNMJc3JfNN2Uob7rZL2x7cSYAVJ8MlIvZVuX81Qhlizn+jzsQxAbYlfzwOumxS1RI0wWbCeX+fcArrRQ0YlRe2D5Y6En9Rk0i0stxPCzqgZg9CDWiLSpA475/q36hzGPjwWQpbZ81JXJ+buSnB8UFHb2eU7ruUR5v57Pg4uU5/Q/x+ili99FVLpLFmdIcPUVQD8INeq7PTE8mWMeYLp8XlTzb2YzB1s4u+LCieo9RFL8IrKuI7gTc2G1sTNLBkZ4/Lep8FzJIERUXUmBeDVr4fpCT9LdvwTulzwseuWyfiRCCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riI6CEh8BTlyQ3uuR1JvU376jrjsYYr2QDNDdMt1/Ws=;
 b=TUZjUq3FZknoY+RteIxPlmhqYEmjdEHQRudInNy/AoqvVqBt23d1rUAysigzEVsvi4jZuy3xZyMvj5FFGVFT5jTON9V6lHEq0nPiVim+Oj8c9NJs64kM/vYwIr49BkOiiE5nybKRBmd8RPSCgRZBtjqc8ARxFDK/ehMiyGnxbDqJ/YMy9c0H3rNLx0hbZzqcpe8NlNiOH13hHhwrOUk8sAddrmBxoPxTitLF6ZDAQMqurYO4OD4NiTCG2kBvLRDDSu9RqHDSY3Vkl84HRFEtL4gf279AZBdzwRQPdPggrTnXWMloQWrJTjjV5fxXdP4ItVn18aisrz4zFa4MiSAIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riI6CEh8BTlyQ3uuR1JvU376jrjsYYr2QDNDdMt1/Ws=;
 b=SUrVF3L6WJJotyzEpTuzYJA8kcHfnofVzYisWF6AQszqg1n/NXHGv2yg101aRtZqeLHFRW4JhNCF5ywYMjyJnRYodjWbznCYgr87bh+vzR2UivX5KgE7ipusy5Va4GeqGaao0/k94r5btpMZCWyC//jHOJGt8AWRTsyg1HI3KQY=
Received: from BN6PR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:405:4c::26) by CY4PR1201MB0263.namprd12.prod.outlook.com
 (2603:10b6:910:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 03:14:48 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::a8) by BN6PR1201CA0016.outlook.office365.com
 (2603:10b6:405:4c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 03:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 03:14:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 22:14:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 22:14:46 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 22:14:44 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Date: Wed, 21 Jul 2021 11:13:54 +0800
Message-ID: <20210721031352.413888-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819fb884-3f28-4668-2c8e-08d94bf5b27b
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0263:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02633A9001F6FBE09E446214B7E39@CY4PR1201MB0263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPvlIHnGQnPqsid9itedCjgXp5H9pKNC0VyMUHoI9kS9TA4vFn63BwZjnSSvZqN6mnRjuamytabDZGxxlRSHKTfqShey7SQOCXnCqiVtafBEIemMwFdg0rh7PJSeSz7ZguznBbkkz/qSeWohtj/HWDBBOXHqjE33ls+DJ4M2uBArvCFwpaR95Yp2O9dApMLeXXsfrs8e7N8YsuENVcrbqQ2KiYEo0lPfl/2X1JlqsR3EkpkETKSsSThZlQtfyISc+tWTjhLn2Z/A1suBvqxf2AFXqpOlDvU3g9WHu6hsB5gi1NkB1g4aRXhBuDGkQFNIlkRfNxc9wsViASVRigpKeSOYXOwIEPD1R0dgBlrOEbQWTf9EpssIPMAjVFTkgXh0O8xU3BtPFsmNAmJieRhTQx8K7HfZ3FikwJa1doKql+/CvgDdEymgVm4jSN2fJg2OD6jY2XJQmWBRqGOEQVx1HzAo0Ev1z0TgHY+6oy943J8XQSFQds4fPkne17YgE+8/yFhxZ3gZp9x5LckHgZed5rw4WNTkgeaez/5ULUKNenlzROYpwilX7MMXWa0BU0WBR+zpY9uLqkKQ2/FMXtkPfHA+HVFCP0Bt79T1qxNCNRWEYLpVat9ePcmGsdlzs1TTzHxZpqxNG1UVNOSWmoVomMWy83eLUa2EFw7wShI5CmPB6h+eP1CVyoiH8ZeZyFbuXEClDJDPANL+Vdx638V3TQgkAo5sjpffbHkpkNGfrUM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(6916009)(4326008)(2906002)(186003)(426003)(8676002)(1076003)(86362001)(82310400003)(6666004)(336012)(26005)(47076005)(8936002)(36756003)(316002)(83380400001)(70586007)(2616005)(70206006)(356005)(5660300002)(81166007)(7696005)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 03:14:48.2593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819fb884-3f28-4668-2c8e-08d94bf5b27b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0263
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
Cc: ckoenig.leichtzumerken@gmail.com, horace.chen@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com,
 Jack Zhang <Jack.Zhang1@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 16 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  4 +++-
 drivers/gpu/drm/scheduler/sched_main.c     |  1 +
 include/drm/gpu_scheduler.h                |  1 +
 5 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 40461547701a..fe0237f72a09 100644
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
index eecf21d8ec33..815776c9a013 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		job->ring = ring;
 	}
 
-	seq = ++ring->fence_drv.sync_seq;
-	dma_fence_init(fence, &amdgpu_fence_ops,
-		       &ring->fence_drv.lock,
-		       adev->fence_context + ring->idx,
-		       seq);
+	if (job != NULL && job->base.resubmit_flag == 1) {
+		/* reinit seq for resubmitted jobs */
+		seq = ++ring->fence_drv.sync_seq;
+		fence->seqno = seq;
+	} else {
+		seq = ++ring->fence_drv.sync_seq;
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

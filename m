Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF7C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD1A60E8E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 04:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABD1A60E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0056F892;
	Fri, 23 Jul 2021 04:44:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591356F892
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 04:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHQruOoecvpgCMbnOWCrBSyHjWL9A4IlbeN+PTf4ovCUrUGsEdmZVuuLJb5TmHkqHepnnrhw0QWAPJma4P8ZraBzloNyAPYjhFWOxEm2Kcy8FD2dMyzba185WE6ZprEjxOMJEMjsoPtQeqOppFAaNh7iaK/pTOYtVAEVn4oRPrH+FGTfQtOuHXRQkX/gu3M3JFdO8lND0kB3V3DfBxHvmX5S0aLKKXz2KumDA5ks17Edn5q1w5xEWcYvVJj3dEwDTDFkBpbJbLW4bIgzBaWBnJzs1X1HiG/b41FE8J5ZBEaEg68KM0f6gd3vwEyoF0mv2cnxD0i3w0rx/dZeGc8lQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj3ToGx81DFvMkFBcGmNNucN/Bmv0bsB+kCc9+ujrus=;
 b=fZu9quIBrpX7nLlHoWKCEB+WKXcqgyf0u8L2Tyr5bNXL5XJT155T1sj3zLXsBg5HaNCZSkwns1pcLAXNvaL5jpzTw4yN5k6EA+giSAUKMG8Gpda0b1HQ8r18bIEKHhv/O1GCD4hsuB6ib5k/XAAVmWhW5VrKBkKypeC8XGcTd85pfNlOorIKrZdH4GQAnBnKnyngtFSJkH14DGIW9STmyfaAwmn5+wIFaa5ep2spBGe+Fg9iB6ELCzohostSXnvX/bigX+GohEAOwkZ0qA5C2UJqyTab2aA5B6dkp7ZAP3r95aKRyBMxWlC0Mn6Vkx15MsG8e7ASWgy8KO4YQz4PjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj3ToGx81DFvMkFBcGmNNucN/Bmv0bsB+kCc9+ujrus=;
 b=v//5apybHWkB+c+cnAoTswjuOsct2XGt5ddS3H30vFU1ZidOVQ9DsuLmU0uPxqjwZ6yD2eZBBkYIGTndI+4d3WBM6FwDzGZWbDx+OwLnE3/nzXunbJOP9GuFRsls4hb7tYms7ZGMk+ZBp/Pii/RYyxKdUUmaAAK18H3jeWzhZrI=
Received: from MWHPR15CA0057.namprd15.prod.outlook.com (2603:10b6:301:4c::19)
 by MWHPR12MB1168.namprd12.prod.outlook.com (2603:10b6:300:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 04:44:42 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::4f) by MWHPR15CA0057.outlook.office365.com
 (2603:10b6:301:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Fri, 23 Jul 2021 04:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 04:44:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 23:44:40 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 23:44:38 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm: add tdr support for embeded hw_fence
Date: Fri, 23 Jul 2021 12:43:46 +0800
Message-ID: <20210723044344.62009-2-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723044344.62009-1-Jingwen.Chen2@amd.com>
References: <20210723044344.62009-1-Jingwen.Chen2@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2c3c05-243c-41a2-ebb9-08d94d949633
X-MS-TrafficTypeDiagnostic: MWHPR12MB1168:
X-Microsoft-Antispam-PRVS: <MWHPR12MB116881C675DF3043646F7FBCB7E59@MWHPR12MB1168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/WfMaw2hBSx8r61hg04mkOzqCI3FIoBdjqyOw2yUEls7HDXBQYBDDB2o28ZYxH5H2QubCGIloEXBa8iDMHQPTC7nOQp7fyLH/15nLa9ufDbgBlZmz0m43+F6BpoWTrLFqCGX8qfvzs3HmGZcZKxRPp/7tYpGPdgeSKNP2SHLsZAvzcT/77ZdZ5vW3L0kxt0XvDWyGULOUKeQ0CPcEq/emNrcgwrH/S7lYAZNK+S2O817jJYImMsp2CixRfUn8tm/ait+CH7Qm5K5dE6kl+tnC+45NH7v/q+RraCiDUmvEFZfFRhdYd+bk8s5Bl15KEJQvb8lWOLbFPUDPBGXnzy68oUcYo822wrZIBQcaufDdcOa6jSv366Iw2KA2amBOjS9lMICLtbm8FvkNSpD06+e4AzTtmb+03Tz/y5yjVoZFDQyx0kZMCW3BCnyvSLOAxEf/N+46fE/bkCr4ml08ho3f8dwdY25eKCKEfMaiLGh3i3oIMbIZVQy4EPXB92Jv7Cah9USVTVpE44IEjbvDnAPVjA1RVYiQl3mNYo8Ib57Z6eIM7ND3ndr536EL9TQNK6Lqi1G750FOtMYRVZ8j6vMDQiH0XU65AmYKbZGYu/sl2ofGkPFeFskFjY5e1UPl0H4Xr+G2Ifw9oO3dGYc9sb7aTITIgLySe3tCYG356vUrM79XdfxHdl9MXwUOw1vL2DYXXmZaVV3Bl3CUJEK02AZUuOREsw/tq0hqbYJ+LLkTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(5660300002)(82740400003)(6916009)(86362001)(36756003)(4326008)(186003)(54906003)(316002)(36860700001)(81166007)(336012)(1076003)(47076005)(83380400001)(82310400003)(356005)(26005)(2906002)(426003)(478600001)(6666004)(7696005)(2616005)(70206006)(70586007)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 04:44:41.8280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2c3c05-243c-41a2-ebb9-08d94d949633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1168
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

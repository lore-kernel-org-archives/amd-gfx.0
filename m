Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CB5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 10:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B59C10EBB5;
	Thu, 17 Feb 2022 10:38:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A310910EBB5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:38:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdk8wsoYOx17ekDkYVLDRSx8Bs0+A+Egl9Ygriicm3HLJsUhErVkrZBwVFryVpmpP04ubdmKr1wpbQuJVYqeLuq0dqxEFtUGIWARmm1X1YnbM9ImCkzwN3wja020Oq10ohkfXQfsSqrivi61gY5lHNkUyY0utAYdwZvqIELdnOpsYnEipLfeRFNbkSE4p9aQRkwic2459yeiYmSWSwsXac+ZMNsRLM7S0Jgrm7e6AX+F6aF+4wxYcbyKerTLDp9Yf9THlqv8QzSH00qPuqEmfn0CHX4bRIqKYBed2jA/CSBqpWAP7Y15yDS/nrqp0hLYeDwz1H4EXJmhMlKAFIKe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c51CkAFJdka9VkxLGD+QIh9TTX9Z8GTWkf08iAJ8eI=;
 b=T2WcEX4jkkRUIKk9Jj9IwqpVfw1Hse7VAbZqb9CuchqY6J5J+HiVkYDwAihTduxTbtlOwwtYdmQF5VgBT8hX3WsCkjVpFflgmt5UjAgwURdnRxdcB2jUYMf4GdqeIoFJnV37v5lyK3UT5UwuFq8O7PdZi1NKfsFIEuDF/tBvZ2IEqJybkk1/VLVRLJsmV14JfTHyTaq62PQnvB2tY8yw2iluH4HSifrR/eQ0NozQBT2fCJw2VUOtuHYfQrOe5vt3TVfauV1F+Ze87WnqvuTfY9AxAcaD/VLxZ5ulstHcoEopaK2jMcIbzU0t8PJ8syF+HRYy7x7ATU9fRDS/0wzB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c51CkAFJdka9VkxLGD+QIh9TTX9Z8GTWkf08iAJ8eI=;
 b=rPtFgpjJgAKgmNsgOHsfARFJO1OrPlMjSnUNRV3/764ZbUMLNny7p2zfgu4609TX4AFi7ZLgMFegiOeOCcGZPD5Jl03vCv+17FokPmAj59L2O0fTZIbZNZ59sSguM6LmNeEY8i6fr6vNe7AubT1nhQvLXXtlhTMAQWMG6SST9hg=
Received: from DM5PR15CA0038.namprd15.prod.outlook.com (2603:10b6:4:4b::24) by
 MN2PR12MB3184.namprd12.prod.outlook.com (2603:10b6:208:100::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 10:38:10 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::91) by DM5PR15CA0038.outlook.office365.com
 (2603:10b6:4:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Thu, 17 Feb 2022 10:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 10:38:09 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 04:38:07 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 02:38:07 -0800
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 17 Feb 2022 04:38:05 -0600
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, <Monk.Liu@amd.com>, <Emily.Deng@amd.com>,
 <Horace.Chen@amd.com>
Subject: [PATCH] drm/sched: Add device pointer to drm_gpu_scheduler
Date: Thu, 17 Feb 2022 18:38:02 +0800
Message-ID: <20220217103802.5918-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adefe376-75d1-42c3-e3a8-08d9f2019744
X-MS-TrafficTypeDiagnostic: MN2PR12MB3184:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31845081C4646387A9BDF692F8369@MN2PR12MB3184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:87;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWHCnKITg76ELutByVfpo6ChFEF9jfBcu4tkEIqKLIJSNca4zKsVCnBTHRRSjbm1G20Y7ZrPS3/Q+cE4MXvMWC0XcQrti38q7ldY7Va3KzGGzixTiiCwrg7CRFdBHBqhdnpQdh5XQ9cXanu1MxAArJNPHyHtH3fQSryPb8dYU62PQEJ4CagqdOUYrxw7ZS61RMIF4y7yRZAAb6W0Y0NUqgqDbe5W1JBLSZJM4T6Iam42OlUUC0rlRCsSdy/GUzp+3YvHwV74T9MZsLxzmfExlQydZFXrWsohexrtgRD3f7d0TjHy9Gb8Mc8V+qDkzBOw+jNBmUocGfTTJQcyBSOWEwhfRlX4la07Oo4QV2AHiXjRsdaTBPTMO9F8jWhYPu3cZ+9KzSurOYLbX6mSBzQR7rEqrD2x0HgTk5kFa8LOBo5MCLcaFEzcQKsmnz2XqzjTllLTxr0DNlk/roneN6yzbcvgT4qgva/q7LC6H/DdSjZeI55+HJe2HacJuwGFig1dt4sVOtv0SnhjLi0OKASKBVuDCbRJPSn/OiTmakJSbtSOx3DxUlKecTPPsnVE5fKq0CqMje6V4B1ABHEqPwBhwxYElVXYbqNhc2qieCp3YPdgxN27R1dwpXBqI56cr3cdyW9viuXOUxHqVPjnS0wK6L3m/ZoqZVynKoX/QVuc6TfYLRYASWCPbfkLf163umJKLkpWazipLwN+me5USDJ57A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(83380400001)(8676002)(7696005)(426003)(47076005)(336012)(508600001)(86362001)(36756003)(36860700001)(5660300002)(110136005)(1076003)(70586007)(316002)(6636002)(26005)(186003)(81166007)(356005)(2906002)(40460700003)(82310400004)(6666004)(2616005)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:38:09.5461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adefe376-75d1-42c3-e3a8-08d9f2019744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3184
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
Cc: Jiawei Gu <Jiawei.Gu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add device pointer so scheduler's printing can use
DRM_DEV_ERROR() instead, which makes life easier under multiple GPU
scenario.

v2: amend all calls of drm_sched_init()

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c   |  2 +-
 drivers/gpu/drm/lima/lima_sched.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_job.c   |  2 +-
 drivers/gpu/drm/scheduler/sched_main.c    |  9 +++++----
 drivers/gpu/drm/v3d/v3d_sched.c           | 10 +++++-----
 include/drm/gpu_scheduler.h               |  3 ++-
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 4787cb3acaed..98217b1487fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -508,7 +508,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
 
 	r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
 			   num_hw_submission, amdgpu_job_hang_limit,
-			   timeout, sched_score, ring->name);
+			   timeout, sched_score, ring->name, adev->dev);
 	if (r) {
 		DRM_ERROR("Failed to create scheduler on ring %s.\n",
 			  ring->name);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 19826e504efc..4240f2ae0ab3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -190,7 +190,7 @@ int etnaviv_sched_init(struct etnaviv_gpu *gpu)
 
 	ret = drm_sched_init(&gpu->sched, &etnaviv_sched_ops,
 			     etnaviv_hw_jobs_limit, etnaviv_job_hang_limit,
-			     msecs_to_jiffies(500), NULL, dev_name(gpu->dev));
+			     msecs_to_jiffies(500), NULL, dev_name(gpu->dev), NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index ecf3267334ff..4b3a43a2b3e3 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -509,7 +509,7 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 
 	return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
 			      lima_job_hang_limit, msecs_to_jiffies(timeout),
-			      NULL, name);
+			      NULL, name, NULL);
 }
 
 void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 2df3e999a38d..215709d61315 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -627,7 +627,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		ret = drm_sched_init(&js->queue[j].sched,
 				     &panfrost_sched_ops,
 				     1, 0, msecs_to_jiffies(JOB_TIMEOUT_MS),
-				     NULL, "pan_js");
+				     NULL, "pan_js", NULL);
 		if (ret) {
 			dev_err(pfdev->dev, "Failed to create scheduler: %d.", ret);
 			goto err_sched;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 3e0bbc797eaa..4404af323321 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -489,7 +489,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, bool full_recovery)
 			if (r == -ENOENT)
 				drm_sched_job_done(s_job);
 			else if (r)
-				DRM_ERROR("fence add callback failed (%d)\n",
+				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
 					  r);
 		} else
 			drm_sched_job_done(s_job);
@@ -815,7 +815,7 @@ static int drm_sched_main(void *param)
 			if (r == -ENOENT)
 				drm_sched_job_done(sched_job);
 			else if (r)
-				DRM_ERROR("fence add callback failed (%d)\n",
+				DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
 					  r);
 			dma_fence_put(fence);
 		} else {
@@ -846,7 +846,7 @@ static int drm_sched_main(void *param)
 int drm_sched_init(struct drm_gpu_scheduler *sched,
 		   const struct drm_sched_backend_ops *ops,
 		   unsigned hw_submission, unsigned hang_limit, long timeout,
-		   atomic_t *score, const char *name)
+		   atomic_t *score, const char *name, struct device *dev)
 {
 	int i, ret;
 	sched->ops = ops;
@@ -855,6 +855,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	sched->timeout = timeout;
 	sched->hang_limit = hang_limit;
 	sched->score = score ? score : &sched->_score;
+	sched->dev = dev;
 	for (i = DRM_SCHED_PRIORITY_MIN; i < DRM_SCHED_PRIORITY_COUNT; i++)
 		drm_sched_rq_init(sched, &sched->sched_rq[i]);
 
@@ -872,7 +873,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	if (IS_ERR(sched->thread)) {
 		ret = PTR_ERR(sched->thread);
 		sched->thread = NULL;
-		DRM_ERROR("Failed to create scheduler for %s.\n", name);
+		DRM_DEV_ERROR(sched->dev, "Failed to create scheduler for %s.\n", name);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 8992480c88fa..6d68b155c3cc 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -403,7 +403,7 @@ v3d_sched_init(struct v3d_dev *v3d)
 			     &v3d_bin_sched_ops,
 			     hw_jobs_limit, job_hang_limit,
 			     msecs_to_jiffies(hang_limit_ms),
-			     NULL, "v3d_bin");
+			     NULL, "v3d_bin", NULL);
 	if (ret) {
 		dev_err(v3d->drm.dev, "Failed to create bin scheduler: %d.", ret);
 		return ret;
@@ -413,7 +413,7 @@ v3d_sched_init(struct v3d_dev *v3d)
 			     &v3d_render_sched_ops,
 			     hw_jobs_limit, job_hang_limit,
 			     msecs_to_jiffies(hang_limit_ms),
-			     NULL, "v3d_render");
+			     NULL, "v3d_render", NULL);
 	if (ret) {
 		dev_err(v3d->drm.dev, "Failed to create render scheduler: %d.",
 			ret);
@@ -425,7 +425,7 @@ v3d_sched_init(struct v3d_dev *v3d)
 			     &v3d_tfu_sched_ops,
 			     hw_jobs_limit, job_hang_limit,
 			     msecs_to_jiffies(hang_limit_ms),
-			     NULL, "v3d_tfu");
+			     NULL, "v3d_tfu", NULL);
 	if (ret) {
 		dev_err(v3d->drm.dev, "Failed to create TFU scheduler: %d.",
 			ret);
@@ -438,7 +438,7 @@ v3d_sched_init(struct v3d_dev *v3d)
 				     &v3d_csd_sched_ops,
 				     hw_jobs_limit, job_hang_limit,
 				     msecs_to_jiffies(hang_limit_ms),
-				     NULL, "v3d_csd");
+				     NULL, "v3d_csd", NULL);
 		if (ret) {
 			dev_err(v3d->drm.dev, "Failed to create CSD scheduler: %d.",
 				ret);
@@ -450,7 +450,7 @@ v3d_sched_init(struct v3d_dev *v3d)
 				     &v3d_cache_clean_sched_ops,
 				     hw_jobs_limit, job_hang_limit,
 				     msecs_to_jiffies(hang_limit_ms),
-				     NULL, "v3d_cache_clean");
+				     NULL, "v3d_cache_clean", NULL);
 		if (ret) {
 			dev_err(v3d->drm.dev, "Failed to create CACHE_CLEAN scheduler: %d.",
 				ret);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d18af49fd009..38a479879fdb 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -302,12 +302,13 @@ struct drm_gpu_scheduler {
 	atomic_t                        _score;
 	bool				ready;
 	bool				free_guilty;
+	struct device			*dev;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
 		   const struct drm_sched_backend_ops *ops,
 		   uint32_t hw_submission, unsigned hang_limit, long timeout,
-		   atomic_t *score, const char *name);
+		   atomic_t *score, const char *name, struct device *dev);
 
 void drm_sched_fini(struct drm_gpu_scheduler *sched);
 int drm_sched_job_init(struct drm_sched_job *job,
-- 
2.17.1


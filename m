Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE5EC88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 19:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2223310F0DA;
	Thu, 17 Sep 2026 19:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwI2W+Zc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5720B10F0D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 19:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi+kJxc2y/rnVNl65mObgUa8IwuadL6zA0dCWWTaq+iKvDCouVSZHsUqGF749OcbBiglmdM7OMU+bHDqDHF6bAiGrKN1O0lk0x0ywF6+1x8nTSOS4jrZqYD89/2OBDoZ5oPZDlRaX+YHF3JdXA10knDdWY+Kge4jPbhB1K5c42FQO4fttVA5MAoO97negOaICOAYWzpOQiSfXG0MuUOH5/yoqx7ssY8VBi6G4YFECw9yp2I7HfQ8qMTI4V2J1XXAS4qpJOwz9O5yRzsCbf6WzAifucf57s4n2A3tTj7y6r9VVzYTh4hNB1mAS8IulOARhym3KJ++q1KipZR+cZ6Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFV4SzZcgtRgp0dhlhmFkhKB9R9jZX1Db1TxwUpWJ8U=;
 b=cexYCdi4uXEieeYOyt1SBxOYpgNhOYf8xmmGuPK7pVYQoF4z17Zg1x7vRWjD2XChQ695HIODDnAhrbki4qL5OVIAUTlRPP1z/ZEGE1SVFwhVlHLLwost3OfLwIMqhUehD74Ac8mStanf4w2bz6XsFFDObkEfaiAzDggBnwP3Vx6Tl1dFyZpD/KvWz9F/pRiXWv70Aiqk7Qk31PSltpHRuujbCvM2e4x/O1UwVv4lnVt/8+PR2AN2ngCkCVqYYC4j0lX8G/AocItjptYM7w56+U2P0/WNOh+js9GGX65xx2HQN+kVpC5TFNIqboSITNh8uSAdZ+RkFzDCQDuJVaCb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFV4SzZcgtRgp0dhlhmFkhKB9R9jZX1Db1TxwUpWJ8U=;
 b=jwI2W+Zcz23JKUwhwJ/EX0ADwuhFqDh0t8z7pE2VgpaoIA8tZqRRCpsaqa9jYS9gUnqDhnvFDhXPd8PsawLdwxwSQ30eDepJWZ00z2VGejJ+EHDb813shQmZJJEACVbNP6g4l2MZ/lm5sID6M+OuK0MD4r29RCrr73wVPlW7YWI=
Received: from MN0PR04CA0008.namprd04.prod.outlook.com (2603:10b6:208:52d::22)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 19:58:28 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::22) by MN0PR04CA0008.outlook.office365.com
 (2603:10b6:208:52d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 19:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 19:58:27 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 14:58:23 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kevin.wang@amd.com>
Subject: [PATCH v2 3/8] drm/amdgpu: rework runtime pm management for cs
Date: Thu, 17 Sep 2026 15:58:04 -0400
Message-ID: <20260917195812.72917-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917195812.72917-1-shahyan.soltani@amd.com>
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: d52d6df2-4ae7-4b5f-4220-08df14f60a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: woRPYb3kpHa9jEnLWroIBDFHfkicXI+U5i2vqc0O7WR+a/N5laYcOatXnUaEwJlZXtlorFPgmefUFYIJy3PONikbVdwzMaS5xxPPi8TlgOiyG/C8HiwViq/jKd17MFn73CjezHWvzhv3TvlvxwyuOXEaxNl2w/9XvNKl455hG7Q3ez0o9jEbH0lyP4gQ6KNQPRrfOGTMixcIbgpz+OVYvmPWPde95gK+NZ7a4DESEeSdiRojJhzRTo0VxWJxTPqya4BWN/8tnRbdz4vXWo8aIcrnYt/qT1hRJoaoX/yc/FNFgjMf2YpNJi8IeEW34gbVnvjhQXofFtL8NwEcu0lk98iIp3mbt6FBFdEnswk4qzMjc9GHe4553xIFT/G5WUHF1qtKCxtRJuWWSMrx6fQIsEj/6iuiJr5IJ0hQ9TFNRDAnkcTKFYLYf+//CetzMPo+JgPPCv5wgCx4Mn51I/APyH75xtY+hpML/ewVn0Vwlcp37SS7cmr+dnmq6z0eYbK62gBPtVEGhby3XJcv61phkaKVWpnEgiS6EFpmwUxDuEcjXfB9Y9li0W17vw0SuDsB0IAZTmAUXb5Cm7EAcGEYeEs/KdTOWeBZHlmr5flszTD1/683N/At0kuW4Iqef4ch2pFX6+hOF7Muf/eFUi/ucrRB1xfrDl9jy7Zoc3CX+WW/8SkeHTWKJPRJkqzD5aNjWCC+lCBf9lmaLBrRo8MEjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /G4NAUz00Xoy7MNXmJxXtuGGcPgERigyUIQuowNj548BLwrCODF+Xl13uxeXqcEIHB0BfnwyiDebza9LmStjber6EgB325FWz0HKtCG1OLwzvj6TymsKQdAQet8V5w3pSr87tTtUBj1BmGjP+tDVBz3RxUTcn0cLpMIdy7XfvXmkOG3LSKquWgyBiAEbDnhOgB7tPXpRJiisceMUpwNU4YLM5DwT5ImULSu6kemp4NuTiFwrmlJuW8iLhiddBOs4yWREBkk9ueSdm2zYVraYhlVaclURCMu7ywktmOwU4OSouy9hM0Rrha7JV8smTvKWi9j5X7pmgx4FdtDLyc2bZ2k58/WsHViCQXn37xQKQYbnYiU5WvAc81dKjsDOJdemZ19LL5Q3oW7FaO0T5HqWIsLyREsheC+AxC3cF6OiCkC7jAbMkMaiENQRemf9054s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:58:27.3228 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d6df2-4ae7-4b5f-4220-08df14f60a23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Creating a job will now wake up the GPU. The rpm ref will be dropped
either in amdgpu_ib_schedule (because at this point the amdgpu_fence
took a ref) or in amdgpu_job_free (for unsubmitted jobs).

Jobs submitted directly are a bit tricky because they might be fired
from suspend/resume sequence and for now they're left unmodified.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 15 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 42 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  2 ++
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 0f8b097001e3..3b55dd6ce8a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -27,6 +27,7 @@
  *          Christian König
  */
 #include <linux/seq_file.h>
+#include <linux/pm_runtime.h>
 #include <drm/amdgpu_drm.h>
 
 #include "amdgpu.h"
@@ -297,8 +298,18 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	amdgpu_fence_emit(ring, af, fence_flags);
 	*f = &af->base;
-	/* get a ref for the job */
-	dma_fence_get(*f);
+
+	if (job) {
+		/* get a ref for the job */
+		dma_fence_get(*f);
+		/* now that the fence has been sent to the hw, we can drop
+		 * our pm ref.
+		 */
+		if (job->holds_pm_ref) {
+			pm_runtime_put_autosuspend(adev->dev);
+			job->holds_pm_ref = false;
+		}
+	}
 
 	if (ring->funcs->insert_end)
 		ring->funcs->insert_end(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0056a93c400a..417f2619dfb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -24,6 +24,7 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/drm_drv.h>
 
@@ -201,15 +202,24 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     unsigned int num_ibs, u64 drm_client_id,
 		     gfp_t gfp_flags, struct amdgpu_job **job)
 {
+	bool take_pm_ref = entity && !adev->in_runpm;
 	struct amdgpu_fence *af;
 	int r;
 
 	if (num_ibs == 0)
 		return -EINVAL;
 
+	if (take_pm_ref) {
+		r = pm_runtime_resume_and_get(adev->dev);
+		if (r < 0)
+			return r;
+	}
+
 	*job = kzalloc_flex(**job, ibs, num_ibs, gfp_flags);
-	if (!*job)
-		return -ENOMEM;
+	if (!*job) {
+		r = -ENOMEM;
+		goto out_pm;
+	}
 
 	af = kzalloc_obj(struct amdgpu_fence, gfp_flags);
 	if (!af) {
@@ -230,6 +240,7 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_sync_create(&(*job)->explicit_sync);
 	(*job)->generation = amdgpu_vm_generation(adev, vm);
 	(*job)->vm_pd_addr = AMDGPU_BO_INVALID_OFFSET;
+	(*job)->holds_pm_ref = take_pm_ref;
 
 	if (!entity)
 		return 0;
@@ -245,6 +256,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 err_job:
 	kfree(*job);
 	*job = NULL;
+out_pm:
+	if (take_pm_ref)
+		pm_runtime_put_autosuspend(adev->dev);
 
 	return r;
 }
@@ -270,6 +284,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 		kfree((*job)->hw_vm_fence);
 		kfree((*job)->hw_fence);
 		kfree(*job);
+		if ((*job)->holds_pm_ref)
+			pm_runtime_put_autosuspend(adev->dev);
 		*job = NULL;
 	}
 
@@ -314,6 +330,17 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
+	struct amdgpu_ring *ring;
+
+	if (job->holds_pm_ref && job->base.sched) {
+		ring = to_amdgpu_ring(job->base.sched);
+		WARN_ON(!ring);
+
+		/* Should have been cleared on submit, but we have to drop
+		 * it in case the job was cancelled.
+		 */
+		pm_runtime_put_autosuspend(ring->adev->dev);
+	}
 
 	drm_sched_job_cleanup(s_job);
 
@@ -349,9 +376,20 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
+	struct amdgpu_ring *ring;
+
 	if (job->base.entity)
 		drm_sched_job_cleanup(&job->base);
 
+	if (job->holds_pm_ref && job->base.sched) {
+		ring = to_amdgpu_ring(job->base.sched);
+
+		/* Should have been cleared on submit, but we have to drop
+		 * it in case the job was cancelled.
+		 */
+		pm_runtime_put_autosuspend(ring->adev->dev);
+	}
+
 	amdgpu_job_free_resources(job);
 	amdgpu_sync_free(&job->explicit_sync);
 	if (job->gang_submit != &job->base.s_fence->scheduled)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 7e03bd2ff639..e7ab7e38f6df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -101,6 +101,8 @@ struct amdgpu_job {
 	bool			enforce_isolation;
 	bool			run_cleaner_shader;
 
+	bool			holds_pm_ref;
+
 	uint32_t		num_ibs;
 	struct amdgpu_ib	ibs[];
 };
-- 
2.55.0


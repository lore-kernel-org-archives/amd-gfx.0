Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A03FC88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8425C10F691;
	Fri, 11 Sep 2026 15:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYKG6X4X";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BA510E41E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzMs1uWH4Hd1/WrsGYEBYcL0lCe95U4iq6LXc7zpbA67wj9vtZjdEIYvXRVaDAJTmdBV8n2VEOQkkC8HuJFRnkxrpA1xUS+N8ua/CRL2MTK+tRAYHhvZTccfaPc3GHksBzwlysknb/XfrN+8qUA2R7qoYd7lCewlBJO+N9ktWaqjoFbpOF3vjmABnaWzqMS20TjNqreaOSanw0pfYJufVmF+yfaraofONfV2zXtaIsPZb6WYBmiwigfIwnr9FmSAqktFtfsJmU8TK1B5qD1XgYrBEXCllvg7tmqirRCi4r0aG6vjor/jVF/Yfifp7FKQwuZy91ZTzlcZGrS2Fw66rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFV4SzZcgtRgp0dhlhmFkhKB9R9jZX1Db1TxwUpWJ8U=;
 b=lzpkH62XDgtrOvRtWlwzgFhJijF6/5+TbYEvge+NLhEb5bFrP8+WNZyoIS5fwapYhcakzueYntWKc6USf8Ba2ngTsMExW8sLm3u4TjNGGBw9IyWPaL3FKgKqcT2DRsN5qqdY+7lSInIrw2ib6EFyKzXoG8Dp2+1N24hi5xC2YT5ul6DTD09rnHsHvixiyA5x1iMgyEVRJhTzzBg+cWyABhObm0a9FAi8O/g+EZqObX3W7QKt8rday36YlTkkj2TJEMbpIemAwSK37FKXl3MSBhXJOvgTP+dLHcdVvajb+HH42pEYHm4LNgSkcDl9pfUgdYIMF9p6twwQFR18rT0/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFV4SzZcgtRgp0dhlhmFkhKB9R9jZX1Db1TxwUpWJ8U=;
 b=AYKG6X4XazBnl3oZHWGt48qpEfi7HZprSwqZKtsd2Meuo9hEKp3MAxmo8Ri+TQNCuSJLuzG9g3Y0p2n+rgiN51qI/iXPkCl+A268VDjwqbOHvhc3vgV6YwjM6foleFCXBb5w/D91Q9WWbYtIRAHg/yIewxGjqD169KCa9iNjG/Q=
Received: from CH2PR07CA0066.namprd07.prod.outlook.com (2603:10b6:610:5b::40)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:26 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::88) by CH2PR07CA0066.outlook.office365.com
 (2603:10b6:610:5b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:25 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:23 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: rework runtime pm management for cs
Date: Fri, 11 Sep 2026 11:42:06 -0400
Message-ID: <20260911154212.591213-4-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911154212.591213-1-shahyan.soltani@amd.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebb9aa1-f432-4e72-eadb-08df101b473f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: RUvCSjpKMGW4ro57JYQ7Pd/0QXdR/81IQPQZWfrDGCbRs1cIifUrcQMJaIFRZk48xjFCd7BbVfJcp0HlRdaQyysHk6Nkxqi9yzGhOTkcj6Mb7LdmjZCum1uVbmtGxwsqNoR8K86AoAnRfhj4IvHt4Yo+BBFmRi/3HqH9285Ll56ODtcnW20XrihBOdt7M6UbndSegrvRI7V4NTSe6lrGMNDGJntU5hLUhPS4x16sWZ1ckPbl39lUv76W3tZyKHQczK+Yx7tHyqKJy0F4XKn3nvzZN+XhXPqIEJxcsC+c3aAxwXFjOXV4Sl2Ff5xNRlQb0yEEmN3gp2fRrpLmGeGY67cjlmaXwpr5mN1oIBduOPX6YTDV4epdSVUATTZg7nanNVi1KCGWaUzcXMIpCbPRrg9aqxVdrcw0VQlx+Z9WRsKtAbU4ZNvCFtDPFwhFonsIJuCuxwlQIvTP+K6lVh7uS026roNqUtztLnbyLDSurBfe5j7YiaYXKXklVxzYY/dm+pw4N1w7yLE5jgtXAr5TPqojrheGw62+pw1Wwe6S0R/7kZsGw1n1vm2hz9Q1Mu7W4jE0pWntEPWbK6phygOpAsa5lnemXTmb95PmeK46EZswzJm0QMrAU0lKNcqBN+coI9KPQrQY3slUv7WU4LqCcnUAzhimOlDL3jYzUgInZfNiXePKgkEeBmC4h7Zb0GpCnKUPeSPwmGjWgv9v3mxRJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s5MiMwlFTd1MFHBWCDAAChj2ABZ/2QVgdUxR0TCRFpaBn+uTYhgeyeiDiI1UPTg1XWChdsNE95G0BrwoDX8ZWeTynk1LvmX1DFz341FmOYOXac3DQKgnSfy/Fs2n9HVL0t39Zj9xOD0MsQz62cWpMXby0nauJJKqe9FDBQ8X0q+7QegtYkpZA2uBqI75X+9lc3wa0LMdzCRFoi+qYkUfDM4yGHcoA8VNeliLcyrAW9WLM4XkGVmBPXHmhfrNig27jM1LQnICqkvNdMefKLy3U3sWcbt0wxTQ1ydXG+N+U5S5/hgTu52qIZ3qd7w/pcn9FLcrY/hufS+Wh+NqQO/gdSgXTmfGJy9em6xYsUh9dYs7/HWLab6Auqvh+k4H38iYQxuxP+y9Yfb7MAnpTe05DIIe2KgnJnPOZ/FvLYK6NpiGv7U5tftMm6D4jt2aBsgK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:25.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb9aa1-f432-4e72-eadb-08df101b473f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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


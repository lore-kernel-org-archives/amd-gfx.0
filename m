Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7B9CCA490
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 01:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6D6010E2E5;
	Mon, 19 Oct 2026 01:49:59 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4A510E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 01:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px4dIYsx7AZk2UMu6r3R4rosKKn/SvThH4nj9Gq18UdWub0jN49O2nvYBz7Kyqk0N+yWfaTJd8r8VRWITIIoetn29YJUV+272GneIih3doyRljdDSsT/4owpJ/3SsRqeIEVeZWW6iKbL0ANWaxcYnHC7erVmPDMcUhScw7MNlWsbQBN/BZITZ1lh2Yjq39ysaNS7xTxKVhd9efzDEPzt6C55jeOleFVj0Tkyf0sxEG5zJKKRdrd4450UIE6pkIr+1XhiMzKE4/J7NTk5rewMIu/VUmxdPUW+/V0KVc8NpajU//r2h4bMxxL0mPx0qKrhv0TPX4n5Ek5UQ7UOdHq1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7osVx5H+7TxX3r1FnamxPJVTCvgB7I/jGv2Qzv1qIQ=;
 b=w993WY6gchIytA6zhWwHzYnwHY6WYJtK/TYiOt5sYtBF5Ga7OaIWkCups2seQWA/Y82WVfHhFs6dRp5tpSzBTLUd+di2F+yUsO92RWlacdqSz3bi5+WSpBpz+0xNITmyMB2c7MJYvop5Ggwy1s8B6Z9+UJygNoDZi38IvYcw+QmPz/Qh1HcpgIufx0EbkuSqkCquZ+kt92aNl1V8OA/Mr4tWBQWKWe5j1ZtygXBnzhNNKCFiCiGbj7GjOQp1g6ixg3G2iYyA5o43AAe8mfb486tz3Mt9cK0LRf5YxNZxUf+euIDNx1/bM2yX6KkX8i26BcuLLyNLPsaoiS92406E/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7osVx5H+7TxX3r1FnamxPJVTCvgB7I/jGv2Qzv1qIQ=;
 b=1kQaI++yypwfprwuBs8c1UnN8phmy28WhAE1EidORT4T17TYMtLD4DwX7Vy7xUTn+6xcKkjCM4d1CYk7XTIfWnEYXroD/EER7Km/2S/1kkd0vuXc/QyhN1iMt7A+tN9W3adrj09PLMTcN4JF32Gl0+zvXT0IKwjSU0Jv1BpQM1U=
Received: from CH2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:610:4c::14)
 by PH5PR12MB028906.namprd12.prod.outlook.com (2603:10b6:510:500::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 01:49:46 +0000
Received: from CH01EPF000BE948.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::98) by CH2PR10CA0004.outlook.office365.com
 (2603:10b6:610:4c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Mon,
 19 Oct 2026 01:49:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE948.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 01:49:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 18 Oct
 2026 20:49:38 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 18 Oct 2026 20:49:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: drop the gang leader reference when freeing
 gang jobs
Date: Mon, 19 Oct 2026 09:48:59 +0800
Message-ID: <20261019014938.1487609-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE948:EE_|PH5PR12MB028906:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c2f002-a0a8-41e9-3477-08df2d8340dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|261009221227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: IPv2VOyDve+S8Z0mtptY61HX4avY0UFZfRn7hmNmUq3lnJNPSeckkcDmCRQK+feoy/btAgFYKgJgWBXM8AI8wWk+PqziziDvxq5+0MgMfBJHm04mB7hGNcnTl/UfOaaZ329IFgUAZpleeo6Koyo+R/OyS5QEQ+oWDJRE/olfvb7gDrVWJ/eOglE09EZOYOofasaw1zEnu0utt0EbhKCPTp7ss9WGKWbPCQSeFjeTCfFqWWjO7fYUwJFj/SDym9goFZFIgEpJLr1qv89HhOJGs/JnpAkDGAvB15RoinM1QUTc018e0UxdlLviOTDIWhfN/2OAVErTpILnKKcwVBxpS7iKTOxCRO5Y1T06bDEqK/v/r8eVTPfo6R1/NEzokPgKDCjClrXss97VPsW78q9dcFU4BtUErSiHkqyo4N/XjvM8OPyf9sJdz+zE4hV/nYPG9smHlsICrL4E9NpLVP9xTrNQhjaWSZVmwBINHPc5IvKw3eZSnaJxazqW0qa8CEbFbRtyrXTlZNddR7z0gOtu/MzNyffTjL5gKeIU+crESUDX06XjDZw9oVzAhEIMWT7KCUiL5Z3rqF31CNSg7E09Kzp5MhpAXIA4NLYuE8CCJBEBvYa1vddd2FqdRVc0kwH1+APTU8Tn6lh1QpB03oljbGvu+7gBW/PRAmfXBxyY8hp5JMOryeKbfDUvv3DVVyNHripXrg3yJtPejVvSgyg/Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gL9k65ONQyMXpANg9FF7oLP7cEWrCV9rVI5hUm4IgfIvkOhCYf4mCLF069iHlTtAdWdHuzJ76AOq3zhZCwQXKKwxLFZlhdP2aqDt7j8z2YRo5B3jAc5swygWzcn8I8o2cJQpBlXaVV/XfAVR9/3/V8JT6ytsH0K7RBZE44FXuwlLOUh7hY/Z9VbfrPe5JVjclgo7pETXiqr9ya29DDv7CwYlpMscAlT843YQTCFMS0OqRsmL0g60c1V9ay9OvMwm4fWCPpQXeKJ8vblVqsqdzF6oGbIkNPCGBIb0ZdKDjEnNpf1tYUx52S1nycprVxsRYZ20BSEEBJZe6plKG6D1KO9A3nqxwQQGuX8rzc8BtHPEkvSUcCNW19PgOdfNIXzjNgCgt91VuhxRrzqPTlLYoXHQRVFfJm5Crt96w9v2nr8sVVtvIRdJW01cNl+ZOGQc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 01:49:46.1498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2f002-a0a8-41e9-3477-08df2d8340dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE948.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR12MB028906
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

Every job of a gang except the leader holds a reference to the
scheduled fence of the leader in job->gang_submit. Only
amdgpu_job_free(), used for jobs which never ran, drops it, so for every
gang submission which completes the scheduler fence of the leader, and
with it its hardware fence, is leaked. amdgpu_job_free() in turn checks
for the leader only after drm_sched_job_cleanup() cleared the scheduler
fence, so a leader freed there drops a reference it never took.

On navi31, 100 submissions of a GFX + COMPUTE gang grow the slab cache
drm_sched_fence is merged into by 60 to 180 objects each time, while
100 GFX only submissions don't.

Use amdgpu_job_free() for the jobs the scheduler frees too, and check
for the gang leader there before drm_sched_job_cleanup() clears the
scheduler fence. As the scheduler clears the entity of the jobs it
picked up, check for the scheduler fence instead to tell whether the job
needs cleaning up.

The IBs of jobs pushed to the scheduler are freed before that, so the
IBs left to amdgpu_job_free() only ever ran when the job was submitted
directly. Free them with the hardware fence or right away, never with
the scheduler fence, which nobody signals for jobs aborted after
drm_sched_job_arm(), like a CS returning -EAGAIN.

v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian)

Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 47 ++++++++++++++-----------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0056a93c400a..c5c8cb7d6669 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -313,22 +313,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
-	struct amdgpu_job *job = to_amdgpu_job(s_job);
-
-	drm_sched_job_cleanup(s_job);
-
-	amdgpu_sync_free(&job->explicit_sync);
-
-	if (dma_fence_was_initialized(&job->hw_fence->base))
-		dma_fence_put(&job->hw_fence->base);
-	else
-		kfree(job->hw_fence);
-	if (dma_fence_was_initialized(&job->hw_vm_fence->base))
-		dma_fence_put(&job->hw_vm_fence->base);
-	else
-		kfree(job->hw_vm_fence);
-
-	kfree(job);
+	amdgpu_job_free(to_amdgpu_job(s_job));
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -349,14 +334,36 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
-	if (job->base.entity)
-		drm_sched_job_cleanup(&job->base);
+	struct dma_fence *f = NULL;
+	unsigned int i;
 
-	amdgpu_job_free_resources(job);
-	amdgpu_sync_free(&job->explicit_sync);
+	/*
+	 * The IBs of jobs pushed to the scheduler were already freed with the
+	 * scheduler fence before that. The remaining ones only got to the
+	 * hardware when submitted directly. Don't use the scheduler fence
+	 * here, it never signals for jobs aborted after drm_sched_job_arm().
+	 */
+	if (dma_fence_was_initialized(&job->hw_fence->base))
+		f = &job->hw_fence->base;
+	for (i = 0; i < job->num_ibs; ++i)
+		amdgpu_ib_free(&job->ibs[i], f);
+
+	/*
+	 * The gang leader doesn't hold a reference to itself. Check before
+	 * drm_sched_job_cleanup() clears the scheduler fence.
+	 */
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
+	/*
+	 * Not job->base.entity, the scheduler clears that for the jobs it
+	 * picked up.
+	 */
+	if (job->base.s_fence)
+		drm_sched_job_cleanup(&job->base);
+
+	amdgpu_sync_free(&job->explicit_sync);
+
 	if (dma_fence_was_initialized(&job->hw_fence->base))
 		dma_fence_put(&job->hw_fence->base);
 	else
-- 
2.50.1


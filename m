Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0565BCCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 07:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEEA11261A;
	Fri, 16 Oct 2026 07:46:00 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B346F11261C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 07:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmhescsBajlcBQJOd33f3J7lnzBqbywxV5R3TFbCR0hUxhZzZz0R3UHF7THUvmDfsqygeqg2cB63J+unJM7FKd7A31rPhaSxcvK67MqZJBdqCru24MDdxoomNQfnjKWn0jstAMS9GqpG/oRISJI5dIv64tKU8i8MWBQXBn0Fg4egAkQVupl5y5KIqb67F/YOIBd7yjNCH2PTuIb7sVxULS4U9m6z1UQQj9gfn7w7QGXVBucKhI0fBDawPloiSLv5vr7+aPcly/rDOJWC8NTsIEX8UQksavcxiM9muqs6Kr5rfUZJkL1O6WMisagwCf/zJsxpr/kefnJGjlenNhmgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQEDgtC6gTjZ2SqHG+jmT+x5ayLb459UgqDujAis2so=;
 b=NDII7vwyBa8XHtPVwu5Kvil7UOg+91U5prd/ptuW36EzSXNrwKO/6cANscNlR6ehvE+Xoztx5PtfLN6ttEVtQboYgsDAvpNga5DSJnolEWnv5Y4vRA/jMrgIwNJmkoMQd7f7rQsLjT4rjgBgMX3Zfq25wFLp5lYvgmvZIWY7w3OSGxrcJ/3mTQF3t9bR2kWdBk7KwfhnSoyS6ISyQsPDUg7GlQUxnW57rdTKhtnjFfxTSu0iWeSnsL3sgwagvHCKqudkQvFFlqKOhL2U7Z9qd3UqgAhqb2nZc2KO1d0bqWRctHSTPD2zO4ESy1y83vcEvOFpO3e9dzOWerQTOvVpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQEDgtC6gTjZ2SqHG+jmT+x5ayLb459UgqDujAis2so=;
 b=AsdqsZggkc71pXImJNw4XpdcAUv60P9F0ZhZaAAL+BhgMBstQh8TmLrv9raH6R9jQR5e2ob8jSKv+q56DGM0wj5UtIuYeaHqVUOphLtqDA/xkpSAR0xvmaKDelhBRVUfjdWIXkFlVT61iSh7uPEGN+zjp5NK+Shr4s17ZmqnSZM=
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 07:45:16 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::25) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 07:45:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:45:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 02:45:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 02:45:08 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 02:45:06 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: drop the gang leader reference when freeing gang
 jobs
Date: Fri, 16 Oct 2026 15:44:41 +0800
Message-ID: <20261016074507.3973248-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3838a3f2-37c8-45b6-a902-08df2b596ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|18002099003|11063799006|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: uc61kPNOFOFmfB8PDfTr9XyfM+hQUpPuKNnzzwyt5o88vF7Q+OleyzJw5V/86URGCfvbUyz9564FDWm6b35o4MyWFmhZ14BOicbJItdC52taHohA8CUogJdAQ5GFauMVS4K3MbuSpXQJyKgAHX5ynB9lAF1dXIhXG7AOMAgy3kqB3rin2g1iQoJkdJvv0N/wXVyPv74AM/D8xRhMFUfQEMN+FQi5VqQBPG9Ri+SLnj+4RcYsNn6YW/gOvm7/4Xwa1Ka76Pz7wbHHkEXU95lIONy4JpqBwoamMcZC8EWZmFVizbJkPmEo9mrKsfKgkYIqq4VeDSiJ2FzSJZgvOgk1kqVlPxvHLJsN4uQk0wkDIFbFfK/q3m6WqjozX1x29QuERpcR1C+4V7Z/7QMuD/kVgh2ZnWNPf9m3md/3omTjagk5YJ6MSnc8aDVGVipB7yyYhWnIMVQFnWUkvBwa7R/RwWopjWfmwxgw/DAPSnBgZflOhzzUB2mF/sx7Re5R51MjXdCGxTD7h2C9XHSCbJVF9QuH7Y313TysXhjAjux1d895mztJbI3WBgGTzMA4AqpAH3oIvGFzNomxD4bKBcBTstweK5X2tQcnE3k+5jfynRAC2PV2QLbhFHIVlnFZi5cT7BRU/9hsyf9cY8p2Ilc/sMtYKjwRRAu4THMr2H9xda/0cjAwOdA1x5Tnn6bftY9bGCXfZYJtEUlFYGUrryVt+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(11063799006)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1mgYal/MNZRYKYeVgC91uEEES++Ejq5eAKwADq6LC1vQacS4SN057rmwpi97C7aWf7hT8rAKR7uDG0wwjBSsVaF5wJPcST+OXaBO5JHdNG8kSqpKO+aXUHYhscz8II7tqjQC4zzxZBbF0wNgXiX/kwIeXdx+qIC9Tc17K2W9rqPqRG2x6Gc2VnBxKqdpAzof5T1LO0djtF7R/gNozXoV7qMNKKmZop40uyLfHJGS9+Pe/xapgMFsti2s+An7c3qHKsocqgLHdEh9RCk0Q8e2iT+qf9SLaChVZFiXZwBHiZvAQ8LrgSAFud4FhUIbtgruqzVw4kqNWgkbypCcMmZ8CObAWaeExWP13inOe4Mm4L8toMOCTgl5aC15LdjvjvM+4pQgzSntChk1XZr2ImOFebLst+4lNmAtPLnNTJNvCbpXQSSfco+zT0/1oTuwOJQH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:45:15.3366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3838a3f2-37c8-45b6-a902-08df2b596ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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

Drop the reference when the scheduler frees the job as well, and check
for the leader before the scheduler fence is cleared in both places.

Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0056a93c400a..f8e67c1b5a4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -311,10 +311,19 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 		amdgpu_ib_free(&job->ibs[i], f);
 }
 
+/* Must be called before drm_sched_job_cleanup() clears the scheduler fence */
+static void amdgpu_job_put_gang(struct amdgpu_job *job)
+{
+	/* The gang leader doesn't hold a reference to itself */
+	if (job->gang_submit != &job->base.s_fence->scheduled)
+		dma_fence_put(job->gang_submit);
+}
+
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 
+	amdgpu_job_put_gang(job);
 	drm_sched_job_cleanup(s_job);
 
 	amdgpu_sync_free(&job->explicit_sync);
@@ -349,13 +358,12 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
+	amdgpu_job_put_gang(job);
 	if (job->base.entity)
 		drm_sched_job_cleanup(&job->base);
 
 	amdgpu_job_free_resources(job);
 	amdgpu_sync_free(&job->explicit_sync);
-	if (job->gang_submit != &job->base.s_fence->scheduled)
-		dma_fence_put(job->gang_submit);
 
 	if (dma_fence_was_initialized(&job->hw_fence->base))
 		dma_fence_put(&job->hw_fence->base);
-- 
2.50.1


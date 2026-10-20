Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEF606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fI94Gbe7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35CE110F150;
	Tue, 20 Oct 2026 01:44:27 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB77910F150
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 01:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBzOBv+WVS/LI7IOIyn7DrIxKVMhZjBTBqu5ulsLxR3i/bvenmRwrLPkIbUVsqdwXN9Bq3vHN/tu69O59Vu7okp/D+t0l2Ip/9iA2UbN0uUGOysq0MHKM1xtW7GmsFvtXGy7IbKxzavP77XNspgnvGnT32EjvAQ7J2ASpUvARuXDiRUY5M66qdXZRZc4GOUfiqu7wR8TDFZELgA0m9HiTOIWKeTOkTpcdRfwghhvIUp3F/wtG5tpWvGU4OCqozEsqNeI7pjU2pAx1/uLRINcogqEvjjfH2QKDtW+DqT5vS3PcRXH23DzQiK+pyNOFV9yNyvHmXH2PLH0eLwGdflcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XlvP5dAZJpbb33UO99p9jUrx/yklutx5ebv+Mfj5gg=;
 b=Bn/4OzpPiKpgu28x7pGJ5Z7cyNtAsD7aHtNioJ57vhwtjDZPbvRL0PanZ+GV+b0RKtsbgUEd+YAqcP5joiZZLZQb+7YUjs9ALqR4Q+t34hQP+Jfwd3rLDJt0x0bwVzkByERPDDtbxdfO4NMyEHXzAj/tIpRaFCEA8wioz1TB8VGKTHJsvLgiMgWDtvAyqIImSejpku41VAwtg6nPXWqQjaAoJ/qaT5aFKEulRXtyoVYuzQ69i6J+eg+oJsAvzJJxXK7xYVkSYhZztZ0pwIOnMiBTOhgFSjh6QjdkB97zWI9DzY43t4Ck3itGhbHMeMxGkVzP/5sFFFXn/3qgFzdfWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XlvP5dAZJpbb33UO99p9jUrx/yklutx5ebv+Mfj5gg=;
 b=fI94Gbe7XgdzwRL3wJqJP2zNIYESg+/tTsKOyRrhRcCHGzaYnALfIfOxarjJ5U80BRLQ4qPK9e3x5zb8nAXvqZeALTrNlLsIrmMy7hkxsFNUxe2BE98U0JxjkvqwQQ7yMnOjPSVV6E/203qEZFggQ5KCnTzNcxJOx/0MPrmULKc=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 01:43:40 +0000
Received: from CO1PEPF0001885E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a5) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 01:43:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF0001885E.mail.protection.outlook.com (10.167.249.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 01:43:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 20:43:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 20:43:38 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 20:43:36 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: drop the gang leader reference when freeing
 gang jobs
Date: Tue, 20 Oct 2026 09:42:41 +0800
Message-ID: <20261020014336.2319937-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885E:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a2da54-842d-4ccc-c23c-08df2e4b90f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|18002099003|11063799006|261009221227099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: GTpnC2/fOi3ePIUuC8Gq5EfWtsYXD35zKARviIye4B2leOjip+mht4S5j4+29aX7B6rX4b/pSydiGJm8yBW4VdR9x3hBpufx9RQTcysyF4C93dT8v9eOBvnw17Y6GCb9aWWJmZ+0/bZ6fpIRVNKJ9i2XAIESwq8Kttf2MObJBEFZQTAtn4cHKwxRYKliQ41wdWiQMGLr7R5qW1IVzsKGqYUt5uC4z0nTqFWlWw/EAibda7Bnxa5FdAUIgJun4U40yjfVO3HWo2sVSHnDBBbmneosyyRgb5XegUjRCJRZpuLNMRtacxuTdH4P116e0QXh5qRRiedddjg5BT+iUqufyhF21eC3eHrZHx7qgXESgPsObEYACapKflNVrC1KmHkLmIACvdnwDgAj8IERP63g52gUYw7zn9AkpCKTDJM3zttdnnP1/gWPw/mQ7heuId8Sz88T5CNBtvgnOQ7z6OsyErxPJF2wDx7K5acADlYYkJMlQZV4mOerfp9A9jyLvxrxlkPD68zsrbsUUtlEhoSpELna/Kclosr2eDJphOm3vTQ5ODXqln/zzWiXqX41thGWYsRI6lqxfK9xeIAbos/bYI4UGXGpwmQZpCXRXqwoRcfH7T8FSTqDB1DqksCLn0QaPxQdQpdJCtVzOljXQqk4T9AyA7UZMPz9kv0TEq+I2PGEqm5kCKDIg6bNh/oIyrZY5ogTACqUqyVkEDBZrstJig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(18002099003)(11063799006)(261009221227099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rtzdi5LqcLYHnwGJ3VQheTVtAqZvtut+YEBYZPSBdA3mj2uzp9G4F0J78vKPatC3OGAOhGWfpb43Q07DeriQAUKoKkwTmXtLTRcHMqBU7P2F++kGCzI4mdBSZIdCyy4CIrvy+SadjKkTzmgiWBCtUkD1ocPdaQbPANciOcx62hdBqT80ov+IKYLs3FURGnS6k3eOlJwQ4TjM3ESYU0rPTBWtsR+L7/48/12I8SNWXVdBJeOoTcoI9f/vUIHk1sDRP7HdMnqW6hY2hytYItsHUuclG2RwigvGqC6gY3fHtZ2wvevVyNR18qtLDPFfwhBNEzu6HOdwZ5XIyeWyo8ogUoDbgWxsva2fqtOnC+HmCEVWvERbWGPv91TEfVH5OjZToJ51X8whvlE6E7FGDbpalSV0pXcIQoY4+eNFMZHa1ke5aS/X/rNdRYhHHYgJh1qa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 01:43:39.8053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a2da54-842d-4ccc-c23c-08df2e4b90f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian), don't
    free the remaining IBs with the scheduler fence
v3: drop the comments (Christian)

Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 33 ++++++++++---------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0056a93c400a..f8a81f0a607b 100644
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
@@ -349,14 +334,22 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
-	if (job->base.entity)
-		drm_sched_job_cleanup(&job->base);
+	struct dma_fence *f = NULL;
+	unsigned int i;
+
+	if (dma_fence_was_initialized(&job->hw_fence->base))
+		f = &job->hw_fence->base;
+	for (i = 0; i < job->num_ibs; ++i)
+		amdgpu_ib_free(&job->ibs[i], f);
 
-	amdgpu_job_free_resources(job);
-	amdgpu_sync_free(&job->explicit_sync);
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
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


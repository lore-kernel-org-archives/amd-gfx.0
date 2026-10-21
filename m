Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33847606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fspzeqgW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEEB10E2A0;
	Wed, 21 Oct 2026 02:32:26 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0815310E2A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 02:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHOswYaAi4g0HpK1eVMosZGZQFyrtXJiNxQca+WsyOfYBFp6z03EGx1Un0V5ZMwR0awawbYjkWkg1EQUpiVkHGpnQIbxU2GXQWBBQcu9Gyo6h/uEcjs1BumWrE5FtItIWHDzEqMR3V+T3v4RsvRkTtT8GVE3dopl2WqZLzDq476nURDHjF/xA9yeOO7iIicz7qYMU/12ENyId7mR5kyZ1F0Pk4ERBTlPDs33DrZkl4bamxxJXlAcHACWvFu25keAfNKV4jg3TR7fbpJ2QprC8wlV/zUaBwJicSgxb4vagokR5WKOWJGidqdGRIdV1+DA71SOxisrjrNYRWyECwsDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NBvnKnuTfkPtKq20qqbPHHYDFmx9IXk4U2lzAKtSC4=;
 b=n/PToIkXHZ12Vj3orBeotZFczHwnO4afrTE+TzB0jV7qZjIE+tBRyl8NhrhGBVAAqq9+vdIlMHGCUWLREWJyW92kVTIxdx1jfH7e8IG6k/lgakiIJr9jfvChWW8gV0eTD2LGOOktzOEh9kAmsx5zmnOng98UxIq+ADEYUtSrz3i2x0bOTHDjJUOfBJPdgWKYRatAERLGZDRajJZuWmJ4Jpwk9n8HZM4aWCPyfzLAg0j6w3AFfh4iPAJtVt9Usr8DVbW5MeXnirLAGfOQepWN7ZriDCvquplt+paWRzv+HUJsaCXojIm427PGbIvUy8d/UwC2FKgnD6k5h34s+WPdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NBvnKnuTfkPtKq20qqbPHHYDFmx9IXk4U2lzAKtSC4=;
 b=fspzeqgWBt7jh1QG1NzvovZ81bhjove8CGj/Qymrky7ccE7nge9CAaVSgTIvWQycgZLtIs8cpyeNxxMkLPT6HM0k7Dityavr71HdLj+HvS8I3UIBBNbwnpr7OMpUeXTktXpcuzfZTb5zLZ7ko+Wj5H1CizD0h64cb+ZEERaHxH0=
Received: from CP4P284CA0042.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:127::19)
 by IA3PR12MB870191.namprd12.prod.outlook.com (2603:10b6:208:712::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:32:15 +0000
Received: from BN2PEPF0000A991.namprd04.prod.outlook.com
 (2603:10d6:103:127:cafe::7) by CP4P284CA0042.outlook.office365.com
 (2603:10d6:103:127::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 02:32:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A991.mail.protection.outlook.com (10.167.248.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:32:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:32:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 21:32:10 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4] drm/amdgpu: drop the gang leader reference when freeing
 gang jobs
Date: Wed, 21 Oct 2026 10:31:54 +0800
Message-ID: <20261021023209.3241785-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A991:EE_|IA3PR12MB870191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac27b56-1d63-4d8f-0c45-08df2f1b8423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: SuPlfOEn4XWh7twzBq1DMIXKr1UykqjuPbBdjK8ogPZ1gGBfRSTyc+XRYKvmEceS280yeIO6fQ7OnxvCHt9Cs5pzkKrFD8i//Udt6vD3GIT1PFirfsmU1KW5+LrrRC+9Chv8uvCTvt07WkcPzzuH/1uulmRIz8xdQ3teuqD+B4QO6vg7xyXFvXAgrZUU9g1LgG38sHur7QgMTrSG48R8zAsnbvOTOfQlrUssfDWz6Dw9GwHNuTV44mUXfpd2cXa0Vk+LwoJTvtnl+fybAX9YlSHTsaejXkOeGsh3mZOA2fsmsAnnREJFDLOs/xaz81xBK1YfhmUq+jbQgDB6B4HxDcQwcxIiIcAXWuJqf4qg8Wrc6OMda1S365JkJoTG9To1pagOajIDd27RFipeIf92fjp0Si8iNQJL80MTDCjIkfMc3CMCP5gpLMoZzO3bwXhEcnrJrcludtaYOA/HxQgVvG/lRDtxALBQpQEtQmtFbPI2eq/AhOStVPtvBzYZoF3uveddf/cwqo1xgxu7lSoImR491KjAL2XD1VkMu16b1YhxHqmWVhi3UpTXsGcHvPDeHYbA1L52cKHDnQjFulQYjl0knuebDU+qolMB2djOxnjEdzy+boZquDog86b+vY6BKXxbdqUl3EfLTgRu3Ko2jpDnewBJQNydJ1NZOA1tMfIeZEQr8I0Sb4cBEniKrlFgMK8ZhxqsXcMlP0oen2+rOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zSN47D7/zTFkQ1ZAO2j0j/M6RgH6x6kjs2+Bg41DHa037yvCSy1DaDL8kGVmJkh4pQiCltWWH83VWZT3//B65vFtOF8wZUbzmC1yA/3WEosDY/J1wGZ2fVK3abXsOSiS5bbMlY6BIWfdB5tesSL7h6yD7COBrXfftYzJRtJq8N8h2lWacpEMaFjtoapDmzali/efgc4uONrntP5iVMJg/LCP5A44ClPKHEEfSuS/tqfQ4D3LeeBaFOboXAnO0qyCX9xX0PIwPHqWXl99yvCq54GyNX12Sa1eeXaeyYLxNWD+G9DLog4qjW035JATSn9pR/9nvM4z00+gGkJUN3X/k3Qpl1cg6gPm+Nu/X7swMn6DBnrDdrEK0i+9m4n9V8kfwAmdMkCufID232Vg3yUHj8fYxtg5hIz01TBaRAvsg8R3fPXlHGZBQVCWbAigIL9o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:32:13.6979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac27b56-1d63-4d8f-0c45-08df2f1b8423
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A991.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB870191
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

Keep freeing the remaining IBs with amdgpu_job_free_resources() after
drm_sched_job_cleanup(), so that it frees them with the hardware fence or
right away and not with the scheduler fence, which nobody signals for
jobs aborted after drm_sched_job_arm(), like a CS returning -EAGAIN.

v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian), don't
    free the remaining IBs with the scheduler fence
v3: drop the comments (Christian)
v4: free the IBs with amdgpu_job_free_resources() again (Christian)

Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 0056a93c400a..4d363bcfb6a5 100644
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
@@ -349,13 +334,14 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
-	if (job->base.entity)
+	if (job->gang_submit != &job->base.s_fence->scheduled)
+		dma_fence_put(job->gang_submit);
+
+	if (job->base.s_fence)
 		drm_sched_job_cleanup(&job->base);
 
 	amdgpu_job_free_resources(job);
 	amdgpu_sync_free(&job->explicit_sync);
-	if (job->gang_submit != &job->base.s_fence->scheduled)
-		dma_fence_put(job->gang_submit);
 
 	if (dma_fence_was_initialized(&job->hw_fence->base))
 		dma_fence_put(&job->hw_fence->base);
-- 
2.50.1


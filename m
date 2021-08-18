Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AC6C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 11:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761F660524
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 11:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 761F660524
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0A9895D7;
	Wed, 18 Aug 2021 11:21:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421AD895D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 11:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7iskA3+aZcunmczrIBXb/KcZxVltLWZAv+d8YtI73gcNBisZ57za80XJdI0OC9kU85CyJ1jhyXXxp3h+fscAy0eflod5oYJyU6fMoYBk6xEdFnrbwWUs9TlXUlXYJoNbDf251zfRTc64MyNdlQROTOg2bn3f9wZyWMTyQ0Dt9D/NPsIIVAMo8sGR2PIXUv/xhSaU+LGTxmKetHiesZvuQnsWJ0st/JShCzua7kZpDPiF5ZbpHI5AFHUrspYqZd+HIA+wQSwW/NuVaaNCbQYFbZWQyOZOGaA7ED0gDy9eLsUJ8ywiIJOBFHkxls0459e7gzSY0XXn7LozVm+lCCB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMvyHiiLqZgqNs5qFgPP374LcLHlwQ0Z+e0H3MNiXOQ=;
 b=Hlped4ud41e0Ki4fxYuAU2uzYd4AsjIoxQzxEhdIF7rihLE/+S7qlV5leFBxEPtsXYA/XEA6iJph9rTfgdJTYksRqek9C5eMplBHpKSOTRf1gZv5WMZgJK+IwhPbNH5gGfeZZQRY7o9EXirsb1wyfzS/5H4u5Nm0TAVe0c6iYc70XPqHX3HhrNObamiizBySLm1z50bKgBO0CTzG6cZypqje3ZgNKx7Bjkk++Ph+3UrD6/ocpAeFYzN0FBtCSvt/I3Sc8ZFl9kDkM6+rRdc1yhPHMWRSQKrvxfJOcltiAlfoAx7EwQ3fIrmytcrZeGMXs1wQbrdYGKKsU8Vxiedtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMvyHiiLqZgqNs5qFgPP374LcLHlwQ0Z+e0H3MNiXOQ=;
 b=nzVXin8qkf3iTOIisHNVVuk3wzcb+OB6AkGC8kZMF+6g/Z5bHV2Zp1x8BeUw18wsE3UpAht+GpoH/+PlTlJRLQDs+KvYQxTi0kSSJYF+hYEyzEBZJM+vb77HeD+0zHBpMBv3ru3hk2QK/S4qm1n0XqIe9mrilUOmx3Fd9o5+VQk=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by MN2PR12MB3840.namprd12.prod.outlook.com (2603:10b6:208:16f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 11:21:41 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::3d) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 11:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 18 Aug 2021 11:21:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 06:21:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 06:21:41 -0500
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 18 Aug 2021 06:21:39 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>
Subject: [PATCH v2] Revert "drm/scheduler: Avoid accessing freed bad job."
Date: Wed, 18 Aug 2021 19:21:15 +0800
Message-ID: <20210818112114.1417685-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f97a9ba-18cc-49c7-8623-08d9623a5a8d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3840:
X-Microsoft-Antispam-PRVS: <MN2PR12MB38408403F32D9DC89CD4181EB7FF9@MN2PR12MB3840.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:68;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXzO1hautl+nlSFfNO15oLWfihQySzs9QkImPEn+PHgfvD4XH4SMVY6yNFR1Bvg/uxRlGpZ8UicFz85Z+RWSxGtwN7a2s2AtVAMF4OVkA4zLm7CU5ypP+36+IMjfUm7Pjs2YgyWsDtOmQqvZVTOkOO/9a4WytqNg9OpJm5e4Z7VSSVUGUjowE6CdPbE80MYUKxxkdiOiGaLPtoJ+ykBLf7/PFU6AkNpFUbzw0mmb74CJFnaCZ6yZ0kJ0nrn7NRDOXMlbs0b2TVSCPkRGEPoJPSCEEKf/kSKVErh9+bKQmPJhnfGXjZD2KU+X2m7gVuuJHpuuixATbjqty5r4olS+eS5n2hILxjOF+2wc82kBvgJTMD+OJT+KnEQ1tYHEUJjz1iBrIEfJ9IbBlUaFlGbeDYtxRSV1iSwNaVbd/Bu3+j64UgfHET8G7AUg059iZa9BJbHu09m2ZnvfKK6mG8BODVHFMBzT+jn1blDNFIHifSthjz9BW69OacWmzJiDuM4jgVxmGjxANdLL1bkeBvOibZOeuzM8xLhCxgnDP3FNWWOyhXwWxGP8rHg5g9WtqJSWaBr277mL2N3gi5MjIpXLyS2VhuT8oWCz7Ij/mfoJvl1QmjqWzsMM8eDRKlbnlGBska65C2HC/kBclwiIyEZWeeFpcr3NdB/yyujgJX2XRdO2t/gaz05yVfChLeK1FiDCgCp0OtJlKamXVPmagWsIlqc4c+CFdDx+prdRax2b8dYbQG8gy4CBfTc4+KPb8hrhWAGYKvd/KX0dm3GwtmLDZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966006)(36840700001)(426003)(54906003)(1076003)(336012)(36756003)(478600001)(2616005)(6666004)(316002)(4326008)(83380400001)(356005)(36860700001)(70206006)(47076005)(34020700004)(26005)(6916009)(8936002)(82740400003)(7696005)(186003)(8676002)(2906002)(86362001)(5660300002)(81166007)(70586007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 11:21:41.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f97a9ba-18cc-49c7-8623-08d9623a5a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3840
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

[Why]
for bailing job, this commit will delete it from pending list thus the
bailing job will never have a chance to be resubmitted even in advance
tdr mode.

[How]
after embeded hw_fence into amdgpu_job is done, the race condition that
this commit tries to work around is completely solved.So revert this
commit.
This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.
v2:
add dma_fence_get/put() around timedout_job to avoid concurrent delete
during processing timedout_job

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index a2a953693b45..f9b9b3aefc4a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -314,6 +314,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
 {
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_job *job;
+	struct dma_fence *fence;
 	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
@@ -325,11 +326,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
 
 	if (job) {
 		/*
-		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
-		 * is parked at which point it's safe.
+		 * Get job->s_fence->parent here to avoid concurrent delete during
+		 * processing timedout_job
 		 */
-		list_del_init(&job->list);
+		fence = dma_fence_get(job->s_fence->parent);
 		spin_unlock(&sched->job_list_lock);
 
 		status = job->sched->ops->timedout_job(job);
@@ -342,6 +342,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
 			job->sched->ops->free_job(job);
 			sched->free_guilty = false;
 		}
+		dma_fence_put(fence);
 	} else {
 		spin_unlock(&sched->job_list_lock);
 	}
@@ -392,20 +393,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 
 	kthread_park(sched->thread);
 
-	/*
-	 * Reinsert back the bad job here - now it's safe as
-	 * drm_sched_get_cleanup_job cannot race against us and release the
-	 * bad job at this point - we parked (waited for) any in progress
-	 * (earlier) cleanups and drm_sched_get_cleanup_job will not be called
-	 * now until the scheduler thread is unparked.
-	 */
-	if (bad && bad->sched == sched)
-		/*
-		 * Add at the head of the queue to reflect it was the earliest
-		 * job extracted.
-		 */
-		list_add(&bad->list, &sched->pending_list);
-
 	/*
 	 * Iterate the job list from later to  earlier one and either deactive
 	 * their HW callbacks or remove them from pending list if they already
-- 
2.25.1


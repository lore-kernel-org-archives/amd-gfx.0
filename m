Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FFC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 04:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D6460F38
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 04:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1D6460F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5076E0F1;
	Tue, 17 Aug 2021 04:28:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDC16E0F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 04:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz/6OZos3mlqZT42MXZvR1m99r5IsPIxC3OXAtBCspNg7aJ5A2MvVebikk86MUVMKK2e5xTfrNBlDFMET3c9kLlIuP1+yWK9ZxUwT7NEjH4U7KRWKPt64+mQzIk3eRSwykMzYW91EWobqMamau7IN1cQQV1X6V50HgI9SVOsjA9gn1/6hctXwGix9trCLh/ObucWps9FsKIeNTdCCLlKePiDFs39dnyrAQNbxqCmrDgg3d6mZHNiXpA21uz6z7LyW1i2A7yXhGRd1TCdJs465VjyVV+j/kVWQiZE5+dA6QK+53fDBp9cySAnk/51lj9V6SJE0EhwdKxliOwXsny1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyvdeybr8X3utxNnF00j/rZJ54nN8Xkcc7yQ17Hb+JM=;
 b=LDxsXHzzmNe4qmlh/xRJxOV8SA579MEcaPGqo1+H0tnGrGZa544gopQJPghmZ5iHpK0HtBv7aDdn3GjmBIdFFnvhATisZzf7W8Rw1GkHeoLU20um/XEdvihCVzjiChjl6id8EZQ9ayE5dn5VjJmbB6Bv5DMjwWP89mDu0p21kUMX5msm63i5UrQEEa06f0MGxXK3ScYKWnldHVd2pjlvcVmuJW/uUCatNbBMqehW6HnLKfTzYT3gvVDoV56jPepg3XGSV8Zvaf1a1rEr/pUO0OLv2u264O1hAcP6mT/a44cO3pqR1kGPwgqoSsUvnFMWlw+JRhi+ZoTDMP96r3gvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyvdeybr8X3utxNnF00j/rZJ54nN8Xkcc7yQ17Hb+JM=;
 b=OQHxu2RlKdLGTmbhqjb/dU/E3hq8z0Mx3kF8Ifwk0ZVD0JSwlerAhGaBX3Mn8xI5saPminNEAnNoNkF46U/+sBIxkfpgdX/OrfhuzKswBbqvr/pP32bmrcKKwaF8suGLkC5SbE4DwnmgL7Mfh4VtuLxUNnbW22An53avX1eWFW8=
Received: from DM5PR13CA0057.namprd13.prod.outlook.com (2603:10b6:3:117::19)
 by CO6PR12MB5426.namprd12.prod.outlook.com (2603:10b6:5:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 04:28:53 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::a7) by DM5PR13CA0057.outlook.office365.com
 (2603:10b6:3:117::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend
 Transport; Tue, 17 Aug 2021 04:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 04:28:52 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 23:28:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 21:28:51 -0700
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 16 Aug 2021 23:28:50 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <monk.liu@amd.com>, <christian.koenig@amd.com>,
 <Andrey.Grodzovsky@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>
Subject: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
Date: Tue, 17 Aug 2021 12:28:16 +0800
Message-ID: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb4ffe7-eb04-4699-44aa-08d961378497
X-MS-TrafficTypeDiagnostic: CO6PR12MB5426:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54263641CFB835FB7B53C872B7FE9@CO6PR12MB5426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNuPpKlX6/bKdxJQNl4TowIY20aWl5EC3Zj4bPd3peLl0KC6AuEHuLMbWqVaxy1UmCgR8IDb8ffV6PRK865zXuej+tBxDR8mk9rrxY66VIrdXrr4Y5eXJ3KJrLI8jvH//gKgZQTdj0hyicPOqc3frBcPv3vRwEBujJFSJGJLPrhn4pfzlvXLIWub4oqGcf53buO8s+AJS5A24xB4E4OLxZIbG9mH0NpREpOFFuLuoTSsqzKV+gRJSX5cZM3U5wPFmN+sSfmN7/trSTBnkMI6BlFV2G11DYFWqTWMOOBoMm+d5KXWAkCBBRRc2mmz1jH/N4EI+0r3hdLyDcNtfiZMjXVpHAvzyeBqWIl4MjIXRmAECBfLt6sWjy0p19ljpMrPaT2swBpj7leaN5BDYfBRhKBqzbPfREyzdCo26nTormYRZubL2Jk7MV6KfhzjtfQVAVwnpHq1D2+b/wt3ci/4qPc1xDJIxjPCRGhUJvWMbHEzVaSuDPZ5fQYaiKU2r6QAteIZOVfCjn+Pf46q345+qFSHgzvSJv6sx7yryKp37k4ElVtIGOrqYkHfKQX7z7LNayjjkG43yoTR5SsIL8myPWk13PyKrw92+1Z9ewhtkbSvvfb2oCOzy6/Ls0G2ORlbQq2Y08RX51HbQVPH57E6lKnZt7AcBlzuU5V4LwnH7RDoqzX7B08Gurw/ni12xPIO/NlnDuanqz6BTMR0YPTVZntpsPkhTsbVIWEBvERAG81uf2CyEyZpRiBY1q7zpQSXVXJQXkEthD9Kkv+BZtF3hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(5660300002)(83380400001)(36756003)(34020700004)(6666004)(7696005)(2616005)(426003)(82310400003)(47076005)(316002)(1076003)(70206006)(70586007)(8936002)(2906002)(4326008)(186003)(6916009)(26005)(82740400003)(81166007)(478600001)(86362001)(336012)(8676002)(356005)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 04:28:52.4287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb4ffe7-eb04-4699-44aa-08d961378497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5426
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

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 27 --------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index a2a953693b45..31d1176d939f 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -317,21 +317,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
 	enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
 
 	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
-
-	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
-	spin_lock(&sched->job_list_lock);
 	job = list_first_entry_or_null(&sched->pending_list,
 				       struct drm_sched_job, list);
 
 	if (job) {
-		/*
-		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
-		 * is parked at which point it's safe.
-		 */
-		list_del_init(&job->list);
-		spin_unlock(&sched->job_list_lock);
-
 		status = job->sched->ops->timedout_job(job);
 
 		/*
@@ -342,8 +331,6 @@ static void drm_sched_job_timedout(struct work_struct *work)
 			job->sched->ops->free_job(job);
 			sched->free_guilty = false;
 		}
-	} else {
-		spin_unlock(&sched->job_list_lock);
 	}
 
 	if (status != DRM_GPU_SCHED_STAT_ENODEV) {
@@ -392,20 +379,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 
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


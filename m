Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F63C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 06:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2286113C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 06:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2286113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0141A6E0CB;
	Mon, 19 Apr 2021 06:26:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77ACB6E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 06:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKFtyTqtkOw5UJH6HAkZtJUL3V9qncucqGRy+igwqM3yFi6Zag3h/2cEj1KG20/2JH7rfzE+MQ3hP02psydkn/Z+elEGgyDrV/hvq0SfjVru7njvh+Al4TqdkYJ3QE9KXsEf30imvL9W8ym32ddyebEd07Am2KP8b9ewo4SSaxrbRtwvlYV3uLxkeKMn1LJUcn8OYYRvx15XMzPoKzAKcnUCwehuQHMEnnIuOAW8FPaTxHA7XTaWiYXMTG07XyKDISE5ST77QrsIJuhD5iXGv/tnjn0DoC71MsgNIBrsFdrWMn38QwKIo52Drie5qu4Er7cvlb490WXE0+jbBByx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=QEFcSkV2KJOMaSMM9oBwFvm5j8QsxOMF9ar06Owe4zZbXa/BrX/PWuFmzNDBEPA2s+xIw1/gmpyokqV9THUY2qJMXZIrtDx8CI3DKc/h4h4JVu3uza15GeZSZtUaaJLa7GRtA1F1N1NKj3Jamzb/A0GsJHufQwFlSOmV6VwehuzEd4GjI71n1SaxxJV7noT+rMRNnVUrBWEwkyf1jvM9o0z0r1Cx2HimXDLv8OWVQtwKbV0dkzTOw5mM4tSUdwVQo2M6lf3jjSaGbqBU4dz2cBNvOmm+hRfYCXpyZYnOZD7iJWkahExT0ozjjvF3iTd9DBhm1MZdsWtmLegAphiZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=C7p0HIpQhxAMF3aYoI4aPsla1qOZ6kRdbJBvvzgrswvbMc0L6azve6kRiEcI8fmt0CWugjE/2q6A+SF5qpWJJKyrAq1r/Wr1moY/nZtpzrgn908/Zs4oLdMNWnlhdmYyDIt/EAzPBz1Q6jbt+QDyvEvfhODHAyxa0RL+1v4bxg8=
Received: from MWHPR17CA0074.namprd17.prod.outlook.com (2603:10b6:300:c2::12)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 06:26:29 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::f5) by MWHPR17CA0074.outlook.office365.com
 (2603:10b6:300:c2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 06:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 06:26:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Apr
 2021 01:26:28 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Apr 2021 01:26:27 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Mon, 19 Apr 2021 14:26:23 +0800
Message-ID: <20210419062624.27688-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4dfe25d-ec6c-43ad-9150-08d902fc1150
X-MS-TrafficTypeDiagnostic: DM4PR12MB5373:
X-Microsoft-Antispam-PRVS: <DM4PR12MB537392193F91E4A732C625A1FF499@DM4PR12MB5373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YykgU3CkWZHvRQbxtUPtDQkfCfs3FO8Z/PUtL2o0xUQy0h8UNem5/Y28AowiSzhCKdl7peejIKSTeWFOORROmB0F2aUjQZXzzJgYPtxbAm2EcJxwBfIfyXK8R9wfH64gCrQrOdbv3+c1hwQfMkrZCjtYTdvUk0gLrYCj+XFt8PuQLUIj1OhPYBzIye/C1FXAbWYrFmXy5mJVkn4X+n1UJAPCRxy2aS/t0BgocJvlJejnCTjpqT9UijN+xspr2d9jGwVnhaLEvJaisANqKAID7VGrcqDCc76CBns2OxIHp/atWz+I4Y8FTP+JMpggMrPUpYCorPzdluuPT8RO0VsZP9pPl/DzfpIKZ3Usk/1F9W6MJs+QKCYEBNsYVA0Ck9WDN9cu1HLWV8/yum76trtULrTpS/BqXPi4fEs0Ox7aVGwbIHIaGnCrvefeG0VA/zl0LVCmV/C/chBJWbvkfwBHPWF4mQpmuGsNR1Fe9tmHk5briXEEV5d87jie5Z2c44IRGyoY9t+kmmL8BcBSgksEyrtjHhRVk/jiFkyqsjdfyWk1DCo3t509xdOQuKaP97cKuTnGxRa4fASGsWNKLr/e1RWWtqBAC7uiRnS9RvNaqvK4iHmfonn1kRNoqu878wJi4njUdMJNIpk+n7535Q+bqEPpvIHFYlGaVUEvWWH6u+vXOO797rjpAmKtadsW7tf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(6916009)(2906002)(2616005)(4326008)(82740400003)(316002)(82310400003)(7696005)(6666004)(426003)(36756003)(54906003)(26005)(47076005)(1076003)(336012)(8676002)(5660300002)(8936002)(70206006)(86362001)(186003)(478600001)(70586007)(83380400001)(356005)(36860700001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 06:26:29.3593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dfe25d-ec6c-43ad-9150-08d902fc1150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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
Cc: Roy Sun <Roy.Sun@amd.com>, David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the timestamp of scheduled fence on HW
completion of the previous fences

This allow more accurate tracking of the fence
execution in HW

Signed-off-by: David M Nieto <david.nieto@amd.com>
Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 92d8de24d0a1..dc05a20a8ef2 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
 
 /**
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
+ * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jobs from pending list
  *
  * @sched: scheduler instance
  * @max: job numbers to relaunch
@@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 static struct drm_sched_job *
 drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_job *job;
+	struct drm_sched_job *job, *next;
 
 	/*
 	 * Don't destroy jobs while the timeout worker is running  OR thread
@@ -690,6 +690,13 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+		/* account for the next fence in the queue */
+		next = list_first_entry_or_null(&sched->pending_list,
+				struct drm_sched_job, list);
+		if (next) {
+			next->s_fence->scheduled.timestamp =
+				job->s_fence->finished.timestamp;
+		}
 	} else {
 		job = NULL;
 		/* queue timeout for next job */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

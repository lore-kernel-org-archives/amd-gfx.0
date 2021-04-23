Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AFDC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 09:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76FF613B7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 09:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76FF613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678436EB54;
	Fri, 23 Apr 2021 09:19:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659D76EB54
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 09:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnZetXmdWLNZddbJ89caB1BoyGAMznEzyCktKfQvFy/o7C7iH81UZoLRPGeM0LrnYldi02lxuDfdhnOHXcBw6MrIbnFJASfuilqCb0d9fUUGpnhnZkDydkI3f0RccfU5m/7fkqSkjkdWlbgczYypbS36vPEURavmB2m64Qewk5J2t8Q8fD/emrR6RBy3Xsi6+tnaRX7WyJ9tc5PlRkXWa1RYO+ao9eCoGoETtFviKFJ4y+yP8gjichO/uBUmkqxHzb6aTpvpP7VL1ZjpSNy/kVCbBjSbpl477NiCFaso250iL6SIG6k1mrsljMHHQUqWgZl6Bu/U/lOi/DDgFDGDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhMjzu6vNg0J4uMbC2jFp9WAG6DV3MJ7U7YCOKpETQY=;
 b=ekI2aX7MQf1GoxSrlikoHXCVI1pSVzBLCKIXV47mDsfHvPHOLKNzVdeXwbsNu1UgY9dZ8tsfPdMdP4oEqblsPSkw1B5AidfdqnCJWAGGPg5acwIyCPIIb0ohwcT9XkN4THeqRmPMWIxNAKZGTBh2Y3wt6p/iRpGhsDeHU81R8Jru4zqDXQ9D/wSfTWIheu53SwSeOG1fZ6PlwsmUKZQG0ZqiX65hxlAv4Fmv3Yh8i+4/tRzcrKAhakxzolSTWg5uYzqQJVLiOFpqo2bkFHrksqfN3iEKuqStV92kqgRUXjdnkRInX7/C7lfKgZh+UdttKozz9xWGxrEu3xsTZaCtKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhMjzu6vNg0J4uMbC2jFp9WAG6DV3MJ7U7YCOKpETQY=;
 b=2+un4HB5n5Rs2tzHfZmfayJ9RWvPw5B5/GsSYFwGifLDd6E5n5EbREEpnnebXwYVGiZULbHRI8vTlxyOe+fzddZsNQ3Fvr63OmCZz+5DP7SigrAfzXMAIQVoLyhnfskMYVEUkqwLpggpHhIu7tU+K3zIX1kHpc+hmhkF6cdpifg=
Received: from DM5PR21CA0016.namprd21.prod.outlook.com (2603:10b6:3:ac::26) by
 CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Fri, 23 Apr
 2021 09:19:33 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::bb) by DM5PR21CA0016.outlook.office365.com
 (2603:10b6:3:ac::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.10 via Frontend
 Transport; Fri, 23 Apr 2021 09:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 09:19:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Apr
 2021 04:19:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Apr
 2021 04:19:32 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 23 Apr 2021 04:19:31 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Fri, 23 Apr 2021 17:19:27 +0800
Message-ID: <20210423091928.39615-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8e8ba5-ed17-44e6-7f17-08d90638e862
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0006:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0006F25B1B08265AB80D512EFF459@CY4PR1201MB0006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slHRBz+fwTuKALP9P/widnyy9ZOWiZu0eZsSr/vSahXtPWsfrkaQrYrvJzTgLiHHTNQB3OQv8U8KYE7AVrAvEzp4tUqnBGj0tgeKhmJssUOJpqASoUZ0wcd9hqwLMMuQy0kkTK5IA3SvUHZprpUz6qVyKjLUECX8cjQN+CsfWcmFaq5mq1eqJk891tRARG07RsgeNbLkjYVvoB8bDFt3R4kHwF7Y67xS4/Qb3gv7IatS/hitmBKukqaydCLa23mPMZrnCOzO++H1tel+1p5jBQj4hKbH/QEt423aQ3uu60Ic7t6fjl4BvCrnSsuosCmfQ1L1eNNWy2g2952X8cg2vDlEE0OzqZMPCEdXqQRdR7EOuSSo3Yi5Om6Z0u8SsKi9jEEiWjtYUhpWrQ8HhFH32xQWqfo2f9W1uvqct+FPcswI6Ksp2yo09EkmItbqfnKHn34CjiDqm8dE7V/9LQbP/U0TJ78beXI0fQsk8etkRMGcSwlUjMjbP9efVAJaoNDWJnggBFfqLuSE7BaRMVG+tEbZ+PD5PaonmJdwWxlgpCcbjgK8T8W5O2o4/gUVX/P6b9m6waZ1JBNeZ49evFlT/WnV5omxamREFxK10Ys7STQfCPJ18M/nX/BsQyaT/pNkDh4dXcOqb79W8k5C2wf2XVPuGnzuHRlE/P9vqcVas9VJSd3IRGv8TQielDinr9lM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(54906003)(36860700001)(5660300002)(2906002)(186003)(8676002)(4326008)(6666004)(316002)(86362001)(2616005)(1076003)(478600001)(81166007)(82310400003)(70206006)(47076005)(336012)(356005)(26005)(83380400001)(36756003)(426003)(6916009)(8936002)(82740400003)(70586007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 09:19:33.5410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8e8ba5-ed17-44e6-7f17-08d90638e862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
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

This is the patch that just return the memory size.

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

Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2806AC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 04:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA22B6113B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 04:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA22B6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C236E13C;
	Wed, 25 Aug 2021 04:14:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6866E13C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNoVL9inLlt9rpBHKZheO+pMIvLWsDrfsihMx4IUQGUq6kGw5HCTTtA2KmbOaAqHCDYt8wug7j4Pcui+vtSsgFZjp3Am2es8Mi5ING7nskoL31rxD4aDQWM5mQVkxgz6KmMiiPYqeyQJF+V94G7Qw5NfAKRQGKVFGabRnCmbckw5SyOwHNfyDCvd3xsqDaBTSkdcaXCIapEx5I+p0xQ3v81Pk+HGLsD61rOrkjUfR6Z5U6PiJA2EN+U/Uw+M0qVzUTDO70K9PVuuHwR2nVCbi7I4UXcnEWc4ndPfAb/r88XQ8oADYNRE+3l7XLJzpHW1WDxZFYiWbDY5Ohe3xnBMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg2MUGlYtPt0g9ADIWSykGG1Y+yynzfXIJpjBjhi2WY=;
 b=ThgoNrdZN3qdEPuhb3FmQjOtXO2Zsz6CXML5XGvmuCD/7vIDdZeRCnS6Z1mqzhbkWy4pR3Lgn4jX6MfeOF8MjENanYNs0xE5NURaVCvC9Mu5dp2SPR+Ku/qL9vY0tllO4qikLl3s6+ILjFYwiPBZulR5LyhXQGEXbKJvLk/VOEpdKLLTot6toND9914MTIDuHy8bGMREqiZNxzeMr+9vlkODp6x9Mh3qOtHeOz8s3qzOT1mMSITxbAZmKw+0ijx8EP+UllAJ5HjyrWtjSZfWBTmq06KBJWA9He7aXq3F/aqxmBvWjcdfXH3c5OP0Y4ucxi8QqW8JZ56S6oapGS2czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg2MUGlYtPt0g9ADIWSykGG1Y+yynzfXIJpjBjhi2WY=;
 b=LPoiovD53Yr4fznkaRRnFAIN6ZTL5hKsby9lUnpDN4zXd9qzk24yAujXDuBw0VycVx8YV/Ae23U+BhhVz/7Fwx6iXEE6x/OrIQbubwVxcLowM6H1K6jnXvgfc23IBEpGx2dasyMKbnsYY1Jc7G4BWpQHPzyyrWXUDqRj64pVH+4=
Received: from DM5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:3:23::24) by
 MWHPR1201MB0157.namprd12.prod.outlook.com (2603:10b6:301:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 25 Aug
 2021 04:14:22 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::8e) by DM5PR13CA0014.outlook.office365.com
 (2603:10b6:3:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend
 Transport; Wed, 25 Aug 2021 04:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 04:14:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 23:14:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 21:14:20 -0700
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 23:14:19 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Monk Liu <Monk.Liu@amd.com>
Subject: [PATCH] drm/sched: fix the bug of time out calculation(v2)
Date: Wed, 25 Aug 2021 12:14:17 +0800
Message-ID: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d7ef2a-60b4-42f6-04a7-08d9677ed0ea
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0157:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0157E320CC3A008B241DE5BA84C69@MWHPR1201MB0157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQIsd/BXBoSGEy8Q1nEU6Qt32rSuCpxfEGONlmpiCu3x41dVN2jvqD9lC5KD+Kv0nLZCs92LETVUW6l2uqSKFIzuupqqm/Sfy73maBrG/PDVLkPE8tMPEe/XrYhd7iVFVx7Prht5RJcuNQuMuZW68t1/pkVacGwuRxVVZWhEBBpCRfiot61s5cARfoP7XUN5yT5p6fkpVB/vQt3mYrnnkUMQJa5eIDeweG8pv73HFBJ+i08NtKimfbP8c5Otwov+Htm1n6wWngZL/h0oXrcMJkcN80mEjDVaBAlFskGHBuwRuovZJzXLKGBi2W1ZLkbfV7doFYa+GCbYrzLXxnqpcMEFzAJozZUd0bnOYymaJZ4Sdxw/pUudQINDLu4l+i8thdFf+TJUM9GJC19dp5iSnYGMG3jyqQeXw225Q3+3nfOpYn0dCHMlXcAstamYVaDEIKWP1pHPOzBCJo7YoSd7spTZJ/aNOAbtZbiNxTR1zph10/Qmcg85X32zMPSF13at83Kxt0uxF6c7va+UF/IM9C30woglgiRNI0GMwj0qcl6+/nroMh0n6Dz48GhVCgNRWqnBwRhKkOoEE4Lsd7mK7s6JGZIYnFJ79ggIeoRkuWWLm4OFNX51BIXIPU8xJmtwnXSIvoSFpzRjM8zv/sEWqZiPvKkjF6IBoG+E0tPy5BnI4GBRUiKMJo1/Lp6nFDg9f+dp4G71iA2FdnxZMaDUer9Mb/HRiEdQRgciYtUvwms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(36860700001)(336012)(82310400003)(186003)(70586007)(83380400001)(70206006)(2616005)(6916009)(4326008)(7696005)(316002)(478600001)(8676002)(2906002)(426003)(47076005)(356005)(86362001)(82740400003)(36756003)(8936002)(26005)(5660300002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 04:14:21.7204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d7ef2a-60b4-42f6-04a7-08d9677ed0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0157
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

the original logic is wrong that the timeout will not be retriggerd
after the previous job siganled, and that lead to the scenario that all
jobs in the same scheduler shares the same timeout timer from the very
begining job in this scheduler which is wrong.

we should modify the timer everytime a previous job signaled.

v2:
further cleanup the logic, and do the TDR timer cancelling if the signaled job
is the last one in its scheduler.

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index a2a9536..8c102ac 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -305,8 +305,17 @@ static void drm_sched_job_begin(struct drm_sched_job *s_job)
 	struct drm_gpu_scheduler *sched = s_job->sched;
 
 	spin_lock(&sched->job_list_lock);
-	list_add_tail(&s_job->list, &sched->pending_list);
-	drm_sched_start_timeout(sched);
+	if (list_empty(&sched->pending_list)) {
+		list_add_tail(&s_job->list, &sched->pending_list);
+		drm_sched_start_timeout(sched);
+	} else {
+		/* the old jobs in pending list are not finished yet
+		 * no need to restart TDR timer here, it is already
+		 * handled by drm_sched_get_cleanup_job
+		 */
+		list_add_tail(&s_job->list, &sched->pending_list);
+	}
+
 	spin_unlock(&sched->job_list_lock);
 }
 
@@ -693,17 +702,22 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+
 		/* make the scheduled timestamp more accurate */
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
-		if (next)
+		if (next) {
+			/* if we still have job in pending list we need modify the TDR timer */
+			mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);
 			next->s_fence->scheduled.timestamp =
 				job->s_fence->finished.timestamp;
+		} else {
+			/* cancel the TDR timer if no job in pending list */
+			cancel_delayed_work(&sched->work_tdr);
+		}
 
 	} else {
 		job = NULL;
-		/* queue timeout for next job */
-		drm_sched_start_timeout(sched);
 	}
 
 	spin_unlock(&sched->job_list_lock);
@@ -791,11 +805,8 @@ static int drm_sched_main(void *param)
 					  (entity = drm_sched_select_entity(sched))) ||
 					 kthread_should_stop());
 
-		if (cleanup_job) {
+		if (cleanup_job)
 			sched->ops->free_job(cleanup_job);
-			/* queue timeout for next job */
-			drm_sched_start_timeout(sched);
-		}
 
 		if (!entity)
 			continue;
-- 
2.7.4


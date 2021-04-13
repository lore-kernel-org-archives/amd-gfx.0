Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8891AC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D8B61026
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D8B61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20B489C61;
	Tue, 13 Apr 2021 12:14:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569F289C61
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3NazVG43UdwR5iTva/cFpJr246hKN9s5inl39vgcc/nw+xTv4Cw23GHgS5I/N6tbwid1IE98wdG6fa03RRG23WYwMlkHv58/993exSyP3Kcf1xWVR3wi/t5fqEvFD2ZKFeOq96koV27yBkS0qh+NtYeWs0gT2JAAMW49hg7r1mNcJGsmQzufFikkMypLU0g8e56yX9TVCM892A1FEIaRhfmKiSv0NKwjQN80QmtQrSwvVbkDqa5mlCAqY/Ln0LJ5uNB3ywCgCWb1HVK0rRm1eMkDetdZO3J9EkoiuxEybYYtXmis8BrhusR5mPLxIxjwhrx4rANScUpyPyyFJqf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=KxUiCIMuRan5J7SgwM46vsUXAGeA4obx33V0r59CH7CRxDrKoGUh3kRwWmXYPxN3cgSouxiUkINb32WJ57z039LX7h3VI6L1jObfVXClWuvIQUCrvPKJ8/3dT2MB1zwIwPjMaudi60tKcl6gDq+QgXGnE6+t9qxMRjTBjYS+qdhEXjmbBatV4soLJlzZo7Gmk2k7EUzPwxRTT1wDZT+G1Esl5OM1EWYUNx+/8WNmQZ0/zSwujeMUbUM/vDfmOZ6YeWZsUdjXjmzuTKNOnTOWxQIPM91Cui0gzwGt7pd8CVckVuCgmY2THUd/fpBlN+gC9+uEPcH3G0rjLQczAn4eww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=IVLHUQwXTP8To6qFs3v0NQKRlcGy/P96+Ft4cC1spaSG50IcniDr3993CjsuR85hX+c8VHC8Qx9c9NWwfqOeRF5sAebGX4ANaEJYKWqnZFe734PpAuuBtZiBwroNgpd6nf+6aqoHuE/NsLkk1adJaZksspyJD+PXIfAJpOHt/YM=
Received: from DM3PR03CA0018.namprd03.prod.outlook.com (2603:10b6:0:50::28) by
 MWHPR12MB1806.namprd12.prod.outlook.com (2603:10b6:300:10d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Tue, 13 Apr
 2021 12:14:27 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::a0) by DM3PR03CA0018.outlook.office365.com
 (2603:10b6:0:50::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 12:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 12:14:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Apr
 2021 07:14:26 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Tue, 13 Apr 2021 07:14:25 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Tue, 13 Apr 2021 20:14:43 +0800
Message-ID: <20210413121444.36903-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95790661-c52a-48e7-afe8-08d8fe75aed7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1806:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1806256C7DD1377BC2954E23FF4F9@MWHPR12MB1806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xN5YYrfw7hFwh4hexGTCqwyurKCPkjADB8731sRlJ1+jCltddSywxTDpN/PUt0JOPnwvhSs071q4MLoYqErpy3uIBE7TgoYJgpIUQG9ag0TzCX8Sul6UzJqVM6dEO82+gZbkbEhZYuaSf6fBCI4gmQ8eF+OibwlNlMNhraet0DtGdcDAcWxjKFbusruiWZJo3LWqYecLlRpgrCxd5jn4Dp3ZbOn7RwJdP9cqG3BuYHtfCUAfD7IW44YrDTIYgeBx/C9R70Sr8DEb8hje66cXNNzHz32mv4WD4yCgYirn/7qbNaLe0NJgFZ7TH9N+0xH2KyzU9HVPCvTxJz00LRdzs0uRFMHabfbhwDY53ATXhQCROVIcDnWOSDfr1jVjb2pEMot2xGY8ntu1/8nCQSY0qzMZs2wSEyXALtIitoOgLZ7tdE76YMXvetZZ1N+28xYwn4hPCHYgrS15KzTB3Vp1bUX+PNugntH0OYE3n5tTrnoaqhHFlhQzxC9p4+E8pkZBcw8y0RBtDUn9kh1M55VdupADyLDJqkmtiwirPYQ2LHXHX40brjyQ1pY93CP7VAUhaGID2AI19dcW496c/s5woznPMOvzSPaXNm0rqTpDlUBr4kCibJ2QPprgbwxYVj6yxcmGfQQQdse8TopbK+LgTWwmRhSU+vOXyknOD/8uPxGSxx2cjc9IdSHpCqs7KbQB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(36860700001)(8936002)(316002)(186003)(426003)(36756003)(26005)(86362001)(2906002)(82740400003)(70206006)(82310400003)(7696005)(2616005)(4326008)(356005)(81166007)(6916009)(5660300002)(70586007)(478600001)(47076005)(6666004)(1076003)(54906003)(83380400001)(8676002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 12:14:26.9925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95790661-c52a-48e7-afe8-08d8fe75aed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1806
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
index 92d8de24d0a1..4e5d8d4af010 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_resubmit_jobs);
 
 /**
- * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
+ * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from pending list
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

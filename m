Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC97C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 10:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDF961464
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 10:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDF961464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AE56E0A6;
	Fri, 23 Apr 2021 10:55:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF9C6E0A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 10:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj5nOTXeMTffrA5nZkIoWDRPNR0ua2mQHYL9Su9CiWzxSzm/2x/FB1/DgHGHGmireFR1HqVm4GXNRgEtEHRT51YasVwI9y7F5Hh6zNbllTePqwc2VIXM3mreL81iwy12Hu/Tp+7cyQDV8I4CBjjICppSzrju3rTMt9RP3eTRsvKZbkolaDEfmA+uHOTwL8lAE70jYtJX88k6EZ2oT/sGPmPWxvI21hdHhu+UBEPtDWC4wL9OPfxqS1UkgS7rHpXL/zPk/aIySLpa7IEGGWPdmCWxi5DJlQtEAIP6nMSetlEnwG+OgBq2AK2KjTGtsy/3SLnl7toJR+edr9HFuSD2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=V4SnajZ6XreRfvN13l9RM9IRLG1lNd/fuxIYnAIpzPIbLdqsAGdWc7CRuJBtZ5i4jT774FcE8YrxGfy8wgyK9HlhzftqdyLO3EExbNEahX+VePbVnxA4yXhR5aYmfsje+gkV4q+rmdSICVNzeLcTuZxtaj/Sa/KxBkchuM8CjPayJsmHcKUqnT1vA9SvQogsNKquHGQeI3w3WBNKYeLfHR4R6d0R2kqMiFqSpo5mtctBlDXiMTOzLqO5R648LHoUBibgpbUoU2/U9CCD/XYSOp9WwMaQDZEkITU33DCMVLD/AM/eSFYuZlW/eVNkVT9puv1VETv9epL+IRkMleKzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=XiAVEATzWJqBDWCG6Kauc5XYGtA8gXxiWK+dv7m9HEYGpdKIz1UrX/I6WYm+BEA8KhiTaO6LMzxa1Yj6z15eJ5+7MI+jh7KddJpRQdYuXhFThOYkvxRu5026R/n8kQWXsIZfvQXhLklncg4dWr17ttCqbChjjwSv+OHDSYvGiAk=
Received: from DM5PR19CA0002.namprd19.prod.outlook.com (2603:10b6:3:151::12)
 by DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 10:55:15 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::b5) by DM5PR19CA0002.outlook.office365.com
 (2603:10b6:3:151::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Fri, 23 Apr 2021 10:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 10:55:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Apr
 2021 05:55:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Apr
 2021 05:55:14 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 23 Apr 2021 05:55:13 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Fri, 23 Apr 2021 18:55:08 +0800
Message-ID: <20210423105509.23025-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 712b5111-7dd5-4ead-ea86-08d9064646d0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2469E3A2A0F2029AC6E3D01FFF459@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWkkuJKWf5Z9SxLWIS9oNvA/6FZU2Oxluf7P32GwhJuee6YmLJPUYoQrO7ZTl+GzP9uIc6WEXD8cDrEI6AfP5rzbzADMYG4DMvMgcgz+NDF2N0R1FKfMNn3wQbSBtoT4YXE2qVgDRXVcBadMr/lSEedsdEU2A77PIH1AZX+tiDNzbqIqT9+PsD8f9C8RK00dg0mWhvw2nKu30hkrJLGnW/2P+j4jSjgkqAkFWoTg8rpMpUNyuAL5mrndtCrmpVW0h5pa9XXoXRXoEyyPH8yplDHEinIZfRGbySnYOdqej8D4tmzpq5G2Adsl4T/boUaspe2DDHaIt6N3heYK82zKhUQHZd4fcOjAIUd/Ddnd+c1bVZJIUHKf7gvY5I5zZHWPXvt+nmLpZlhKNPH9oKhPlxENRDtbFHiIeI40pAoYe0p+hLbnbQ0+zD6/gpQoWLZ+uAuDISRVTcuwTakfqZhmSJECFi5HJdM5m/i9luEEteLxgyQSn+XotzrEt3mthW3LyAcCZuW3lRnxB9I32yXd4zy7r3j2mFR7W+9ly/UWWLLtanWzZEpBDmec408UtsXVMqaN2fDSo332ZoORuKYYSKuwWRdzNvQdW4KLgmdOd1G/tu1OlcX/wdN+VpyqMzc7oYl5NNUUTHoVIpzdezyKb6zKb8W0+Q6FEV5/9R3uwJV++/ghC2lFKWQ+2QCCf+kl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(356005)(316002)(426003)(8676002)(86362001)(4326008)(54906003)(26005)(36756003)(2616005)(83380400001)(81166007)(8936002)(6666004)(336012)(6916009)(82740400003)(36860700001)(1076003)(47076005)(5660300002)(70586007)(82310400003)(186003)(70206006)(2906002)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 10:55:15.4160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712b5111-7dd5-4ead-ea86-08d9064646d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
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

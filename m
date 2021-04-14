Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC535C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B926113D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B926113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB7C6E87D;
	Wed, 14 Apr 2021 13:59:57 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750053.outbound.protection.outlook.com [40.107.75.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB9F6E87D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 13:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcSL2MWGt+PxmQHNfoKjvlWlT/ifRuO8edSYjku6TClzutm5bav00V8Ks5MMX6g19YbprrO8yPTAjvcmx/aTY8oR4x2QkRQ8WWs3WPHL++OY0a6gJSMwUxpx0eMl3zMB3fmk3SNbDaUmAX6ZQSRHPVWRZYOA5vJRfznVdOAp97yZV5WOQ1eheILhbQaYSn6jhyUnK5AvTxPtbaUK0XZNY4w5zdbEWwYlAoVW/KtKNca0Wmytlu3STdY5whVrWkaNfxnVJRZnBI8OHbGOhaf5HPF/8pJv8JLKLdZyPXhg19dtP8Y/Jx3HSz0qS1keDVQ5hiNyNIdX0N6Fy9/h2LleAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=HFeeMNYieCbeK9ByzcIFTYeyfirkWqG8OLX0odnbCmO+wEKeyHyM3grB1a2qpsE1/FO4ZWBR+8c4lL6octV9igWNZ3+v2h9kUQMVOgJGISD32jFyGooW+hR35GBuG+F/ztNEr6+uLsNtN27qgN+p756qo7hDuXNtdcfmKUGTtPErTI/qshsNChjqbYOoPHQk0IaPPxsekAwpXet2VUZOKYrZyM26ZStOXNMflutgCh0SpNOZFrwMw0VygZYhGNHV5mXVmyQXVTZOQiPxCzvf2HHGEdRH3X0mnaLU7W0qU3WxP3QbDSihRW9yuikVwnxjMHNWDejaER8SVtr7JS3Ruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=aMY5noYw+K8AVTU6ZCiz/yrpjgMVH/vYOOWLTNzkOvmjUBs5PsM8vGBd/16wkAl2xikztrGTozJCkT6S5LLDF4jAlZOkPCh8JfXnG5DHPP0fyyV0c+C5DEi8zmfdxK/C2SwsBexdA93c2d9XyC/ISZxBq4A16CaxEldtO1bcyus=
Received: from CO2PR04CA0089.namprd04.prod.outlook.com (2603:10b6:104:6::15)
 by BN6PR12MB1810.namprd12.prod.outlook.com (2603:10b6:404:107::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 13:59:54 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::b4) by CO2PR04CA0089.outlook.office365.com
 (2603:10b6:104:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Wed, 14 Apr 2021 13:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 13:59:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Apr
 2021 08:59:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 08:59:53 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 14 Apr 2021 08:59:52 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Wed, 14 Apr 2021 21:59:53 +0800
Message-ID: <20210414135954.23665-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acaf6d6-1f30-45f6-3660-08d8ff4d94b8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1810:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1810326A8031808AA5B5923CFF4E9@BN6PR12MB1810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FN+cgLBIJ6WDWi8EFeW6rKLDVdNxHsmerw3mgDwAq/61Q5EXxFn9LdoTiQvMowrTyqMKbmI0UIAEpYL5N005EFwZvphZTxkCdrqaOPSk40cuqGNWH6dJs24BoCNRo04dbtxY8VauqqP6SbPpktwomUSF8p2qUe0xhkhst1QbI/7ah1jNhXdZ90MCdeuBSP3lulNunqiq7htfpZMQklKrO3EpO5cFvbceh/nSPA0cnpEaPQebjqLH5NVo13g24CUYY58fl+NDAzGbmQqK1Kljz2MVyKC1Pq4gf2Uo9iI9PzGq7AnXMwJtqfxuVqCXaB/5VbVwcw8QvXeqohPA6SxBSMy2PZOVRt0/Pdj4MPaht/gMsbkKbo2EXpRRbHKF6uGZiUGnRRm0Hvskf1UANC4yNfpssPOCX2UfsXs8RPs3NxbHmtFBCZmMvA7KAHjvDmkQ6v5VWd6U6km7hZZUEOg4l24VUAvqVqyKMZNGxEfHwrUoY1XtEwwmMX8GlvosaWQ9QwFWYvccwdVkw+Lkic6Lpt017EGFFtiRplB/dlvhdP+Sto48kSmD2bycaEKxpIwMfBiOkU+BJVYxaiK77xvhFZ0TbtPwJRNYbOq0HQntsNdaEOPRkK+XpnaUXHIR6JELqr2fC7ljE2OyFj7nsgajJTUAYQSXCloRheimhJVtNZH4eYwMClm4IPthut99MG4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(2616005)(6916009)(81166007)(5660300002)(8676002)(4326008)(82310400003)(7696005)(70586007)(70206006)(8936002)(2906002)(1076003)(36756003)(54906003)(82740400003)(186003)(26005)(47076005)(478600001)(336012)(36860700001)(316002)(83380400001)(86362001)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 13:59:54.3971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acaf6d6-1f30-45f6-3660-08d8ff4d94b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1810
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

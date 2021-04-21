Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6802C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 08:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356B361158
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 08:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356B361158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC2F6E192;
	Wed, 21 Apr 2021 08:04:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97BED6E192
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 08:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2beCH8uExdZ3UuB6as+ZxusdjnzA0fx1q9HyIQJMetx2nRxUPzC8qoOdCBoWn5gJmtZ/qiuRK+ByAmJLQVq3ad0sFNvBLa6RhQfQwONjloBKJ+8WFThoBmF9IQEzib5923RdLWhRGXi+XRTTtEYjBQMTK0ywDFTY5qMpWgsIlFxEmu3znpaAy+hP9/ovJ2oX9PQ3W5HhhLnCIwpAlG7wX7o4B+LyWnwj7J04s49W1gzfFHmht77uxX2+GvQPQjqYbbdxks5OhE+dOezgVj+P7wSzdEmGNDCFLMNFnsoHItrmOG3mU7O78DZYnFNMF/yMipg11O9m4b8QN9wm6Nijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=Q4LA83rYNJKAOpot0fYEjvU5kdq6yRbZOU2zPT00ZGfLkjqw1kA13imxpeMfYee2qfIHkH3EYHu5qtE1xlCubGFlVgdwlQENljga14ZttlrfdkT1G2e/cK0kc8u5Yl4Z1+2kAWpaPb7qOS5MwXKUfhcIW4qojn3PpWtRgOGm6KLV259WVDcSFWNZI+p3h6/gl6CfBr2/vzE7YqB5B9E/U1+94MM8tBnie/ZAL4fONGyw4Fx4D7K1bjsqFDJ88ygh3Q7ihJVbS2T/kSumRLp9O9B7aPI84LaCxV61gVoG4XNFyrp4MyzyrQ1nB56QFh12ImHWn6/5B+SKmJPF8JVNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfNztJeR2+grNyGZCfxsIoyd6iJx1C+vkvZG3/VjIF0=;
 b=LOQeOjQfCpGi1Gd61OjINMRgXKFS/WYuCdGIVPJrdkzpuK/UsH9EAhB+aLO9RdwGRgaqbMR9E9jssYjjMmmCu73G0qVA5yam+xDTWtZoSfT1o+OPBQmpZ5BzNonSzZrurCalTLfh4q/e4cbmQwl+mAsfnhrqofzs+ji++E77jlQ=
Received: from BN9PR03CA0656.namprd03.prod.outlook.com (2603:10b6:408:13b::31)
 by MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 08:03:59 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::87) by BN9PR03CA0656.outlook.office365.com
 (2603:10b6:408:13b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Wed, 21 Apr 2021 08:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 08:03:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 03:03:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Apr
 2021 03:03:58 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 21 Apr 2021 03:03:57 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Wed, 21 Apr 2021 16:03:54 +0800
Message-ID: <20210421080355.34446-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c07cc1-108d-4225-c6b7-08d9049c0508
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1677664457A100741518A3BBFF479@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tM84rqt4J/KBaHCEUPhYU1rCkM3Y3jeNagSW1D7l1XZbO/Gu5Rm0ntJdlcBPT6eb29ptOK2vTMQ4rgtINBwKKP+b2RnF55jILiwag5DlrGZF1EdFOtQue/seL+s6m3vsWII/JcZcohxNWrnnQ/vqksgvnX1iLzRF0Sj0HpfR+dGQIhZokyYge1ayKQk1XJsmm0W9gd67EFRBSGYtyafFpPPsZw54q4lOorG2uzpyX0ShgXj2F9AZ8jfPPjn6dLQ0U17poForS67h6i/sv1JmvhkJWHjuSYBKzhBNH3uh8XZN6iJ9wxemO5+117kED9nwtRQ5ZfRmRzs3eYASzeTJBAtxHQ9MPEpECGFNii0jegiWHtADdJ9+ITnYxOV4tUoAeAiTt7wPA8dxGGObX075QG+iQZwhMw4gy/E3H6ZfqQejjEW4dzivfiDKnJxHcHBAOdDqhCCkoRPF8JxIjO2ViaNFVYqQuOmI9HEEtaM/GstKFqwa7xYOye6KAEQ/s4E+S1693hEmIwrHvN2lQj1QzRlDUu/4mlL/+ESeRJuTRwaI8pVBtYbcZN978zTQ9jkK8n+0UXFbHreEAOw7D0KRUM1crN50BOy5hUwbiMC1CwcUXgiciHePrVhLU4SgmYN5z9hZhU3jt1BrvKJKyzVPjgHMqngjwc/pfQubp9K1gWu9W1GubomQqVFnA3ICpH/O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(316002)(82310400003)(70206006)(81166007)(70586007)(2616005)(186003)(4326008)(1076003)(5660300002)(26005)(356005)(336012)(82740400003)(6916009)(478600001)(8676002)(8936002)(426003)(54906003)(86362001)(47076005)(36860700001)(36756003)(6666004)(83380400001)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 08:03:59.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c07cc1-108d-4225-c6b7-08d9049c0508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
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

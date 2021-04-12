Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE4C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 12:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C313761263
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 12:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C313761263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750386E573;
	Mon, 12 Apr 2021 12:57:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4664E6E573
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 12:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAZKqUm56gqpG/PISV/aGUZwUFJpsP5BqMd3QwJ8jCaetSkt3BgnqmCTjBVXbMoWW3cC/9Nvvz6tT64sGxNssPYP+775qv/tQ0x0LeY3k8xmdhEkRCVxvEPBVU2OsaKQs4BcQsOKY28sE77+Yn1TxnHhTIpCm7vKQ6BCTdH5Hpzhg/hLcWXqYXN24tpQqAb8nUhheB/gaCAmJeNcXUsopWEU18WePqNPkz/XQC8wkinyMgikq1Iv5CuCJa6a58fNY8HXRoGMo+XM6uoqONMKdsT2IunIwpNsBZZzZbpzgHENyC3ZnEs8TVWbYywpd0O04d85jS+8VbrPi6bE2HnWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=kDNuom5gCdyXKvbJVaAQP6M9j4XosBUr7LCE9brneLSGOV+Idie86ADzcybaK0UnEzfIKPMFSdEHA2byYKcr0OTWuTjOPzc9aCurepJATkAnx2XyNlNzwcm9T7BvN9byrI9G9aXxawJ6lkQrDimoF/WOxJjrUis1p+ROptiLB8gN7TioaDEsfGDv7gRUhdizRl9o5AELbX21bJlUHLvKEm3uQz3tB/Yt1EuuZuJf3VRdQeq//7XiwAlfrYjrL52ORZDC1vLorbfwHTirOTvYR55nt+900z+tBwg6FESoTQIZoJCkuxYKUxTuvxWNy0TgsxsQf18VkP4LvB+RxRM/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew/R4BVFpYX3iEQWXuOnsDcmml0c+Ozr+pLTynzkMNM=;
 b=OKq07UZk2wv6RAZnF853Tfk/9tvFshSqbgU2ETF/5+ChyHNlv6bZi97rLhC9xnPLI1j1BvEuA4nGPHtgd7HVP1aGDB0jXpRV3PJ2hVUDlipqBTMyYW0wPbniIQfKTlAXDjgShq0aaPLWSpzC8Lj3y9DpLR7tnUWHtJfks7qZ1s4=
Received: from BN6PR14CA0042.namprd14.prod.outlook.com (2603:10b6:404:13f::28)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 12:57:50 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::3b) by BN6PR14CA0042.outlook.office365.com
 (2603:10b6:404:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Mon, 12 Apr 2021 12:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 12:57:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 07:57:49 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Mon, 12 Apr 2021 07:57:48 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Date: Mon, 12 Apr 2021 20:57:50 +0800
Message-ID: <20210412125751.25812-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44756d9a-3737-4144-3498-08d8fdb293ec
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49026B078215E5429C600774FF709@BY5PR12MB4902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMWSeBJ2+46TfVrTPX3nwKvUZRZWDP9jtXbP/dkseYiXv/h9edBwVykTgwcXegoqCNxmbOp8j1Vmix3QZJ9wjpv6wRbplNrEW3QlPFoy/VAVOz40Etj+aZaDapecIVYDnOG5GijMv1mv9rtYR9uSpPnCYUDZWK2yPnM0V3Xu16CbM8madZx7e799BS1y7JFOL807xcR/4moc8aQQNd6HReOcbtYJp0SFAI5jCZLrq0muy1paU5zx9tn8TcGGaaaMQKiigtOIdKqMfv/xATttj1UR8VYmCiu5FvniZZacIM0ylBYuD3z6fAEQblOkojF0v3imiQ31oCinSSFekZU59tOFxlYn8cXUvG78fwnRU85avUXFSKQbLqaAyjiMFrgZfaXd6RcmFfzVB1tBMhpq32ptanR0uW5BA78G/a2ImJVcmF6CzEvZmWs87AIgpDv5a7vaVALnU+VGB4Ht3XhI1DcGmWd8MXxeP8mAq6gF6V7QQrE9MAu9Pse8Jh9pD+3JxmjQfzrVd3P7L7RRv9VVHRCNL12BN4DIPT03EEq9e9dlpIAbCK3Nd0ZYNqDUWhPi8Qx1zt25q16kJrugN4A/WIvCx9Qq2tQysN0bz+4lpNMrjotdQPU9ZfBibOk+3FHYNfIHDjpPz8Szj8ufir7ZD55lbUnIgOw3/VWMMO+54iR2e8FQiSdZT++vb8pxgqgS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(4326008)(26005)(36756003)(82740400003)(81166007)(70206006)(186003)(70586007)(316002)(336012)(54906003)(36860700001)(83380400001)(82310400003)(426003)(478600001)(356005)(47076005)(8936002)(5660300002)(6916009)(1076003)(2906002)(2616005)(6666004)(86362001)(7696005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 12:57:50.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44756d9a-3737-4144-3498-08d8fdb293ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
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

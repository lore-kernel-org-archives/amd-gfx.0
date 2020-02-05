Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE9C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7A02082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E2IQF3Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7A02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C624B6F984;
	Wed,  5 Feb 2020 23:29:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB906F97F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKoKB0XJMTx9MrGK176FWvlcOGQ5TWIUUGNTTrenLRnmT2vusTDij7qAVCmA3EdzURP9uJVQgf6TbToaIgCFfjmt7cysnU93rbD0bw5nRt7fAL/gFePsNKzLmAi9lSi7jKHVJoocvSEgPae4bKuL32nCtYy4LvtMKWR0MnOlIAjtaqVy6wjGXW+8yTpEGJWw6/rmD/N65MGoH8SwbfO+etQO4VYj59OVkLGoMuBXbY/hHGM7bH7QZRRcLyL4PvJSnA8YsEqPevQgz5nLcmsHZh73S2jfZqWscCY3Pig+0zMApD6hm+2NPLn2HQcYLakymDx6Szy2QSeCqfNApQIgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cau3yBMKn72ACxmqBvO/UYNuuu+cmy6KRcEcpwCwVU=;
 b=ZvfCLMLHS0lVf7ifBXPRgYv0NFmzLXGLGVKXvJz/yGCRLbp5seqCZCsUrrKa0IIq1nVNFTFzkrYYQ1xk+p2JnHHXuMQYGSX3Ho7Sb7PEK3i2Zpk0rEvLmeYE+7qLVcbcdi4eiw9+H992GMqX2e6Dc9gJ/2De3cU3KjkIVbzQCM89/xM6S0n71O8jq7hGld8blGfv0d8yA1AaL2brmBZve0TB4i6us3b+aZLi/MsCmyYdsAvcVjX2yXftsO58XwHjJWQ56AUcuTlCdZfr3ZLWiEvh4rrwt60VdBvUF4Jb4P0km9o4RSfVpXST/lSeDp9p4ZK0oN+3V2MbLBeSfF+FWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Cau3yBMKn72ACxmqBvO/UYNuuu+cmy6KRcEcpwCwVU=;
 b=E2IQF3SaTjd+OJkmnu01sBo6DymVGxK4iTOnYYjierdi6j//I84p0IQJ1z1hAfdlSdPDjLCf7XtNdlZCkCNRez5N0+3afI8y7tXVpvwjQf4j2eI9s/M6YUt1OzE04X2GjHsdn0jsQvOIYHCHR+W7dICvhSUSrp1jvcv/Cp6rckQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4072.namprd12.prod.outlook.com (10.141.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 23:29:39 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:29:39 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdkfd: Only count active sdma queues
Date: Wed,  5 Feb 2020 18:28:31 -0500
Message-Id: <20200205232832.26226-5-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205232832.26226-1-Yong.Zhao@amd.com>
References: <20200205232832.26226-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 23:29:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a8a478a-06f3-46a2-0aed-08d7aa9344fd
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:|CH2PR12MB4072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB407246CD66959B5706238FCFF0020@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(4326008)(2906002)(6486002)(6666004)(66556008)(86362001)(478600001)(66476007)(8676002)(8936002)(81156014)(81166006)(66946007)(36756003)(5660300002)(316002)(186003)(2616005)(956004)(16526019)(26005)(1076003)(6916009)(7696005)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4072;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/3lB/B6HVcdU9B/1SvHh2Y9FUzpV7sj2FK9xFlHvKFsl6DwtvlVXVv8Do4TmYMZt8EJiqTx7AHKiEJP+df1tGDLjk6HiH0dby2Fs9c6ylOt9xJYvnIugW/wSffa+r+7kknU0zfXTaF75ghfkI29MJQ9FSmfLWT4tM7bph4Tsl3xmHgH37d63pcMisvOVxr6bO4GyVc/swrpm8s7fcOGcQd05CcSWJ7/etw0kMNZgZte+p2xa6p0VLXDwntslIB1gwj1L+Y0qwdQZslA358wm+pP8mg9KKX6tcPlMjMrEebluR/h1axvDbR0LjDBkKXncYJLb39BUFEHgCq33IWZqPnccLL5jQapVWm8ynq9c/yu/6xgCFFYzWKKSXj7703FCYd/AiJPa5/QehY/mhgmVEj1xui5UO3s0hd0gElc7WtyXmCu8+jHyqqqOWCTzLoi
X-MS-Exchange-AntiSpam-MessageData: KKzHcaF1EGzaPf1RKmNc9W+OuHW4rmmo/WzHTTmUAGjwfiOv4teXsgBXsEry0kEVH8prOc4wjAartBdvwmNY7vEp+KTKWxMUtgtFTONvlbOg+RBQ4YViK3ekEyVRjSMtrqCjFo4BYRzhVOCtDA19zA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8a478a-06f3-46a2-0aed-08d7aa9344fd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:29:39.2501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHMxIPkt1Ygnf35jtp6GhFr26MUAc4+0auerxX6jYrL+oL2j/YKNBV5PjAmkBjoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The sdma_queue_count was only used for inferring whether we should
unmap SDMA queues under HWS mode. In contrast, We mapped active queues
rather than all in map_queues_cpsch(). In order to match the map and unmap
for SDMA queues, we should just count active SDMA queues. Meanwhile,
rename sdma_queue_count to active_sdma_queue_count to reflect the new
usage.

Change-Id: I9f1c3305dad044a3c779ec0730fcf7554050de8b
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 54 ++++++++-----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  5 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 16 +++---
 3 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 064108cf493b..cf77b866054a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -138,6 +138,10 @@ void increment_queue_count(struct device_queue_manager *dqm,
 	dqm->active_queue_count++;
 	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
 		dqm->active_cp_queue_count++;
+	else if (type == KFD_QUEUE_TYPE_SDMA)
+		dqm->active_sdma_queue_count++;
+	else if (type == KFD_QUEUE_TYPE_SDMA_XGMI)
+		dqm->active_xgmi_sdma_queue_count++;
 }
 
 void decrement_queue_count(struct device_queue_manager *dqm,
@@ -146,6 +150,10 @@ void decrement_queue_count(struct device_queue_manager *dqm,
 	dqm->active_queue_count--;
 	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
 		dqm->active_cp_queue_count--;
+	else if (type == KFD_QUEUE_TYPE_SDMA)
+		dqm->active_sdma_queue_count--;
+	else if (type == KFD_QUEUE_TYPE_SDMA_XGMI)
+		dqm->active_xgmi_sdma_queue_count--;
 }
 
 static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
@@ -377,11 +385,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	if (q->properties.is_active)
 		increment_queue_count(dqm, q->properties.type);
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
-
 	/*
 	 * Unconditionally increment this counter, regardless of the queue's
 	 * type or whether the queue is active.
@@ -462,15 +465,13 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
-	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE) {
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		deallocate_hqd(dqm, q);
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		dqm->sdma_queue_count--;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 		deallocate_sdma_queue(dqm, q);
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		dqm->xgmi_sdma_queue_count--;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		deallocate_sdma_queue(dqm, q);
-	} else {
+	else {
 		pr_debug("q->properties.type %d is invalid\n",
 				q->properties.type);
 		return -EINVAL;
@@ -916,8 +917,8 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
-	dqm->sdma_queue_count = 0;
-	dqm->xgmi_sdma_queue_count = 0;
+	dqm->active_sdma_queue_count = 0;
+	dqm->active_xgmi_sdma_queue_count = 0;
 
 	for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
 		int pipe_offset = pipe * get_queues_per_pipe(dqm);
@@ -1081,8 +1082,8 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->processes_count = 0;
-	dqm->sdma_queue_count = 0;
-	dqm->xgmi_sdma_queue_count = 0;
+	dqm->active_sdma_queue_count = 0;
+	dqm->active_xgmi_sdma_queue_count = 0;
 	dqm->active_runlist = false;
 	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
 	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
@@ -1254,11 +1255,6 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
-
 	if (q->properties.is_active) {
 		increment_queue_count(dqm, q->properties.type);
 
@@ -1367,9 +1363,9 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		return retval;
 
 	pr_debug("Before destroying queues, sdma queue count is : %u, xgmi sdma queue count is : %u\n",
-		dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
+		dqm->active_sdma_queue_count, dqm->active_xgmi_sdma_queue_count);
 
-	if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
+	if (dqm->active_sdma_queue_count > 0 || dqm->active_xgmi_sdma_queue_count)
 		unmap_sdma_queues(dqm);
 
 	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
@@ -1444,13 +1440,10 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	deallocate_doorbell(qpd, q);
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		dqm->sdma_queue_count--;
+	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 		deallocate_sdma_queue(dqm, q);
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		dqm->xgmi_sdma_queue_count--;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		deallocate_sdma_queue(dqm, q);
-	}
 
 	list_del(&q->list);
 	qpd->queue_count--;
@@ -1673,13 +1666,10 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 
 	/* Clear all user mode queues */
 	list_for_each_entry(q, &qpd->queues_list, list) {
-		if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-			dqm->sdma_queue_count--;
+		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 			deallocate_sdma_queue(dqm, q);
-		} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-			dqm->xgmi_sdma_queue_count--;
+		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 			deallocate_sdma_queue(dqm, q);
-		}
 
 		if (q->properties.is_active)
 			decrement_queue_count(dqm, q->properties.type);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 05e0afc04cd9..62472a186d4f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -182,8 +182,9 @@ struct device_queue_manager {
 	unsigned int		processes_count;
 	unsigned int		active_queue_count;
 	unsigned int		active_cp_queue_count;
-	unsigned int		sdma_queue_count;
-	unsigned int		xgmi_sdma_queue_count;
+	unsigned int		cp_queue_count;
+	unsigned int		active_sdma_queue_count;
+	unsigned int		active_xgmi_sdma_queue_count;
 	unsigned int		total_queue_count;
 	unsigned int		next_pipe_to_allocate;
 	unsigned int		*allocated_queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c604a2ede3f5..941b5876f19f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -241,16 +241,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	switch (type) {
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		if ((type == KFD_QUEUE_TYPE_SDMA && dev->dqm->sdma_queue_count
-			>= get_num_sdma_queues(dev->dqm)) ||
-			(type == KFD_QUEUE_TYPE_SDMA_XGMI &&
-			dev->dqm->xgmi_sdma_queue_count
-			>= get_num_xgmi_sdma_queues(dev->dqm))) {
-			pr_debug("Over-subscription is not allowed for SDMA.\n");
-			retval = -EPERM;
-			goto err_create_queue;
-		}
-
+		/* SDMA queues are always allocated statically no matter
+		 * which scheduler mode is used. We also do not need to
+		 * check whether a SDMA queue can be allocated here, because
+		 * allocate_sdma_queue() in create_queue() has the
+		 * corresponding check logic there.
+		 */
 		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
 		if (retval != 0)
 			goto err_create_queue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

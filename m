Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65616C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F522082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c8S8kdou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F522082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B746F97A;
	Wed,  5 Feb 2020 23:28:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0EE6F97B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd5QHTQpO+X1PnG7rt+/zNkBhChWfn0M0C+6xFzRQKVZjBhrUBsT6uyx3PX9LTkKW/OWxTVQEDAEetfrmAYOxyAhOpnzmJX/pjKshvvWCDzSbr9zGsDGGDNSM9cQEMY83+vBfCJw2/jUCxL7VqXGe+mHwlAdRXulC+w+rz6irZNxB9EzMzHGZBDnCbA0uSzsfmF9NpIzwm6wQKtG4d/LzkvI5VmPAscgN+bzdAxluBXAOiAV7WtjWWsxbkk1CeGTzUin/twOaaTUYH8oxk8c53rDOz3HmglEKWw98ytjwuDirNg4caUDrmnj/bgnvpgTjgmSEJaNOsBsGzYbj48Zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyLg7ZsvHpfeI9BRynudaQD6jxJZjNCrABi9WgNfJpo=;
 b=XzOSuYW8LwrnlaRivjLPDLhQJXezyDBt3R5MkOM4Hk5krg0bD4uqOjXAkBWFRyGniYLVV07ifzNpIGbm0H2nB2xXwm3y24mY8mYNVWfDiwqXGj6Mj5TMvY8al53Y/9AnmW/zBVux1ZQ0HQDhmGEcf3rslE/c0uAdt5PIwWprEgNDJDADvCc0dVAxx6mkiPlekuQZKAiA6Ivs5r2NbYp9Q9QB63tgAVtEzy12e6Hwb/oPectnXXRp+VlS7V+VmR0z/9Gmb/O52pCBS5JK/qXGNDT3P0d+ytymlPVx4NKwnvhOWSoSfZN6QXjbNmJo6kA4T4wzs1gTp1DgMzm9d7u6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyLg7ZsvHpfeI9BRynudaQD6jxJZjNCrABi9WgNfJpo=;
 b=c8S8kdouPSfvYR/eQpij7G3R6T/gG9xfILSiR1IdrSi/ac5RJJl2xSMB5Nez39IyuJLAuErCQttcjpR9NuQa3VSyGXsUzWPGTaCdiamtk2dir5uF2sTgJOnoam1zZhPqCcP8H0LNv17ptsWejhLOGyYgsQlyIiclQAdBBtiv3WU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4248.namprd12.prod.outlook.com (20.180.17.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 23:28:46 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:28:45 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdkfd: Rename queue_count to active_queue_count
Date: Wed,  5 Feb 2020 18:28:27 -0500
Message-Id: <20200205232832.26226-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 23:28:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb2f4d16-2a0d-4420-cf8e-08d7aa932501
X-MS-TrafficTypeDiagnostic: CH2PR12MB4248:|CH2PR12MB4248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB424894E834C49B39EB6E8153F0020@CH2PR12MB4248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(6666004)(1076003)(86362001)(2906002)(52116002)(478600001)(4326008)(7696005)(186003)(16526019)(316002)(6486002)(66476007)(6916009)(8676002)(66946007)(5660300002)(26005)(81166006)(66556008)(81156014)(2616005)(36756003)(8936002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4248;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQSEhzyB5udTCOGXaWCii+4c0VI0pU9B8MRa/AfTNjjKvZ4pRhjyRoeFD0OitvcGAUg+YGMHSPEv8LcttLWie2aUyUJINswpUePEe6g9pCQJiXQQbN0xSItGMNRbpHbNO2fCED9oNs9/LOXir0Vf7ttTlgILg2QxQw71ZhHF4LDJvK3q67QVvcLUuSEDZIy0owBKoyZQ3Lwx0XbMKR4cJN8c5JtTqsNchx/xWu1hwqVoZzSHQBq7dIL3aAlTdrcA9l3uj3EJ9MIk6CwYOTovNb3JdwTvjPp5ihOw6Y3Ql4eJP26WnewIaPAFj2010ta5hEpgV2jb3KtPRU0M8GHDWJdoYgZmDAo2Njmva9Qh7eTM43i2fuYiBBWHGxiMzmv5Ixf6EUzyqNCu4pN9BF1frNu/oH3gO8z594gRmqK49/5WZ84Q5L7NiEkxqY4skHJq
X-MS-Exchange-AntiSpam-MessageData: uzH3nnrmUOzm+rDNOPJJnymS8PJS/aGnM9JhZ8nWT3Njfdg8nvxkgtTRQN0woDmPf8iGfInXna57BOXbTrJk1qw/5FPOIxR+AMMFvSm1uP+Wx4mOleCMzxZAkOs66d55+JIcTtc0kSbqncNQEJ5XjQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2f4d16-2a0d-4420-cf8e-08d7aa932501
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:28:45.6503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDYhfzXkZfcwuhjs2JnmRNkGC8vcBQoAzyAPRD55GTCcj9+NkPqmh5D0XlNzyf5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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

The name is easier to understand the code.

Change-Id: I9064dab1d022e02780023131f940fff578a06b72
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 38 +++++++++----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 80d22bf702e8..7ef9b89f5c70 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -359,7 +359,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 	if (q->properties.is_active)
-		dqm->queue_count++;
+		dqm->active_queue_count++;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 		dqm->sdma_queue_count++;
@@ -494,7 +494,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	}
 	qpd->queue_count--;
 	if (q->properties.is_active)
-		dqm->queue_count--;
+		dqm->active_queue_count--;
 
 	return retval;
 }
@@ -563,13 +563,13 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 	/*
 	 * check active state vs. the previous state and modify
 	 * counter accordingly. map_queues_cpsch uses the
-	 * dqm->queue_count to determine whether a new runlist must be
+	 * dqm->active_queue_count to determine whether a new runlist must be
 	 * uploaded.
 	 */
 	if (q->properties.is_active && !prev_active)
-		dqm->queue_count++;
+		dqm->active_queue_count++;
 	else if (!q->properties.is_active && prev_active)
-		dqm->queue_count--;
+		dqm->active_queue_count--;
 
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS)
 		retval = map_queues_cpsch(dqm);
@@ -618,7 +618,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = false;
-		dqm->queue_count--;
+		dqm->active_queue_count--;
 
 		if (WARN_ONCE(!dqm->sched_running, "Evict when stopped\n"))
 			continue;
@@ -662,7 +662,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = false;
-		dqm->queue_count--;
+		dqm->active_queue_count--;
 	}
 	retval = execute_queues_cpsch(dqm,
 				qpd->is_debug ?
@@ -731,7 +731,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = true;
-		dqm->queue_count++;
+		dqm->active_queue_count++;
 
 		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
 			continue;
@@ -786,7 +786,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = true;
-		dqm->queue_count++;
+		dqm->active_queue_count++;
 	}
 	retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
@@ -899,7 +899,7 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
-	dqm->queue_count = dqm->next_pipe_to_allocate = 0;
+	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
 	dqm->sdma_queue_count = 0;
 	dqm->xgmi_sdma_queue_count = 0;
 
@@ -924,7 +924,7 @@ static void uninitialize(struct device_queue_manager *dqm)
 {
 	int i;
 
-	WARN_ON(dqm->queue_count > 0 || dqm->processes_count > 0);
+	WARN_ON(dqm->active_queue_count > 0 || dqm->processes_count > 0);
 
 	kfree(dqm->allocated_queues);
 	for (i = 0 ; i < KFD_MQD_TYPE_MAX ; i++)
@@ -1064,7 +1064,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
-	dqm->queue_count = dqm->processes_count = 0;
+	dqm->active_queue_count = dqm->processes_count = 0;
 	dqm->sdma_queue_count = 0;
 	dqm->xgmi_sdma_queue_count = 0;
 	dqm->active_runlist = false;
@@ -1158,7 +1158,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 			dqm->total_queue_count);
 
 	list_add(&kq->list, &qpd->priv_queue_list);
-	dqm->queue_count++;
+	dqm->active_queue_count++;
 	qpd->is_debug = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1172,7 +1172,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 {
 	dqm_lock(dqm);
 	list_del(&kq->list);
-	dqm->queue_count--;
+	dqm->active_queue_count--;
 	qpd->is_debug = false;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	/*
@@ -1244,7 +1244,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		dqm->xgmi_sdma_queue_count++;
 
 	if (q->properties.is_active) {
-		dqm->queue_count++;
+		dqm->active_queue_count++;
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	}
@@ -1319,7 +1319,7 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 
 	if (!dqm->sched_running)
 		return 0;
-	if (dqm->queue_count <= 0 || dqm->processes_count <= 0)
+	if (dqm->active_queue_count <= 0 || dqm->processes_count <= 0)
 		return 0;
 	if (dqm->active_runlist)
 		return 0;
@@ -1438,7 +1438,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	list_del(&q->list);
 	qpd->queue_count--;
 	if (q->properties.is_active) {
-		dqm->queue_count--;
+		dqm->active_queue_count--;
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
@@ -1648,7 +1648,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Clean all kernel queues */
 	list_for_each_entry_safe(kq, kq_next, &qpd->priv_queue_list, list) {
 		list_del(&kq->list);
-		dqm->queue_count--;
+		dqm->active_queue_count--;
 		qpd->is_debug = false;
 		dqm->total_queue_count--;
 		filter = KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES;
@@ -1665,7 +1665,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		}
 
 		if (q->properties.is_active)
-			dqm->queue_count--;
+			dqm->active_queue_count--;
 
 		dqm->total_queue_count--;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 871d3b628d2d..ee3400e92c30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -180,7 +180,7 @@ struct device_queue_manager {
 	struct list_head	queues;
 	unsigned int		saved_flags;
 	unsigned int		processes_count;
-	unsigned int		queue_count;
+	unsigned int		active_queue_count;
 	unsigned int		sdma_queue_count;
 	unsigned int		xgmi_sdma_queue_count;
 	unsigned int		total_queue_count;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index dc406e6dee23..393c218734fd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -47,7 +47,7 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	struct kfd_dev *dev = pm->dqm->dev;
 
 	process_count = pm->dqm->processes_count;
-	queue_count = pm->dqm->queue_count;
+	queue_count = pm->dqm->active_queue_count;
 	compute_queue_count = queue_count - pm->dqm->sdma_queue_count -
 				pm->dqm->xgmi_sdma_queue_count;
 
@@ -141,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	pm->ib_size_bytes = alloc_size_bytes;
 
 	pr_debug("Building runlist ib process count: %d queues count %d\n",
-		pm->dqm->processes_count, pm->dqm->queue_count);
+		pm->dqm->processes_count, pm->dqm->active_queue_count);
 
 	/* build the run list ib packet */
 	list_for_each_entry(cur, queues, list) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index cb1ca11b99c3..606b1a8aacad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -266,7 +266,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		if ((dev->dqm->sched_policy ==
 		     KFD_SCHED_POLICY_HWS_NO_OVERSUBSCRIPTION) &&
 		((dev->dqm->processes_count >= dev->vm_info.vmid_num_kfd) ||
-		(dev->dqm->queue_count >= get_queues_num(dev->dqm)))) {
+		(dev->dqm->active_queue_count >= get_queues_num(dev->dqm)))) {
 			pr_debug("Over-subscription is not allowed when amdkfd.sched_policy == 1\n");
 			retval = -EPERM;
 			goto err_create_queue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

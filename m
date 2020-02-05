Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B50C352A2
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E822082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uuY0cTHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E822082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A0C6F97C;
	Wed,  5 Feb 2020 23:29:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952CF6F97C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCk5H8051EE1aKWCIR55XHEDcIeH/M5FtquCP7+MdMo1zZVm/34wYXMt9cZctxINHLpGEjOadz51XEGVHuu9+QKktp8wRy/6Y8NIvVjgR3sctd+S0BIORjXV8haWW7B6ejM0U3NXaQpk8u7PBC4N2Cs38pQAQvCmiX9bf5WKeDFWhJs5YBnm+M/9/N1ZZBuFcAGn0u9sCfYadwrj6T2aWhFE2irc3+HIhxKbBSQPrfgJoSQcAyfFkyyYvQAiRWld0ThMEKFVPNUYB1+wbFzkG9Z0Wf7LoUwoH/dz4dp7inXT6ppNTVoOzzZIhL0F85HprqVuXry+HWKE3eafo2jgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq5VQf+Bo9Lzqda/6aVkoYgv5AY8MFCocVyurqpchOw=;
 b=ez7UMieF5dv3vSjEIRGpAoglblNBGV5uGK+8VxOUo09xgYqU0Rd4PMUocdrHsi5G2XkQu11Pyl3eYMSGOSlHVeNWObvkB+7C41fRUqt0VyCGbIJJd/jcVVKROTUeaqXY55TR+2pTbqrOJf7thiDx1t8SAOw9ILJe1fR2KvwTpz8Oyi3RaEEXmLUvP8qQnA6xP8oEy4j7F9oT2O+jgKu6187QuoJXB/Xg0Vb9Jhx/h/t8dvYsq9/uPMWYKcmB2O+fLIawJgjNJU9WfQuyFYCZUQu/ljqUnR5ogfOmU+wI+fhHf2Ejn/DH6gwUAgwlo0JjxX3KpbLImSlVjaDxH6CMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq5VQf+Bo9Lzqda/6aVkoYgv5AY8MFCocVyurqpchOw=;
 b=uuY0cTHBs8fIQiCWumhMq+vFd7uUPiPuE0lIQ8S+8Mm+esQef/N+kzxWbKRvdgdS1Q2ulSl92sISGbXY8ECh5HDKFcGDgScyBHihJgBHxIU+hVKlVQQ/yxXwQRYECFbJmyTgE1ORFH1c5luadxTqaRc3X4pqCDgw4w4X8WdEk4M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4072.namprd12.prod.outlook.com (10.141.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 23:29:34 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:29:34 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdkfd: Count active CP queues directly
Date: Wed,  5 Feb 2020 18:28:29 -0500
Message-Id: <20200205232832.26226-3-Yong.Zhao@amd.com>
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
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 23:29:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7118d841-ede6-4cbc-ae20-08d7aa934214
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:|CH2PR12MB4072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072F168F4CEE95B9D30EE13F0020@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:211;
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
X-Microsoft-Antispam-Message-Info: stMEu5mbnVjxxu4/USbs1qTpQl5W+n1kXV3Bj1jysbcrWI6aQ+m2RVRKE64yQHsUvPUPbXzleB0eIQTo31Ah0MrBkUeafSqIZslbQ6Qg6wgbH1e4GY+7jNi5/b+NbOwmk00iea3yS82S33giyCxOGHAtsc43tELwym63ilgrjnT6bfWgTtk532G+sImWCjBuTL1RZTNhCxE7Ev8mKrOsca1angep7hfL0hCaW1hTRZDniVJCMMQCHB5qKf8479ZVld9Yp1/JMuMx9yuWxmUe1sX6DLTJZ9acVe0jwp48AHQGviZ5z7Y3kpVq4GUlXIQxJoaAnlWygkbIdDjxWRaDLTEjYBb9TZsScA4GpNEnh1h03MnaN8a4CmYIjoBFWRc8LU9qBYa6Np34pqGPRe+ZPjQDEbACEooZLxLhLa7HsxThoK6UtjRvT7x/Fsku/qWt
X-MS-Exchange-AntiSpam-MessageData: CzKAlMy6xOV/Xn9rpLRT+ZW4ERJGrJ1BJUO10m4K6WIU4GAL3IwCZnEMRImyNUUW9Qt2YcHx4LYXx0HGPH6f7XDJ4SDODLN9w915ns+CSPuqLT+b4jSwxRZBGo9UgYsppZtnsBcYApzGWP6eVX0bZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7118d841-ede6-4cbc-ae20-08d7aa934214
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:29:34.3249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3jUPViHFzonpcDF2ZVKk+f2tG2zgo/A9Ip/6H+0k2jXZnxdBIkU/9wGPQd3DKzp
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

The previous code of calculating active CP queues is problematic if
some SDMA queues are inactive. Fix that by counting CP queues directly.

Change-Id: I5ffaa75a95cbebc984558199ba2f3db6909c52a9
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 45 +++++++++++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +-
 3 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 973581c2b401..064108cf493b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -132,6 +132,22 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
 						qpd->sh_mem_bases);
 }
 
+void increment_queue_count(struct device_queue_manager *dqm,
+			enum kfd_queue_type type)
+{
+	dqm->active_queue_count++;
+	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
+		dqm->active_cp_queue_count++;
+}
+
+void decrement_queue_count(struct device_queue_manager *dqm,
+			enum kfd_queue_type type)
+{
+	dqm->active_queue_count--;
+	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
+		dqm->active_cp_queue_count--;
+}
+
 static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
@@ -359,7 +375,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 	if (q->properties.is_active)
-		dqm->active_queue_count++;
+		increment_queue_count(dqm, q->properties.type);
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 		dqm->sdma_queue_count++;
@@ -494,7 +510,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	}
 	qpd->queue_count--;
 	if (q->properties.is_active)
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, q->properties.type);
 
 	return retval;
 }
@@ -567,9 +583,9 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 	 * uploaded.
 	 */
 	if (q->properties.is_active && !prev_active)
-		dqm->active_queue_count++;
+		increment_queue_count(dqm, q->properties.type);
 	else if (!q->properties.is_active && prev_active)
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, q->properties.type);
 
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS)
 		retval = map_queues_cpsch(dqm);
@@ -618,7 +634,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = false;
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, q->properties.type);
 
 		if (WARN_ONCE(!dqm->sched_running, "Evict when stopped\n"))
 			continue;
@@ -662,7 +678,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = false;
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, q->properties.type);
 	}
 	retval = execute_queues_cpsch(dqm,
 				qpd->is_debug ?
@@ -731,7 +747,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = true;
-		dqm->active_queue_count++;
+		increment_queue_count(dqm, q->properties.type);
 
 		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
 			continue;
@@ -786,7 +802,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = true;
-		dqm->active_queue_count++;
+		increment_queue_count(dqm, q->properties.type);
 	}
 	retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
@@ -1158,7 +1174,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 			dqm->total_queue_count);
 
 	list_add(&kq->list, &qpd->priv_queue_list);
-	dqm->active_queue_count++;
+	increment_queue_count(dqm, kq->queue->properties.type);
 	qpd->is_debug = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1172,7 +1188,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 {
 	dqm_lock(dqm);
 	list_del(&kq->list);
-	dqm->active_queue_count--;
+	decrement_queue_count(dqm, kq->queue->properties.type);
 	qpd->is_debug = false;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	/*
@@ -1244,7 +1260,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		dqm->xgmi_sdma_queue_count++;
 
 	if (q->properties.is_active) {
-		dqm->active_queue_count++;
+		increment_queue_count(dqm, q->properties.type);
+
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	}
@@ -1438,7 +1455,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	list_del(&q->list);
 	qpd->queue_count--;
 	if (q->properties.is_active) {
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, q->properties.type);
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
@@ -1648,7 +1665,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Clean all kernel queues */
 	list_for_each_entry_safe(kq, kq_next, &qpd->priv_queue_list, list) {
 		list_del(&kq->list);
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, kq->queue->properties.type);
 		qpd->is_debug = false;
 		dqm->total_queue_count--;
 		filter = KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES;
@@ -1665,7 +1682,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		}
 
 		if (q->properties.is_active)
-			dqm->active_queue_count--;
+			decrement_queue_count(dqm, q->properties.type);
 
 		dqm->total_queue_count--;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 3f0fb0d28c01..05e0afc04cd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -181,6 +181,7 @@ struct device_queue_manager {
 	unsigned int		saved_flags;
 	unsigned int		processes_count;
 	unsigned int		active_queue_count;
+	unsigned int		active_cp_queue_count;
 	unsigned int		sdma_queue_count;
 	unsigned int		xgmi_sdma_queue_count;
 	unsigned int		total_queue_count;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 377bde0e781c..efdb75e7677b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -48,8 +48,7 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 
 	process_count = pm->dqm->processes_count;
 	queue_count = pm->dqm->active_queue_count;
-	compute_queue_count = queue_count - pm->dqm->sdma_queue_count -
-				pm->dqm->xgmi_sdma_queue_count;
+	compute_queue_count = pm->dqm->active_cp_queue_count;
 
 	/* check if there is over subscription
 	 * Note: the arbitration between the number of VMIDs and
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

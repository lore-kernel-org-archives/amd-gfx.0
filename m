Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83838C35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592A220674
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nPa4zU7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592A220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC6E6F9A7;
	Thu,  6 Feb 2020 02:35:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECE16F9A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 02:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXo8b8QriLKwxh64hctQjM71n7BmZXSAFpBPd8Z0lUVlhwHmQAgoez1zfmk15xetvUM2ICMPWAmB/J5QaJfo+qDDPVxpnQWQTwwurCfVAepVGHSF8Ys42mrt1Ip4eJTwKLGLSRt2YjfjNddk7kSqBVkje+vGSEFb/RV4XfbI75Eb7no24eSHJtbk6x905XoYuNv2dp/8vmVCkTgAtJ5na48ZmckjVinJGs7N31pDEB/idGaPxa1yMhSeZopxRhVzIA4ImRYLcsdZTPuVuO8aitIyeE/OROS8JA9I5QDKBx2r1ERht6PP2qiCUoMtBLD05JaQXB/3oQDIo+WeIDOBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWFUJbVDDNbqAqYF5xMyvXdVbnGjPXPMePP6qHe8YMA=;
 b=U/cqXP+8Sh7T6BffKkLC0E52kV1Gt+uwMyyTfZNunuiokRdedZkz0IWu+Agt91n4V3vldqHVeUcODNxqO5yZq1mFEG08Gu63t4rlqpHZ3o3B1SZi57n0wjws5BmzWdIhFFRUwk0EEoDw9Utkemp55rLGmQ31n3MBRXSw9yMKQVzEu/RgmrecF4E1yH+jHySgRDfePZJeTUkPlZzjeK6FZG11s9Z/rtLM6SpAZVhX2v+MCtCfH1M8Kon38PFF1lxkRXp8yk9Rk25tq1P85cLYDtsI+4uBYPeRZtUsjyhLgfMbLKni/nBbftGqe+0bTexjdRIAmKAUv/LeZvjIPcUffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWFUJbVDDNbqAqYF5xMyvXdVbnGjPXPMePP6qHe8YMA=;
 b=nPa4zU7EYX+2B/iDf+ajM+fBG5pvthpXoFUWadvBKDIU0yC7McUxoQMssEiRdP0hTSNKmaPnxl4ETtRQelsXqpw6CrmspkzGNJKMw0z5Npacw1+ft8hzvxCKSaK6Ri/hB1oTyiUUeV9o88GbTZx3t+TUTUnT+moDtudWgHbealk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4246.namprd12.prod.outlook.com (20.180.6.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 02:35:51 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 02:35:50 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdkfd: Fix bugs in SDMA queues mapping in HWS mode
Date: Wed,  5 Feb 2020 21:35:36 -0500
Message-Id: <20200206023536.4417-3-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206023536.4417-1-Yong.Zhao@amd.com>
References: <20200206023536.4417-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 02:35:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ad613f7-b2d0-4510-d57e-08d7aaad46fa
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:|CH2PR12MB4246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4246FD6EFAEF919B34775AE3F01D0@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(4326008)(6486002)(1076003)(66946007)(6666004)(81166006)(81156014)(8676002)(8936002)(86362001)(36756003)(186003)(16526019)(478600001)(956004)(2616005)(26005)(316002)(30864003)(5660300002)(66556008)(66476007)(2906002)(52116002)(7696005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4246;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u93hHY9pN9PWSoa6MQYePa/j8XeBynbZOyLCSVjmb4eSe4AzPDstEYUZ6imTQnEIebnP2hrYjGfonS4ooOWu9PdfEaPrpncytEMMu+uN29sJdl+3BzV2kulEqZ5ASwsVXyPCbvaKRRQLtqJnUjdvJNmPMRB1uJZjkXn+AVywcLPi2BPDZulINWb1vw4Y3mhGFqMhl/pIvVW04rPrt8TYYS1wjD8meuBlU4lv2Z50/l3p1hnjprkocjimwMIkUDBt/BzmKfHa5MEP4F8FfyoGNN3CQqwPjDiq7lag3EZ9aitH4aqyt1o9wVLkZK5ujxTe2EuPgXxnnpmwY7pwXIrDXb7b1eXly7X/U9SlzNjXgbSoT291abmYfq0w7M7ear8qHHIEBBPBBf7xuWWoOCWtQYcqrlQD0Qm3tuZQ/FWMgAsA8NCQ21KrN+jGAQ/Qf2dZ
X-MS-Exchange-AntiSpam-MessageData: 3S6M4lT3nls63eUQ201kEV2EaC8iB6crgNkzoKuDuvP0Tup++a0l6TB4vXvwVQh5BUKn/sidayS308bWqHMEROj6uaRz5hrq5j0+QbfKfnyiUfSX2c5cbvbMN/tRuLB+h6XkktyNGs3yzhLIBcJ8Rw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad613f7-b2d0-4510-d57e-08d7aaad46fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 02:35:49.5081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zde65tZbCEFDlZ2EodXNQPbMXYMxWyd2Dih5t/I1Mu+1vPz8Oj4Nq06V/38tdKAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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
unmap SDMA queues under HWS mode. In contrast, We only mapped active
queues rather than all in map_queues_cpsch(). In order to match the
map and unmap for SDMA queues, we should just count active SDMA
queues.

Moreover, previously in execute_queues_cpsch(), we determined whether
to unmap SDMA queues based on active_sdma_queue_count. However, its
value only reflectd the "to be mapped" SDMA queue count, rather than
the "mapped" count, which actually should be used. For example, if
there is a SDMA queue mapped and the application is destroying it,
when the driver reaches unmap_queues_cpsch(), active_sdma_queue_count
is already 0, so unmap_sdma_queues() won't be triggered, which is a bug.
Fix the issue by recording whether we should call unmap_sdma_queues()
in next execute_queues_cpsch() before mapping all queues.

An optimization is also made. Previously whenever unmapping SDMA queues,
the code would send one unmapping packet for each SDMA engine to CP
firmware regardless whether there are SDMA queues mapped on that engine.
By introducing used_sdma_engines_bitmap, which is calculated during
mapping, we can just send only necessary engines during unmapping.

Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 131 +++++++++---------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   4 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  16 +--
 3 files changed, 71 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 958275db3f55..3ca660acaa1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -109,6 +109,11 @@ static unsigned int get_num_xgmi_sdma_engines(struct device_queue_manager *dqm)
 	return dqm->dev->device_info->num_xgmi_sdma_engines;
 }
 
+static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
+{
+	return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
+}
+
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
 {
 	return dqm->dev->device_info->num_sdma_engines
@@ -133,19 +138,27 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
 }
 
 void increment_queue_count(struct device_queue_manager *dqm,
-			enum kfd_queue_type type)
+				struct queue *q)
 {
+	enum kfd_queue_type type = q->properties.type;
+
 	dqm->active_queue_count++;
 	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
 		dqm->active_cp_queue_count++;
+	else
+		dqm->used_queues_on_sdma[q->properties.sdma_engine_id]++;
 }
 
 void decrement_queue_count(struct device_queue_manager *dqm,
-			enum kfd_queue_type type)
+				struct queue *q)
 {
+	enum kfd_queue_type type = q->properties.type;
+
 	dqm->active_queue_count--;
 	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
 		dqm->active_cp_queue_count--;
+	else
+		dqm->used_queues_on_sdma[q->properties.sdma_engine_id]--;
 }
 
 static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
@@ -373,12 +386,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 	if (q->properties.is_active)
-		increment_queue_count(dqm, q->properties.type);
-
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
+		increment_queue_count(dqm, q);
 
 	/*
 	 * Unconditionally increment this counter, regardless of the queue's
@@ -460,15 +468,13 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
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
@@ -508,7 +514,7 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	}
 	qpd->queue_count--;
 	if (q->properties.is_active)
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, q);
 
 	return retval;
 }
@@ -581,9 +587,9 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q)
 	 * uploaded.
 	 */
 	if (q->properties.is_active && !prev_active)
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, q);
 	else if (!q->properties.is_active && prev_active)
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, q);
 
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS)
 		retval = map_queues_cpsch(dqm);
@@ -632,7 +638,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = false;
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, q);
 
 		if (WARN_ONCE(!dqm->sched_running, "Evict when stopped\n"))
 			continue;
@@ -676,7 +682,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = false;
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, q);
 	}
 	retval = execute_queues_cpsch(dqm,
 				qpd->is_debug ?
@@ -745,7 +751,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = true;
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, q);
 
 		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
 			continue;
@@ -800,7 +806,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = true;
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, q);
 	}
 	retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
@@ -915,8 +921,6 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
 	dqm->active_cp_queue_count = 0;
-	dqm->sdma_queue_count = 0;
-	dqm->xgmi_sdma_queue_count = 0;
 
 	for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
 		int pipe_offset = pipe * get_queues_per_pipe(dqm);
@@ -1075,14 +1079,18 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 
 static int initialize_cpsch(struct device_queue_manager *dqm)
 {
+	int i = 0;
+
 	pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
 
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->processes_count = 0;
 	dqm->active_cp_queue_count = 0;
-	dqm->sdma_queue_count = 0;
-	dqm->xgmi_sdma_queue_count = 0;
+	dqm->used_sdma_engines_bitmap = 0;
+	for (i = 0; i < get_num_all_sdma_engines(dqm); i++)
+		dqm->used_queues_on_sdma[i] = 0;
+
 	dqm->active_runlist = false;
 	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
 	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
@@ -1174,7 +1182,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 			dqm->total_queue_count);
 
 	list_add(&kq->list, &qpd->priv_queue_list);
-	increment_queue_count(dqm, kq->queue->properties.type);
+	increment_queue_count(dqm, kq->queue);
 	qpd->is_debug = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1188,7 +1196,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 {
 	dqm_lock(dqm);
 	list_del(&kq->list);
-	decrement_queue_count(dqm, kq->queue->properties.type);
+	decrement_queue_count(dqm, kq->queue);
 	qpd->is_debug = false;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	/*
@@ -1254,13 +1262,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
-
 	if (q->properties.is_active) {
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, q);
 
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
@@ -1315,24 +1318,11 @@ int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
 	return 0;
 }
 
-static int unmap_sdma_queues(struct device_queue_manager *dqm)
-{
-	int i, retval = 0;
-
-	for (i = 0; i < dqm->dev->device_info->num_sdma_engines +
-		dqm->dev->device_info->num_xgmi_sdma_engines; i++) {
-		retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_SDMA,
-			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i);
-		if (retval)
-			return retval;
-	}
-	return retval;
-}
-
 /* dqm->lock mutex has to be locked before calling this function */
 static int map_queues_cpsch(struct device_queue_manager *dqm)
 {
 	int retval;
+	int i = 0;
 
 	if (!dqm->sched_running)
 		return 0;
@@ -1341,6 +1331,14 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 	if (dqm->active_runlist)
 		return 0;
 
+	dqm->used_sdma_engines_bitmap = 0;
+	for (i = 0; i < get_num_all_sdma_engines(dqm); i++) {
+		if (!dqm->used_queues_on_sdma[i])
+			continue;
+
+		dqm->used_sdma_engines_bitmap |= 1 << i;
+	}
+
 	retval = pm_send_runlist(&dqm->packets, &dqm->queues);
 	pr_debug("%s sent runlist\n", __func__);
 	if (retval) {
@@ -1358,6 +1356,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				uint32_t filter_param)
 {
 	int retval = 0;
+	int i = 0;
 
 	if (!dqm->sched_running)
 		return 0;
@@ -1366,11 +1365,15 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (!dqm->active_runlist)
 		return retval;
 
-	pr_debug("Before destroying queues, sdma queue count is : %u, xgmi sdma queue count is : %u\n",
-		dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
+	for (i = 0; i < get_num_all_sdma_engines(dqm); i++) {
+		if (!(dqm->used_sdma_engines_bitmap & (1 << i)))
+			continue;
 
-	if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
-		unmap_sdma_queues(dqm);
+		retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_SDMA,
+			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i);
+		if (retval)
+			return retval;
+	}
 
 	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
 			filter, filter_param, false, 0);
@@ -1444,18 +1447,15 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
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
 	if (q->properties.is_active) {
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, q);
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
@@ -1665,7 +1665,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Clean all kernel queues */
 	list_for_each_entry_safe(kq, kq_next, &qpd->priv_queue_list, list) {
 		list_del(&kq->list);
-		decrement_queue_count(dqm, kq->queue->properties.type);
+		decrement_queue_count(dqm, kq->queue);
 		qpd->is_debug = false;
 		dqm->total_queue_count--;
 		filter = KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES;
@@ -1673,16 +1673,13 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 
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
-			decrement_queue_count(dqm, q->properties.type);
+			decrement_queue_count(dqm, q);
 
 		dqm->total_queue_count--;
 	}
@@ -1759,8 +1756,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	struct kfd_dev *dev = dqm->dev;
 	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
 	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
-		(dev->device_info->num_sdma_engines +
-		dev->device_info->num_xgmi_sdma_engines) *
+		get_num_all_sdma_engines(dqm) *
 		dev->device_info->num_sdma_queues_per_engine +
 		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
 
@@ -2012,8 +2008,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		}
 	}
 
-	for (pipe = 0; pipe < get_num_sdma_engines(dqm) +
-			get_num_xgmi_sdma_engines(dqm); pipe++) {
+	for (pipe = 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
 		for (queue = 0;
 		     queue < dqm->dev->device_info->num_sdma_queues_per_engine;
 		     queue++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 05e0afc04cd9..66b91880b918 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -182,8 +182,8 @@ struct device_queue_manager {
 	unsigned int		processes_count;
 	unsigned int		active_queue_count;
 	unsigned int		active_cp_queue_count;
-	unsigned int		sdma_queue_count;
-	unsigned int		xgmi_sdma_queue_count;
+	unsigned int		used_queues_on_sdma[MAX_SDMA_ENGINE_NUM];
+	unsigned int		used_sdma_engines_bitmap;
 	unsigned int		total_queue_count;
 	unsigned int		next_pipe_to_allocate;
 	unsigned int		*allocated_queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 3bfa5c8d9654..eb1635ac8988 100644
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
+		 * corresponding check logic.
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

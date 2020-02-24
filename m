Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9243C38C00
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B2F218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Wn68FUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B2F218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E886E99C;
	Mon, 24 Feb 2020 22:19:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17A16E994
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 22:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5FbeRRY/1g8DzMJ+BdegXAgK375ka/L1EMdz7rNpo+p9pY3OQkpOwTDmEv0W2e39Hbp4v/1pPvNad9qmqg0Qy+SssSdSy079wH458HeWIiKWW+wVKk9ApTBtGp/ZN/GMSu9+GhMfLeMJXZJuxW4nAIq2QM+BAUVRkJBtofj7Z5sMC7EAsiTDNvY6V6KjyPmSUZrIwcjnqyjc9d9HYMO0E8cGQTPm8XDhC2G795MhZ04ilCAjL5NlMDGBsisnl870fFfMnBsC2wjzO39MvGLKI0t/wL6qPCaiCzfNdG/UHc4ewBHTFDsSbKKJBHQ+bZ/DEj0vUMQyEh6XlIjmOstmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNd7s6nfho0as3ntuK3psHnmBGdQeTGqTFRb+mYFZ5c=;
 b=kjA5xd/CtLIvOFBpIR2NaPzhG64GP7YLXvONaIzhKPMHBRPWvA5skjR4MpEu0hi30uaChx023Y6chFDTu/2TXMW8o9xrcR7LW5HYRO80q6bvdSsEHx22YdGIp4fEK0TRwkLLbgRuk2mZgKXnf5hwzgPy51216dPs65XAs4ZLGHvX3B6Br5kSEs58ObjbaxCXWsH7JrNEZTwSnbuIzME2Rnxaj7Xboghi6iEe9Fxjspj9CXv3m4q1FGauCkXZzo+J26qkm/GsdushUmRYOMgCicCM1Jkl3GOCXVzcbaoXOABf0/8jWLH7LYfc1zFC5m2WUxbgBNBnwurxX23W90rO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNd7s6nfho0as3ntuK3psHnmBGdQeTGqTFRb+mYFZ5c=;
 b=4Wn68FUSL5KaUX00voz88ik6o26co8W7d4G1UIuUdpz/YBp8oUBuKkGNke9wP3PnKp0RSz614dYGrMy9fmnuTDNnnKRQZfyuEqH+5t26AzZmXAgf6BCjwpgtfrE1SNWO4T2fyX7EXBnpf2Q+gexPWzxANqA4zLysBoESs7XMaJk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3749.namprd12.prod.outlook.com (2603:10b6:610:2a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 22:18:57 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 22:18:57 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdkfd: Count active CP queues directly
Date: Mon, 24 Feb 2020 17:18:39 -0500
Message-Id: <20200224221842.14110-3-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224221842.14110-1-Yong.Zhao@amd.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 22:18:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d4c6902-d9b8-4e26-2f4e-08d7b9778a67
X-MS-TrafficTypeDiagnostic: CH2PR12MB3749:|CH2PR12MB3749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB374963C147BEF4EF78E87AE0F0EC0@CH2PR12MB3749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(36756003)(52116002)(2906002)(5660300002)(86362001)(7696005)(66556008)(66476007)(66946007)(4326008)(6666004)(478600001)(8676002)(81156014)(1076003)(81166006)(26005)(6486002)(316002)(8936002)(186003)(6916009)(16526019)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3749;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GcOydx9zH/FfPdMyJC3uEIngoHozHH7BCjGaXpCEARn/Rxjg9t2ZIACbg1lFPRl9Nlfgu7CI/qRMK+kCSgTkqkfvuTSPcELZM+X4FJn3CC7M3rrtuNVTpherE9gFmyz+WJbNpv4FG/ZERCemFk50iCJLf+IY2lHk3o4WpQ7hx1P+A8Y5IZ+hfg9a8VvujbW8jezOTkaNMU+NB9UBA1tEQ+U6DT4HMv0J/zCXphcNrXi6gXtOnjdtEp6TUthWAoh+ZMvjs77Im4WoXoa2LcAF2jPCNyWTYiKe1P7xd2zpNtQirSN5y27qKABITawWLCmMsKXVCtv7uXdWWceMkrbOcOV/wgrqKqMe7+NXDvfMf94PKLEBakdDHS/aAHxoLPW5jHBOVAHzResBLMetgcrwoWZiDp/8QMxd9a1slkdwbeCCfnoaEJljztkqPV8xV07
X-MS-Exchange-AntiSpam-MessageData: 5iljmVF7tZKzJs+RJIgpNQStkzsuGWECt141sPMeblor8DUgAbfx5DUM9fjAPo3inzRVY3l48WqO/lCY896jY/eM5h0dNnZDuz3Wr+YzOsGwCEl2Kgiyoof7DT7Krsx0yEYlQBEhF0kaVUqUJSa96w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4c6902-d9b8-4e26-2f4e-08d7b9778a67
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 22:18:57.2968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ3VBvSuqGgnb7TStnFH9iSa8poojaK6E85mgShwHdqqLKc1GOvzYGn64gd/Unv2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
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
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 47 +++++++++++++------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  3 +-
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 973581c2b401..a3c44d88314b 100644
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
@@ -900,6 +916,7 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
+	dqm->active_cp_queue_count = 0;
 	dqm->sdma_queue_count = 0;
 	dqm->xgmi_sdma_queue_count = 0;
 
@@ -1065,6 +1082,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	mutex_init(&dqm->lock_hidden);
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->processes_count = 0;
+	dqm->active_cp_queue_count = 0;
 	dqm->sdma_queue_count = 0;
 	dqm->xgmi_sdma_queue_count = 0;
 	dqm->active_runlist = false;
@@ -1158,7 +1176,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 			dqm->total_queue_count);
 
 	list_add(&kq->list, &qpd->priv_queue_list);
-	dqm->active_queue_count++;
+	increment_queue_count(dqm, kq->queue->properties.type);
 	qpd->is_debug = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1172,7 +1190,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 {
 	dqm_lock(dqm);
 	list_del(&kq->list);
-	dqm->active_queue_count--;
+	decrement_queue_count(dqm, kq->queue->properties.type);
 	qpd->is_debug = false;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	/*
@@ -1244,7 +1262,8 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 		dqm->xgmi_sdma_queue_count++;
 
 	if (q->properties.is_active) {
-		dqm->active_queue_count++;
+		increment_queue_count(dqm, q->properties.type);
+
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	}
@@ -1438,7 +1457,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	list_del(&q->list);
 	qpd->queue_count--;
 	if (q->properties.is_active) {
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, q->properties.type);
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
@@ -1648,7 +1667,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Clean all kernel queues */
 	list_for_each_entry_safe(kq, kq_next, &qpd->priv_queue_list, list) {
 		list_del(&kq->list);
-		dqm->active_queue_count--;
+		decrement_queue_count(dqm, kq->queue->properties.type);
 		qpd->is_debug = false;
 		dqm->total_queue_count--;
 		filter = KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES;
@@ -1665,7 +1684,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
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

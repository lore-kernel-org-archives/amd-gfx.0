Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E6FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 01:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5549B10E193;
	Tue, 19 Apr 2022 01:32:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57BE10E193
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 01:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFF9qTnlXnihWuYVLHwu0Yd3bf1oVUfd/Oby4wUDk/uHWkw8T3FMckUmVwcl397B9Ha8ReyxnBtB7KwS3FoIfI9VXYOoQlvtx6jhTLcLgBfjT8bWcjYYedGtRj90e8YAgvHAUWkIjcNdOyeQKBpuSabuXZbPuaniiE9FuZojceOQd5CPQ7sKZ4iRFaUiOj6s6tMmYa2CQSKQQn9jAlvwfaf8QQWSL7NPuwXahKsV2/wK0786TfhtzsbdiTmOpZBLdmqrvabnflY3Mp3+M2tTbutKn+X4BgbVoLBV8ntboQCpH0Op4Fvxw6fQr1fEBnLwJdLJVu3J/oBl285BRD6dkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlRTD2k8P2eyQ3+joa9DMPnWPaocHIIv2pYAhr4Pfzw=;
 b=mZ1L430mEfs9sc1Hp+i6r7+KeJ65j90Xj+wi7chidrWFGtLk9wlraQPVv0sFZUe2iObax2uTe8gJbUwODNlTohyPLIcXye5hKu9SobblOemZc1COBQ1juii3IY96LBNf/tstpyBe9/tv18LOt28Zam0p0DauNZc8pWQER4w/uy3Qotol9A8dbcHfRRehKrXQd2ffVKBJipNmmdRar3aoeS89at+iLOOgTD3E+kvw61PJqC1JMrs/6inlLfMWyIEjH6INTn8KZIJTeA5Mcjfejgv7ukS4JNEYzAWCUVqSCU1wOobB6QP/UTepnfUPddBXIOCSgJhZUk4+y2dafsMwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlRTD2k8P2eyQ3+joa9DMPnWPaocHIIv2pYAhr4Pfzw=;
 b=xQnnqqUs2u7toTcqN4ZOpPJ/6rcsr0Qg6DYHu/LLSvpYkw8SdWbnaOVDnDiCOlfxzCz1+1mp/e4/sZR8W6UqxZugGOwfGA+lG1iDv0Mqgs/qguD5fxfSkSoKwlLvwl3xC7U8gWJZzEYFryw0fUOZrHRCFkrpK1UocstyiNGnXqY=
Received: from DM6PR07CA0105.namprd07.prod.outlook.com (2603:10b6:5:330::8) by
 CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Tue, 19 Apr 2022 01:32:43 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::f5) by DM6PR07CA0105.outlook.office365.com
 (2603:10b6:5:330::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 19 Apr 2022 01:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 01:32:42 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 20:32:41 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/2] drm/amdkfd: Fix GWS queue count
Date: Mon, 18 Apr 2022 21:32:26 -0400
Message-ID: <20220419013227.2509204-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada85b1b-3f69-430b-e481-08da21a47fe2
X-MS-TrafficTypeDiagnostic: CO6PR12MB5491:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5491BE02DFCB457579C553CB95F29@CO6PR12MB5491.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1cVSLVXGFibRIpX00tq3HA9xAC3d6jQNCeoX9gsdprXpDlhFaQFxIpihLGVKFxYllbxrnipHMM1DibA3yCIFeFQ+LtuwZTLnY9nFj1Rh6vThofVFWFgPCvusfR6DStOKBUT55gcyDVewjHMv/W+1ysdfnlW3L8lNGXRQ7YDXOFlgsyfrSOu/FheP2RDjOEHOTBi0ct7NwfRjLZSPdY8Wy5eCjpBreLaeh5ZAV2HDOYy2GzIyf06zD+o+eSZ5d2ztl80nyg/WEsz9DSU1OQ+gGDfTt5gFfc9aLFSjnjKBWnMWk2lvUuIj1a5vMLQsbtHaU5t7+/PYLjib1/A6+1j8dnwxZEXLakCRtDbZEHWL1+hxf53ibkXs16Iw6m/z0zgihfFJGlMl8yussVGpNgrylI5kRA61UCr05Mdjncf5q8Z192SxmKE73HOhyqOrCOjbDp6mR8eRNARywAHa5jJa7gEB+gN3ZXnLgl8fI97MTnQaIwFpVWs7dCEGFGte0/8mhag4pGjek/vVAqd1eIQgeqBraTkIWOfAPX27eo5OxRBN1bETsi9sMBfAf3oaQ883YzIb1Mlc8/CXLr0ZahwarH3QyGEq3rscDT+e9ozQXhRHduQZ++s4HELzPOUNzHwgNh+qmhI5qTDD3waQfqt5nPj0zJBxxU/5w5XAKx7UHADdkY9R7c9Daa/NoayUbz0uRaY8bMJfvvUpFPcn34L3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(40460700003)(86362001)(2906002)(6666004)(36756003)(7696005)(26005)(5660300002)(356005)(8936002)(54906003)(6916009)(316002)(83380400001)(82310400005)(508600001)(4326008)(70206006)(70586007)(8676002)(1076003)(2616005)(426003)(336012)(186003)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 01:32:42.9025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada85b1b-3f69-430b-e481-08da21a47fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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
Cc: pmenzel@molgen.mpg.de, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dqm->gws_queue_count and pdd->qpd.mapped_gws_queue need to be updated
each time the queue gets evicted.

Fixes: b8020b0304c8 ("drm/amdkfd: Enable over-subscription with >1 GWS queue")

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 83 +++++++++----------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index acf4f7975850..198672264492 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -130,19 +130,33 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
 }
 
 static void increment_queue_count(struct device_queue_manager *dqm,
-			enum kfd_queue_type type)
+				  struct qcm_process_device *qpd,
+				  struct queue *q)
 {
 	dqm->active_queue_count++;
-	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
+	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
 		dqm->active_cp_queue_count++;
+
+	if (q->properties.is_gws) {
+		dqm->gws_queue_count++;
+		qpd->mapped_gws_queue = true;
+	}
 }
 
 static void decrement_queue_count(struct device_queue_manager *dqm,
-			enum kfd_queue_type type)
+				  struct qcm_process_device *qpd,
+				  struct queue *q)
 {
 	dqm->active_queue_count--;
-	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
+	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
 		dqm->active_cp_queue_count--;
+
+	if (q->properties.is_gws) {
+		dqm->gws_queue_count--;
+		qpd->mapped_gws_queue = false;
+	}
 }
 
 /*
@@ -412,7 +426,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 	if (q->properties.is_active)
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, qpd, q);
 
 	/*
 	 * Unconditionally increment this counter, regardless of the queue's
@@ -601,13 +615,8 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 		deallocate_vmid(dqm, qpd, q);
 	}
 	qpd->queue_count--;
-	if (q->properties.is_active) {
-		decrement_queue_count(dqm, q->properties.type);
-		if (q->properties.is_gws) {
-			dqm->gws_queue_count--;
-			qpd->mapped_gws_queue = false;
-		}
-	}
+	if (q->properties.is_active)
+		decrement_queue_count(dqm, qpd, q);
 
 	return retval;
 }
@@ -700,12 +709,11 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	 * dqm->active_queue_count to determine whether a new runlist must be
 	 * uploaded.
 	 */
-	if (q->properties.is_active && !prev_active)
-		increment_queue_count(dqm, q->properties.type);
-	else if (!q->properties.is_active && prev_active)
-		decrement_queue_count(dqm, q->properties.type);
-
-	if (q->gws && !q->properties.is_gws) {
+	if (q->properties.is_active && !prev_active) {
+		increment_queue_count(dqm, &pdd->qpd, q);
+	} else if (!q->properties.is_active && prev_active) {
+		decrement_queue_count(dqm, &pdd->qpd, q);
+	} else if (q->gws && !q->properties.is_gws) {
 		if (q->properties.is_active) {
 			dqm->gws_queue_count++;
 			pdd->qpd.mapped_gws_queue = true;
@@ -767,11 +775,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = false;
-		decrement_queue_count(dqm, q->properties.type);
-		if (q->properties.is_gws) {
-			dqm->gws_queue_count--;
-			qpd->mapped_gws_queue = false;
-		}
+		decrement_queue_count(dqm, qpd, q);
 
 		if (WARN_ONCE(!dqm->sched_running, "Evict when stopped\n"))
 			continue;
@@ -817,7 +821,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = false;
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, qpd, q);
 	}
 	pdd->last_evict_timestamp = get_jiffies_64();
 	retval = execute_queues_cpsch(dqm,
@@ -888,11 +892,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		q->properties.is_active = true;
-		increment_queue_count(dqm, q->properties.type);
-		if (q->properties.is_gws) {
-			dqm->gws_queue_count++;
-			qpd->mapped_gws_queue = true;
-		}
+		increment_queue_count(dqm, qpd, q);
 
 		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
 			continue;
@@ -950,7 +950,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 			continue;
 
 		q->properties.is_active = true;
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, &pdd->qpd, q);
 	}
 	retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
@@ -1378,7 +1378,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
 			dqm->total_queue_count);
 
 	list_add(&kq->list, &qpd->priv_queue_list);
-	increment_queue_count(dqm, kq->queue->properties.type);
+	increment_queue_count(dqm, qpd, kq->queue);
 	qpd->is_debug = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1392,7 +1392,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
 {
 	dqm_lock(dqm);
 	list_del(&kq->list);
-	decrement_queue_count(dqm, kq->queue->properties.type);
+	decrement_queue_count(dqm, qpd, kq->queue);
 	qpd->is_debug = false;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
 	/*
@@ -1467,7 +1467,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	qpd->queue_count++;
 
 	if (q->properties.is_active) {
-		increment_queue_count(dqm, q->properties.type);
+		increment_queue_count(dqm, qpd, q);
 
 		execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
@@ -1683,15 +1683,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	list_del(&q->list);
 	qpd->queue_count--;
 	if (q->properties.is_active) {
-		decrement_queue_count(dqm, q->properties.type);
+		decrement_queue_count(dqm, qpd, q);
 		retval = execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
 			qpd->reset_wavefronts = true;
-		if (q->properties.is_gws) {
-			dqm->gws_queue_count--;
-			qpd->mapped_gws_queue = false;
-		}
 	}
 
 	/*
@@ -1932,7 +1928,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Clean all kernel queues */
 	list_for_each_entry_safe(kq, kq_next, &qpd->priv_queue_list, list) {
 		list_del(&kq->list);
-		decrement_queue_count(dqm, kq->queue->properties.type);
+		decrement_queue_count(dqm, qpd, kq->queue);
 		qpd->is_debug = false;
 		dqm->total_queue_count--;
 		filter = KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES;
@@ -1945,13 +1941,8 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 			deallocate_sdma_queue(dqm, q);
 
-		if (q->properties.is_active) {
-			decrement_queue_count(dqm, q->properties.type);
-			if (q->properties.is_gws) {
-				dqm->gws_queue_count--;
-				qpd->mapped_gws_queue = false;
-			}
-		}
+		if (q->properties.is_active)
+			decrement_queue_count(dqm, qpd, q);
 
 		dqm->total_queue_count--;
 	}
-- 
2.30.2


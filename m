Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A6BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 16:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABA110E12E;
	Mon, 18 Apr 2022 16:44:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4413A10E12E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 16:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfyCtI1kf1K9H6DTX20lbnxJPQD1SU+yg5DENq/1BziD7vTnq3IWbP+6nP76bm0x6iNRiwVG37pA1jclXziG2vejSvMiNROqPB5tTyVnuE8OaO0IrEndye/LSSUqFbdeJ3Bq6sYVwlQ3Rvq+ilyGx213D7cI1/LiNidJ6hNN06OPFoeDQJ9gm/zPN5+0dyXlRaZh+LYF0JzbWtXFoG6xBoYCxp4r5LQu52EvA3rOBkE20hEVsp/ue056h7P7mQobMbotZ2T9mRAmUPi4ydF2DujfyzhwxdPef7M3+TC8It8uDiUdwqNUbnaqbbjky/3taJdnIVvAYFoBcAmQDRE/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csyxdOhBV47WRlOCW1WAn1/6YF/4OBZmqz2b7JsaunA=;
 b=LRlDowLB+9lnFW+0JW3yUqQ70QSSFc5fsxcKz0oweidIfM8xQQyBavJM1Sb4AZ0heZDCPZ/YZhpLAM0Mkks9Bqn1wbKco+fXQxTj+u/g27lXFYNjHRtEYMLKvPnKKX4IYV6+dB6vnWpaeF/SUZUqlrrDKz5prV2/YmpYIAQs8ZztOPbYDZtkzMsgDaob5S0VbGFtc64zoV9Y2mRfgpIglKfmWuhYgFppmN4fY9a3CNL7/b28cUxiDjKGq5Bu0dEST/uUFuPWnF3aErnhqhKVRTNdX955h+T0RRqe3El4VOgB150a2TiDltegxWyiFQ4I26hXMb0GThUunQPGmrirxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csyxdOhBV47WRlOCW1WAn1/6YF/4OBZmqz2b7JsaunA=;
 b=rVWNM1P3ftFa5OyrDlCvCnTqgH9PyWtaIYTg70aYs55L66OYXKy5fdiDdS1SkI+BkjQt/yOBWKTuGjg382Nq4epsXFREL8purbEVX4aMwrL/X1VFPhfJRcJX0UBSookqWROXnv/R0667uuXptw0rk8sqG3kWme9w1BSSuvwfljU=
Received: from BN9PR03CA0989.namprd03.prod.outlook.com (2603:10b6:408:109::34)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 16:44:49 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::a8) by BN9PR03CA0989.outlook.office365.com
 (2603:10b6:408:109::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Mon, 18 Apr 2022 16:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 16:44:49 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 11:44:48 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amdkfd: Fix GWS queue count
Date: Mon, 18 Apr 2022 12:44:36 -0400
Message-ID: <20220418164437.1875319-1-david.yatsin@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82a92c5-8206-4612-48b7-08da215ac0f8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4062:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4062E50FEB1B22AA60B50B4495F39@MN2PR12MB4062.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLCXISM3aZbojWhhw63dkusiWpOt3lM7tjH2WgHNpEpV2467fsuhILtOiVrnLcSXyRQE+Z1vTCtdbV9hGbys+FTMKTcs2/Jk6zIS3GRfzvONLO7R5LaFt8jueAXXx/qo1Ia4MgK2NnN2fJx06GNG73uKtcCJy4KdcEs+ZYJX9BsEkLjI/ABKKsB0LUv8lnY84Nr0s+OjtR6tqQvLsIvGBQyr+TIvONyFlsiyGrm970r30P8S4l7EEOiGh7Ik7aU6Nr/3YzerXTwR1k+8m8xoWqy6fycq2KlLiXNnO9OSm/lpin2c0Ch0WVQde9BQVg4WsV/TRIZSSKb5p4X/b2w8DV/pi0NgdIWa8GjAUzh0Dnxn5kWEQZayVlRqW0cV4y2iRMMMRZ8cq3SnWRmlyDv9QdT961DF3upvkkCT6Btffd+uuEDNLmcVggEs6Scs7KtbA00442OUO3k6y4I6tCNErh8TtDM9sS/llQK8j4StDsldwxOGEzzY590f07P9dw8Tl0hpJnQDLZOwb4VX0n1aHBAYZOLTPWm7y6pPr1ZNUU8U9V1oS5lMPPAM71A8j0JbZ137qtzryT0OjacEqNSnMRQ0Em/5WEj2L3Ic7hdnD9yF3hQQxvtbWmj+TM+YO9FPp7EFFx5byJnvHBdPcBiuaOxFwFZXPPQER9pzTC//pMfpyVnJYAjk+p6JpDudrvn4NzjJ1NDO9rxG1Ppo1PQfMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(2906002)(26005)(8936002)(36860700001)(6916009)(4326008)(316002)(82310400005)(47076005)(6666004)(426003)(336012)(508600001)(40460700003)(86362001)(70206006)(186003)(356005)(16526019)(8676002)(83380400001)(36756003)(5660300002)(2616005)(1076003)(7696005)(81166007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 16:44:49.3991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82a92c5-8206-4612-48b7-08da215ac0f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dqm->gws_queue_count and pdd->qpd.mapped_gws_queue needs to be updated
each time the queue gets evicted.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
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


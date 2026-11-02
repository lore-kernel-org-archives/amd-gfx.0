Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9B606A327
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gIJNJb4r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BEA010E54A;
	Mon,  2 Nov 2026 07:44:42 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C361910E557
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 07:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/yrxVoNIDCBWfMpaqer9hRpyeOqt1O7r19xpKUTWOgEb22Llc+p6ZRsna9oNyyeHo3FSGeXGh12yETBa8vXDrOTj6J9BB3sSoWzlo/4BKKfOaJVe3MtPebyAk7k3TvVS0t03MkQZV4qnmCT4Kc0mQeKuMe9RXuySbWcZJXqjOungOjsX68spgwd2V1kGhfu5bHU2VKW/3F1hm7ObKX18qUTVWyf/z3xVnJnlJfSlE/NR6doDNOVwkjQr9/kzhIi4ortEFyExqEIGY91Cm62WV36WNP1S/fHzuws4UsMztNdInMTFVw8BX7I0Yu2ctQ/LG4tHqlUt1YkrrDiAxeIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsYr3dQyX5rcrvb0mKKy9qN67vfmyn5Y4K8ZOjiiqLY=;
 b=wM5AqZjdNC/kJxhNjR7BsOR4vN6oeh+52IChLIk8Y9cJkNBdSy6EFIWTLubom/DPQfASJkG6HcPckq7aDr8f1XQBwE8L7JoYFCK8FrSBWR9fBxq42GKlnK/DnZFJZfwD7eJ+tSwtNEbIbmsxEjSTogGUyH80OPXpZAp/XUhqhgfqTeNtlvfVJGpqMNQzN735ZC33fRPqWIVQuj1akM/oKGeoKHekp5+8lXX9XuyE+vG4b2rLHuPylgh2RT130lByAs2GOzbRRZAplUMmFaUG8OZb9FX6IXBAe1103kLW0CUiN8oVDCCfIwJAQQdxPT+zMEHWMjBscPbO1vp3L5A/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsYr3dQyX5rcrvb0mKKy9qN67vfmyn5Y4K8ZOjiiqLY=;
 b=gIJNJb4rB7z2azc3NnhGAWxWVHnmEO9kNhFWJ51mAUltOC/0+1I5khOcPFm0nOJwl6Pfm9LSLcl1tpfPbBjJGCqAfe9RjWDfPkNI5RvXI3bp83RDkzc2R9dWLgGF0r9hhvNMyQbhfuitDWrPgT/JJpPCR9sNeOBIojlGm3VDVrk=
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:44:32 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::4b) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 07:44:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Mon, 2 Nov 2026 07:44:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 2 Nov 2026 01:44:29 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Yifan1.Zhang@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH] drm/amdkfd: preempt the HWS runlist once in set_perfcount
Date: Mon, 2 Nov 2026 15:44:18 +0800
Message-ID: <20261102074418.2259176-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: bb813f2b-f904-4860-4251-08df38b521d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: BaAmj06pstPGUwqawcmWsCkah4FKwWc9C6FCNfUTIrkbU3KIvRzYMbTIKTfknKDvxJqZZ5/mIjtyeD/fAi9aX0xhu7n4hDLibjVeKzwUicvE8LARTYWsEfobb030cVgGJ1NS7TxaY721OnH6A9GRVFbchpLXz0poVg1/zwCVBq7T0iYYAvEmkBYR5svGUQFgg1cbYaqDBA+Xj4ZNyJam0cAGkr9ViJi/Q8bP5n3TtBjAE6ZW7lKI6LAiItcdbtuMWuerk1MQIaVqpxupkppzmCSjUAlORQnxI16Ok26pAO40pDTJk7OoeV2qpR/+iPbhqKu/Y/S4X8hUb/19+YueO+kxkt7tqgOJ26bntA5M1nb5/0/JS/hxbVk46O7tdTD15ERJVbyX3dbb4nIZWGspmpWrjIzmB4QLWtzPfpDXWNjZ01RktqE97UOCIUuAB5fJUV85Cit7sa9YrYHLDM4yeMbAKQgRsR3JpYJ8N+g1JJz+rgRqGjTbNAsPAK3c05sPebPtcnURHRWVLAemWrzgXdHrp/EI70Oq7xLKnw8cELVYiqxdNn9LwOz5wYM6Jqj43lbUSRX4ysJa0zzvy/t+Imrprofw2Dxra6z/D//sZW9LepIOYE+gE8V4om9PttPTQpZp5afeihayrjzGkoGk234d/QK4ZCffCOaVK5Pjy7vDcC4PKTMoU3grqCaDip78Zi9RYgYMB4AO2ri4BG+NyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: on8BgUOGvYQtWrA2fK4w+cWF2Bqo+hnQ14qvH3SbTFOIA6LBvF1qSLE1EU06Y9AAEe7rjkLJ8nMrdGC+XzLgKws6LkbPlc03o2ALFbjatjJhjHAl2kokTPIU2gmvKS4xaeTHhpCmuWVekzrhxDUb91V1p1t3QVZYBYOIJTvpWxENy48++eju9123KN5Gs6qtB8ugf9IqXkC25InZ6W9gEtyJsu+95P9BKZuF2zOxOvBZxiD+CV2SL4+zCUOHJgaLQu66VyXClwMRMgGQVZWReTwdjDMQOmLubdkQGDJp5JkhLzA4/xCdMSrazDIoH3Z6HQXa15ynWGHJy7gTy2oag8LGcem3aWIHXJs5natZUqutIIf4Pb41TVUFs34kS5vuvWaQyiMHKWS3v1kYGcZSsIpr/1O/UDQ3vrVAsHXbNbqjKdae5H0WjwmCNKjcadba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:44:31.7457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb813f2b-f904-4860-4251-08df38b521d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the non-MES HWS path, set_perfcount() calls update_queue_locked() for
every user queue. Each call unmaps and remaps all dynamic queues, so a
single perfcount toggle preempts the runlist once per user queue. This
adds repeated stalls to compute workloads during profiling setup and
teardown.

Unmap the runlist once, update the compute MQDs, and map it once. Share
the MQD update and activity/GWS accounting logic with update_queue_locked()
to preserve queue counts. The MQD callback recomputes is_active, and a
concurrent UPDATE_QUEUE caller can change queue properties before taking
the DQM lock, so perfcount updates must still account for activity changes.

Skip processes marked with has_reset_queue after preemption, preserving
the existing update_queue_locked() guard. Remap after the batch even if
the last process was skipped. Keep the per-queue update path for MES and
non-HWS scheduling.

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 85 +++++++++++++------
 1 file changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f4fb99b599da..c9a303f536c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1093,6 +1093,41 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
+/* Caller must hold the DQM lock and ensure the queue is unmapped. */
+static void update_queue_mqd(struct device_queue_manager *dqm, struct queue *q,
+			     struct qcm_process_device *qpd,
+			     struct mqd_update_info *minfo)
+{
+	struct mqd_manager *mqd_mgr =
+		dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
+	bool prev_active = q->properties.is_active;
+
+	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
+
+	/*
+	 * Queue properties can change before the updater takes the DQM lock,
+	 * so even a perfcount update can change queue activity. Keep the
+	 * counters used to build the runlist in sync with the updated state.
+	 */
+	if (q->properties.is_active && !prev_active) {
+		increment_queue_count(dqm, qpd, q);
+	} else if (!q->properties.is_active && prev_active) {
+		decrement_queue_count(dqm, qpd, q);
+	} else if (q->gws && !q->properties.is_gws) {
+		if (q->properties.is_active) {
+			dqm->gws_queue_count++;
+			qpd->mapped_gws_queue = true;
+		}
+		q->properties.is_gws = true;
+	} else if (!q->gws && q->properties.is_gws) {
+		if (q->properties.is_active) {
+			dqm->gws_queue_count--;
+			qpd->mapped_gws_queue = false;
+		}
+		q->properties.is_gws = false;
+	}
+}
+
 static int update_queue_locked(struct device_queue_manager *dqm, struct queue *q,
 			struct mqd_update_info *minfo)
 {
@@ -1109,7 +1144,7 @@ static int update_queue_locked(struct device_queue_manager *dqm, struct queue *q
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
-	/* Save previous activity state for counters */
+	/* Save the activity state for queue removal. */
 	prev_active = q->properties.is_active;
 
 	/* Make sure the queue is unmapped before updating the MQD */
@@ -1150,31 +1185,7 @@ static int update_queue_locked(struct device_queue_manager *dqm, struct queue *q
 		}
 	}
 
-	mqd_mgr->update_mqd(mqd_mgr, q->mqd, &q->properties, minfo);
-
-	/*
-	 * check active state vs. the previous state and modify
-	 * counter accordingly. map_queues_cpsch uses the
-	 * dqm->active_queue_count to determine whether a new runlist must be
-	 * uploaded.
-	 */
-	if (q->properties.is_active && !prev_active) {
-		increment_queue_count(dqm, &pdd->qpd, q);
-	} else if (!q->properties.is_active && prev_active) {
-		decrement_queue_count(dqm, &pdd->qpd, q);
-	} else if (q->gws && !q->properties.is_gws) {
-		if (q->properties.is_active) {
-			dqm->gws_queue_count++;
-			pdd->qpd.mapped_gws_queue = true;
-		}
-		q->properties.is_gws = true;
-	} else if (!q->gws && q->properties.is_gws) {
-		if (q->properties.is_active) {
-			dqm->gws_queue_count--;
-			pdd->qpd.mapped_gws_queue = false;
-		}
-		q->properties.is_gws = false;
-	}
+	update_queue_mqd(dqm, q, &pdd->qpd, minfo);
 
 	if (dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) {
 		if (!dqm->dev->kfd->shared_resources.enable_mes)
@@ -1215,19 +1226,39 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct mqd_update_info minfo = { 0 };
+	bool batch;
 
 	if (!dqm)
 		return;
 
 	minfo.update_flag = (enable == 1 ? UPDATE_FLAG_PERFCOUNT_ENABLE :
 						 UPDATE_FLAG_PERFCOUNT_DISABLE);
+	/* Preempt the non-MES HWS runlist once for all compute MQD updates. */
+	batch = dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS &&
+		!dqm->dev->kfd->shared_resources.enable_mes;
+
 	dqm_lock(dqm);
+	if (batch && unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
+					0, USE_DEFAULT_GRACE_PERIOD, false))
+		goto out;
+
 	list_for_each_entry(cur, &dqm->queues, list) {
 		qpd = cur->qpd;
+		if (batch && qpd_to_pdd(qpd)->has_reset_queue)
+			continue;
 		list_for_each_entry(q, &qpd->queues_list, list) {
-			update_queue_locked(dqm, q, &minfo);
+			if (!batch) {
+				update_queue_locked(dqm, q, &minfo);
+				continue;
+			}
+			if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
+				update_queue_mqd(dqm, q, qpd, &minfo);
 		}
 	}
+
+	if (batch)
+		map_queues_cpsch(dqm);
+out:
 	dqm_unlock(dqm);
 }
 
-- 
2.34.1


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A76606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pVKeX9BJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A53910E15B;
	Thu,  5 Nov 2026 03:13:14 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC66910E282
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je811aC8gS0qVW60brvIe5s5qqmPFp8XmqO+EU4aWYHWknPvmCckaMgVMyKLibKApwDcTiZJdR6kKc9UEDaTWOV98Zw6qlYR9+KY6N7XaxH0oNC1lMoebaAI4OrEdxzPbFlYN4Mv9Cy3AAVbodTJs5NfyLu/MDN2pJHhW5KYvamW+DLrv6KpvR7Urf82asRmklIH0Mn/baUKhgkT/tKslBHrAAcpRfRFmI2c9MC3FqVuDmuiqmVwuEqDetKfmE9HvFaQYf1QDQZTj+DnSFoMeASW+Et7N1kN3hSoHebQ9jT3l11NAkgUJMRcXFT09KNCf+D5Bx0KJxwEtXgYE5u2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujotBhNiTzvf8IWn4LJsJZi/aK0dCPkxSskNquw4ZdU=;
 b=dX9j2emOozDVFPE9Aob6GfS+AhdO0u+GLWdKX5Ruqv3zEi2Xc10HEEQ/NnEc6Xv/nNVwmo+ofqFF+JBO+5gtjwM20QGyRtAf0s+YcSmrV43PCfr/kZvXwLAVxukqmlHLZ/dTv9axIFT1pqJU29KV4E5Fh/JfBGvTWHbwE2nzasOYuAg+NHwIl6AMWRC9y68/A7hm3+jYGViSvEmI1rnL/OTStScLHB3oCeCLC01y28GBnsxScw5R3Vvi1w3EhIDIgpy4/73zv8VA56GTz6QM0rccnDeWyEQQvw5o/Sr2SEe3hl5KUxOyW/w/56rq2H6BloV47Ax7VOqfS+lKKUcABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujotBhNiTzvf8IWn4LJsJZi/aK0dCPkxSskNquw4ZdU=;
 b=pVKeX9BJ/ieewnm55CIqblpoX8TcjETu3hKOBPgRxpp4z1fxaVyi4m4Agx/MkgU233qDloOlMcEanQsNsyJNirEbYT/XKWPxFkvdhYLvhxq8qDcZVhv+g9bWe0vmk7mbCFCedbDNu+5ybiWjprDC+CSTj9qdABdYmkwhc7stfAY=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:13:03 +0000
Received: from BL6PEPF0006C3E0.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::1a) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:13:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3E0.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:13:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 4 Nov 2026 21:13:01 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Yifan1.Zhang@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: preempt the HWS runlist once in
 set_perfcount
Date: Thu, 5 Nov 2026 11:12:48 +0800
Message-ID: <20261105031248.3692763-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105031248.3692763-1-perry.yuan@amd.com>
References: <20261105031248.3692763-1-perry.yuan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3E0:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8457c447-1e9b-4958-af0c-08df3aeab492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|18002099003|22082099003|10067099003|11063799006|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: YAy5C7ipbDENCQtf3cjJQKWMUkl+SIIDbufolQlosDyiVO0eh8X54UBpINBCzGg1bF6diy7PQDWb2vB2Wp0PVX+bpu4BQxhbve7RJNMPwfSXfuce64/qaIf9/gMVHZpFa6idMkqzkfOcqvWFlDVGuP+MMObeh477WxIu5QpkMY6ifuYbH1p+8XMBi04FQ6FjNdboZem5WUzbtUfknYMZAjp4gGtUjXUYaDT7zkObKbo0kee9tjp+5x3M/NEkoWj9YV3/DTx4nQ3RyvkU+IKn/UPpsz2HPQqQa6yb6ofEYnnnKtnb99uW8HyEEQe1gKs8Vbf2K4JReLO7l/HdAMv3jIF5H3Gl2dhbdnBqwP7Bj+yZta0xWF6LoDmXeWHbYXi6KVQoLM18u0bWAzrFBAUxn06JJwHtdeVIv94Jw4vCwJKLfPC5ELRV49oZI9Wl0ihgpqkmqXPH6/HzhTpNaxjPr83Lr/ZE5McE8moz1yjMuWC9i4H2+GqrrNbKs/GZpS8zuwO5vbEKnDJNzGVTjL3yAYVQvyFchW15W3q+n3ZAVu4Nq877K26TQb8FNq06Mb65vkpoKB82GnB59O3i/0Lp1dWI/vuDqkFaPunO9klm2qfE2GDNP+MXiesYXPA9lb91gUNqALq5xAfvDA32NLOFOjGKIEHFcMdRZWj4xnMZx/djC9HqBx7Tfot5D9WJU6bdIGijQlkgkubjaiwhP0zbYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AxPEfc+LqQugBZVfI2CvrE9Y7TTXKUxzIhX1uvaRONPWOCLN0sySEuunW06XRLtIKZG9A+zWCvhxoX5uO4/z0u4b+C+Pa4GWcBzpchHxh0KexsMyrsUdhFMvLw7YCrfoqx490F6b5oiBcE3MxCP0NGGMFs/oVXnGnljOZ+k8IjfTRmrAsYuxI+dCZezASU6k2vR7Xej8DnWKbs4JECrh3wVmynUiVTLKMFJgXrJE5oE2jay/UU3n6jCDW6Q4KPM/4KjT5x+yth0C++BmH8gxE8Gww8L54t44pZIqS5UCVGjVwUIpSXhY18TjalawqyohtuEmCGEHuoivp3I6X6hS4OrgNG1X+ZAsDaq5Ii/YK2IVOF+4TRDZvqwKc8kU8LeISE8rQNTNTk4PS8Kzbqx2vOwjQ4K45CNmu7zj6Pjxj1sTLxonNx18OtgESTW/61z3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:13:03.5725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8457c447-1e9b-4958-af0c-08df3aeab492
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3E0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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

v2:
 - Add Yifan's Reviewed-by
 - Add the missing dependency "drm/amdkfd: fix double lock acquisition
   in set_perfcount" as patch 1/2

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
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


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9122606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ch8f0Zqu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9BA10E282;
	Thu,  5 Nov 2026 03:13:15 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D3C10E15B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZQWGOJkb/cQ9uR6/mCXdx7OcUnCMWZ5UUATFy7eq8vvcLw57CQcI4AFlMstycYj1L072ylGU5Z4eIJZHY60pHi0SNo93VSmmae0CrLMVDzo4ix4bQ6C4Ll7W7V55vOy7MQZrQlmh8WLzweQSSI9nhYsxeFaPVf/nNxWzVy/G+P716EV338DbK4tg/WMKry7jLFSBRzKL1OwsJY8/Nf5NjqROnXWDHuF7yStXgchQeQCu0FKnh6Ber2WYGRcFKFgndlE4cd6iOIh6sIpCYqo082LACuDuzLFKSElCOJs7LRvB8n4yfg+IRQBhKqV705DtGnydXKc0xWk5zxORlv/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PZp5X/0HklAXuSAydCwIPF2D1UQDD24eimcSPFvmno=;
 b=ZIcneWIbWnf0TXoQ9UF3u3gYsQ7JezeUVUep4PlGkRw0Ca0qyyKdCpB/JzsErfm06cRLvTyMzxE6lm9Tg25tIG399oHIwxgH50+pitbRMOAH93fzbUdzAYAM8MIJN2Hf4wsKPj0KidwGJHfd8m8iSoTGzDXyrtyeeF6efkKMNOAQj5MxyWz1+5O0mmwKqFjTCVdGUX+eTtIAhD1rTrwASxBLAdinIcSO19gBuU+SqdNxNVCJEFesLfQw9oCZy18EucEYZ8d0g9CoygwOpyShWHVEJTfUZJVgZ2DLGfj+Ek8U4gQV3uRaaBdLN4L5LqbbS8XK7CzBDeiyHtoK6OCb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PZp5X/0HklAXuSAydCwIPF2D1UQDD24eimcSPFvmno=;
 b=ch8f0ZqufhN1grUsXkafq3vGYmaXlWIbNgNDxHZkhH6fOi8kA9nf3I1OPsT/55/mVvZkDt8VnR45LniCjDSkJeG2i441BldV+Ez9MB5U0ZSKj63WQKRUCGv94UBz+xBRlfIsegpXQsMhSe2Je+b5a6kPpFxiWC6RE2lUfhDJho4=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 03:13:02 +0000
Received: from BL6PEPF0006C3E0.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::1d) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 03:13:02 +0000
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
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:13:01 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 4 Nov 2026 21:12:59 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <Alexander.Deucher@amd.com>, <Yifan1.Zhang@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: fix double lock acquisition in
 set_perfcount
Date: Thu, 5 Nov 2026 11:12:47 +0800
Message-ID: <20261105031248.3692763-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3E0:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 526f6d18-57b1-44a0-f6f6-08df3aeab3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261021123027099003|261102123227099003|11063799006|261021121427099003|56012099006|261009223027099003|261026121527099003|261028144727099003|261022105027099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: xS/Y7dVRCcgqrzmmU4Wua5J3eQRbxBxGKvMjTdM9Rim4/IVsiN59vfaE39Pbo/RD3YgZQyPIe6HDIkfGFdWrb3FM+Kdm2RcvQlKg20vnasohLBgXysuTki/vmjSE6D7Z372Pnz6y6DbSeKAUlDr64HCm5k/HcNNHXYYdIS1cOZqmb4HffHUQ0s/T6og97oUH1Gqv7mAAyZAY9oJw7DFcJAb6ewO6Neqf5QM8uU8a16n7WSLotJyDEuiV333/Eh8S7zGBh1/0nNZ4XUzF7NhzOU2B9zdl2iZHLZeC0VDP+0i414Z4yrMvGCE9Ubi/tIaFyWiMDrYgBABijKuk0e/baSfGFLD59DUTKZZHMCBs2UrdGvIkxMAtTa26yyewX0/o4kgMMtDBn1HcotitkqbqhbPImdKWa9u04uc+BTQTnHSgsBzN2/VLM4gf0aaTB2Y7UyPzmRpXuvggnz2peg3DhWt1xu1Rv4MDNwWCFfiN/dHwsskJb6XhXAqzOyGMTrztiNHAAlvtqe8vf+w6QraA8jtqtGGRdv/oWuTHhW8ZGIMtmscwMkQFcPI+2VQZei/OaHzq/Yu+Sg6nFqDSEJUUCHIGzbqCrAUEWIoULr3yc8adLWlj65+8bL4Fzm/Dpm4PX7hkJZJhAS1GtNRk8+3geU13sYT/4QNBe+MO6qeCPCCz1TZcSELo9p7wR5E1B8FsbOPn+15lhWUHNM9pJqbitw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261021123027099003)(261102123227099003)(11063799006)(261021121427099003)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DzxG0R5/lX6SdOE2mEodnz9QL1u4JG+1/8wuBTscqHTuXf/0cmDCZt8/3Z5hT+RB5lxnAjTFWNb/ufStQbcqPXIa4ZtcyyfEdsbpcxVzJe34ZDqWgBQk240ebZQxoDPtXFYbVUNrg+2DnnZ5H6j02zKbV8eEduWRRSoVjGqbAdsRzAFmbz+j1KQq43acCYVmUtCdIVatfaBlUsv1x7alqDmTQXczYgesp1BAnjLrZNKUJMee9G4NuCtfa0fd8p/86LKanLPxcEWu/tyQS2LSH+VRJu56zpnZtt4/mt6ztrU7GO+leIz4RW7RpHofnPNyWgUHlfJFaO6XcJrwfs4Zub5DgTwu98OGjWh047Ue9O6TzSZeQ49GUCHqMhjauHV5mOIIH+QLnNH5WIOg2zk4OTbOGnhvG7n6w4vRkz7qnzeBix3yV7mnuZRim0LVr4nf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:13:01.9856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526f6d18-57b1-44a0-f6f6-08df3aeab3a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3E0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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

From: Benjamin Welton <benjamin.welton@amd.com>

Separate the locking from update_queue() to allow updating queues from
code that already holds the DQM lock. set_perfcount() takes the DQM lock
and then calls pqm_update_mqd() for every queue, which ends up in
update_queue() taking the same lock again and hangs.

This change was in the original mailing list commit for set_perfcount
but was not included in gerrit.

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Signed-off-by: Benjamin Welton <benjamin.welton@amd.com>
Acked-by: Kent Russell <kent.russell@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 72 ++++++++++---------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ce67e56efa8c..f4fb99b599da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -346,29 +346,6 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
 	return r;
 }
 
-static void set_perfcount(struct device_queue_manager *dqm, int enable)
-{
-	struct device_process_node *cur;
-	struct qcm_process_device *qpd;
-	struct queue *q;
-	struct mqd_update_info minfo = { 0 };
-
-	if (!dqm)
-		return;
-
-	minfo.update_flag = (enable == 1 ? UPDATE_FLAG_PERFCOUNT_ENABLE :
-						 UPDATE_FLAG_PERFCOUNT_DISABLE);
-	dqm_lock(dqm);
-	list_for_each_entry(cur, &dqm->queues, list) {
-		qpd = cur->qpd;
-		list_for_each_entry(q, &qpd->queues_list, list) {
-			pqm_update_mqd(qpd->pqm, q->properties.queue_id,
-						&minfo);
-		}
-	}
-	dqm_unlock(dqm);
-}
-
 static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 			    struct qcm_process_device *qpd)
 {
@@ -1116,7 +1093,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-static int update_queue(struct device_queue_manager *dqm, struct queue *q,
+static int update_queue_locked(struct device_queue_manager *dqm, struct queue *q,
 			struct mqd_update_info *minfo)
 {
 	int retval = 0;
@@ -1125,11 +1102,9 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	struct kfd_process_device *pdd;
 	bool prev_active = false;
 
-	dqm_lock(dqm);
 	pdd = kfd_get_process_device_data(q->device, q->process);
 	if (!pdd) {
-		retval = -ENODEV;
-		goto out_unlock;
+		return -ENODEV;
 	}
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
@@ -1147,13 +1122,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 
 		/* queue is reset so inaccessable  */
 		if (pdd->has_reset_queue) {
-			retval = -EACCES;
-			goto out_unlock;
+			return -EACCES;
 		}
 
 		if (retval) {
 			dev_err(dev, "unmap queue failed\n");
-			goto out_unlock;
+			return retval;
 		}
 	} else if (prev_active &&
 		   (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
@@ -1162,7 +1136,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Update non-HWS queue while stopped\n");
-			goto out_unlock;
+			return retval;
 		}
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
@@ -1172,7 +1146,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval) {
 			dev_err(dev, "destroy mqd failed\n");
-			goto out_unlock;
+			return retval;
 		}
 	}
 
@@ -1220,11 +1194,43 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 						   &q->properties, current->mm);
 	}
 
-out_unlock:
+	return retval;
+}
+
+static int update_queue(struct device_queue_manager *dqm, struct queue *q,
+			struct mqd_update_info *minfo)
+{
+	int retval;
+
+	dqm_lock(dqm);
+	retval = update_queue_locked(dqm, q, minfo);
 	dqm_unlock(dqm);
+
 	return retval;
 }
 
+static void set_perfcount(struct device_queue_manager *dqm, int enable)
+{
+	struct device_process_node *cur;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+	struct mqd_update_info minfo = { 0 };
+
+	if (!dqm)
+		return;
+
+	minfo.update_flag = (enable == 1 ? UPDATE_FLAG_PERFCOUNT_ENABLE :
+						 UPDATE_FLAG_PERFCOUNT_DISABLE);
+	dqm_lock(dqm);
+	list_for_each_entry(cur, &dqm->queues, list) {
+		qpd = cur->qpd;
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			update_queue_locked(dqm, q, &minfo);
+		}
+	}
+	dqm_unlock(dqm);
+}
+
 /* suspend_single_queue does not lock the dqm like the
  * evict_process_queues_cpsch or evict_process_queues_nocpsch. You should
  * lock the dqm before calling, and unlock after calling.
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02A0C54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 09:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00CB10F203;
	Fri, 31 Jul 2026 09:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2k/YUTni";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118E910F203
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 09:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYNUD02ItJufSkKo+mi4DHZqDC0va+csyN2JZ6si0HnC+MHGg9NJesnHh+XjNWN5b5aWlwLjAZmTg+2rt6oOPG92fk0jhuQb2rqQsRdAMo/wO5e46YCKPlk8zPRz1qqim84/OIaFYG3rRVS42pzrdMI+DgMEsMzW+Rw3g28v3/WR3/LUqXC6T+uS55BtwPviz7jhpHYMaEmG98+HOiExkVJsp1M+S1jR7m4mrv1SM1K7MbO3VPgrb7WxQljKQjpORsCkWVgbqNwOXDEDEr64MOe3XbAhB2X4UfU4m1OfiXl2pKR4FLn506pAK+DbfS6Goq65PK/s8/EQ551hVaGYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+KC6johg3gmc01fG2ai+4w+6jVxBRAEuW7E2PIbFuI=;
 b=O5OKvz2CqBlWRYJ1LWk4FvQy4+S4coDTY5amA0QWhu0uCgs6qRIMydj6816l3GsKDuNxLtZfnM1iyaGRJM/8akGIHhU2Qr75Unzx0ssEDsZ9oLMpQvBAPtl1aizItNJ2kdea90NEk0lAJWrtKy4UHddG3Zi8PG48nLe5dlB4zLlIYY66YwOpDmw+eZORhRJLRUm+dfiCcJAGe9NWs7gPHv8/CIw7FwAo7jcFtv4bdMUq+UOkoScmfC9Jn5bVTcKIA+BMeyRar09OvP/hIKGJwRr4vNOFKM8U8g5mRukXnE9ogrA7bDswuoDjEvmB0ZvokPO4+l8TWpZ4FK1XWivOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+KC6johg3gmc01fG2ai+4w+6jVxBRAEuW7E2PIbFuI=;
 b=2k/YUTniCa+3XfBnDXsPSepFiKQVDaS4aWJdKQFXYA9jmoevmK5Y8YI89jYv263AUjl40NKK07XsgqZTycAuAxVtDExMVTyecX8vKKSXZk2SVGBKKsQUGdpKcxVSu/OWPF8/uHAast155R1Vd1/l2kT6+ZurXzKU2kohhEPWZKM=
Received: from SN7PR04CA0046.namprd04.prod.outlook.com (2603:10b6:806:120::21)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 09:51:17 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::8b) by SN7PR04CA0046.outlook.office365.com
 (2603:10b6:806:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 09:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 09:51:16 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 04:51:14 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: fix deadlock in set_perfcount
Date: Fri, 31 Jul 2026 17:51:05 +0800
Message-ID: <20260731095105.3529371-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: be55f9e4-cbc4-4f7c-6d79-08deeee943b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|56012099006|5023799004|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: T2y42CJjJwVB5ZzcA8rSSBQpHaCNa/RmZ4SU4kWAIxO/8bG7A9K2UDln0d7qKMVOAdDwOT/5+LJbIfhjyz+VSA5ibYoHYe9zc4UmKXJlrBV2P5jNSJd/DI+2rX8loqVUSYVSyQvrLXFWHVVtsmRAM7aHcbyPpsvaXAYVdvxx7ZBI3SzdZgNhHmncb1fM1+139fQNiYGWUbawwvIE6ayHHA/kkciMfgDQoxqiTbBJ/AVwQYoB8FN/U6H9syprj3OUgL/zg7vNUu3xfABsZq9sW9oPL2B4hk+Y4Y8rha4tHiy3wQa1engSUjFLdTH7Ipp5DCSyixn82EplKZ4FZfifIx2AEPtmT9SfI9SfZrI7Iymix2z/u7nJDfIJeH5/IpfXF8VNsip8upiVO0nY6rnZOfXE3KlIj+bOgF5cGkfpOq/8sHGmrT88COcJmuK7zGI95BBXfMhyQzt0yhXqXwFHjvYOmtd1dTsS2WKzeDREdvk6owkF5a5Se3gYUKY7OoRVEOJ9yAwi/aCbFQ3X7AwFDtEULudYFyenwOQyDo91Le3RjBk3fgyAOUtROz9fvI5wO8mEMxvoX6MW7B00LfF1buwVJijvUgsvJ29PUPWM97z1AeEKiE3bYpKRvJc17WFXHLpQzvGHmGNBxEZHfgd4Wy4A4ev4VDFF+wTLMJt/hS0LlAFyZ9thNx8KFLMda8ApHApNycSnGD794+H4t00a1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WACvQU31lk2VRx7GusWvFAYJ3DbDOIzV1IyToxxL2GvcMvJ3w7J/+rhOBKBm7bj4qXb/hPKddqRpcdH7+ndiAVoopC0U2pD5auVXzr2pfYNyg8ZRHCeJrsneFM/qRyoJM0SDwE0gyaqbuWxsUjCMbYhKc28BawJqoZFeW0X58gkZHpgZAvHhryu45AOP0ZLlrY2ZWnCPJMngdmgj7gqoCDAApqLonkpxJixUMKwItJwclxLJ6qRMMpnz/eZWn6FHLKXpmWqL8tFfRadSDRhaZEKaq0dQri1L+VmhtXK8nECGKcpk22UuCYxqCyqKXIB/6Yf/mjZwdXkD9xnmggtTO8vWQRAYYt2O98o9413CICppqih3775o67VvMAAWbJWUMrQjWDP1FJ1hjPIEbTbbCnKOuXOkRJZSR+iYb8za+4PnPgnMOBuQUg9GlQlBcOEI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:51:16.3168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be55f9e4-cbc4-4f7c-6d79-08deeee943b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

set_perfcount holds the DQM lock (dqm_lock(dqm)
while walking queues, but pqm_update_mqd
calls update_queue, which acquires the
same lock by dqm_lock(dqm), causing deadlocks.

This commit introduces update_queue_locked which assumes
the dqm lock is already held, and update_queue calls it
with proper lockings.

set_perfcount calls update_queue_locked instead of pqm_update_mqd,
therefore the deadlock is fixed.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 44 ++++++++++++-------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 51ee9c39104b..c34c5f6a5541 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -77,6 +77,9 @@ static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *
 static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
 			       struct qcm_process_device *qpd);
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
+static int update_queue_locked(struct device_queue_manager *dqm,
+			       struct queue *q,
+			       struct mqd_update_info *minfo);
 
 static inline
 enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
@@ -341,8 +344,7 @@ static void set_perfcount(struct device_queue_manager *dqm, int enable)
 	list_for_each_entry(cur, &dqm->queues, list) {
 		qpd = cur->qpd;
 		list_for_each_entry(q, &qpd->queues_list, list) {
-			pqm_update_mqd(qpd->pqm, q->properties.queue_id,
-						&minfo);
+			update_queue_locked(dqm, q, &minfo);
 		}
 	}
 	dqm_unlock(dqm);
@@ -1059,8 +1061,9 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	return retval;
 }
 
-static int update_queue(struct device_queue_manager *dqm, struct queue *q,
-			struct mqd_update_info *minfo)
+static int update_queue_locked(struct device_queue_manager *dqm,
+			       struct queue *q,
+			       struct mqd_update_info *minfo)
 {
 	int retval = 0;
 	struct device *dev = dqm->dev->adev->dev;
@@ -1068,12 +1071,11 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 	struct kfd_process_device *pdd;
 	bool prev_active = false;
 
-	dqm_lock(dqm);
+	lockdep_assert_held(&dqm->lock_hidden);
+
 	pdd = kfd_get_process_device_data(q->device, q->process);
-	if (!pdd) {
-		retval = -ENODEV;
-		goto out_unlock;
-	}
+	if (!pdd)
+		return -ENODEV;
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
@@ -1089,14 +1091,12 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 			retval = remove_queue_mes(dqm, q, &pdd->qpd);
 
 		/* queue is reset so inaccessable  */
-		if (pdd->has_reset_queue) {
-			retval = -EACCES;
-			goto out_unlock;
-		}
+		if (pdd->has_reset_queue)
+			return -EACCES;
 
 		if (retval) {
 			dev_err(dev, "unmap queue failed\n");
-			goto out_unlock;
+			return retval;
 		}
 	} else if (prev_active &&
 		   (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
@@ -1105,7 +1105,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 
 		if (!dqm->sched_running) {
 			WARN_ONCE(1, "Update non-HWS queue while stopped\n");
-			goto out_unlock;
+			return -EIO;
 		}
 
 		retval = mqd_mgr->destroy_mqd(mqd_mgr, q->mqd,
@@ -1115,7 +1115,7 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
 				KFD_UNMAP_LATENCY_MS, q->pipe, q->queue);
 		if (retval) {
 			dev_err(dev, "destroy mqd failed\n");
-			goto out_unlock;
+			return retval;
 		}
 	}
 
@@ -1163,8 +1163,18 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
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
 
-- 
2.53.0


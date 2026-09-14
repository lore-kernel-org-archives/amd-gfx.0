Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D487DC88E50
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5197C10EC9E;
	Mon, 14 Sep 2026 13:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENWjh3v3";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B87310EDBB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYJNafbrhz/Hlh7NbIQ3oHebe1tE/PS4DPqdGgk1S+PiQStZaWlnDvnb2hooKdSG/lFSLi60aH4HJqvnVVY0xesx9bSGzJrzeQl6xxje91aGPWkOsCvZNzSm7g/059v+SrKolYnjYbWlKvuqkLb+cT7OnxUlPVkK+BbtSrHN5WgDjE0MqtkP8dMFRpnvI6hr+ho7xWJ4ejxRmAO1evVpBAiHVlKCGk9rjm7Y3EtnbO+AsMoQMJBdhAmT2aWlPbOvKV7vzXRexFnJIsnk3ojCVrBs1KDEnTuo+y8R/gXf1t5vwFKemkMMdyVn6FI80remfg29dTEQztteFPZBYGKYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBF0r4R1TbJ2vGi47Fe8cJoie9SQWt7gCgrmGlOlh/8=;
 b=xL9AJSAF46u+sgSBr6j9uNMeehNTX6UbTsC9BK3TPjQfS6dbZJh5uBEZqgoMOicYNmJ0ySSUSgN70A63wl/+b5pcsxoko9MTtOPsPmJev7rj9Zh+fuVYuRpPem8QfFpz1ZtKouMlSH+yBheXiyBqr3l5BQBmwlLIu+bI2Knj1lJes6lQH+Y4BDf1JzEWugPhCZmL/HTzOTzfIjTIycF8Gla6tLqEtDH6SKqltO9MCFUx1y4pEB35TqsbWTifzSghfKeVq1S+3bM0IcmXOwAW62vdKipFB4RIvbGWxHhaOlqApp1J8RIJoSuIxAKX0rahEPXSozf12rJiz8Iccvf67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBF0r4R1TbJ2vGi47Fe8cJoie9SQWt7gCgrmGlOlh/8=;
 b=ENWjh3v3xyeNrebPw/6XT3IQdAnhKKa6FtNGkc0+MlGpBV9vNxAyhRWHCy3p+65eXGIkJCGy8A60yielmEmCGh8X42lIGLWBPvHo6DLpxY1/8p2ul+4PukimtpjkJvaeLTQ1tezqSxoERlXDTQPK9XhGm7kXRMAmbkrR+HuPtqI=
Received: from BN0PR04CA0167.namprd04.prod.outlook.com (2603:10b6:408:eb::22)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:15 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::83) by BN0PR04CA0167.outlook.office365.com
 (2603:10b6:408:eb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 13:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:15 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:13 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 07/10] drm/amdgpu: hold userq kref during isolation
 scheduling
Date: Mon, 14 Sep 2026 21:07:21 +0800
Message-ID: <20260914130724.130794-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 9347349c-c2bc-468a-f229-08df1261191a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Xz/2hxQBetkiF3hQIVzviF25Z38fob+/whPwJvUHLsl5FJq5dL+NGAIcE9SbKfq0PdYqaQW5bexF2tMsnyLsb0aTV5YZcUh20dyoilitqsiQd6VuRU+oJQKjHrEKkl2dPbHTHcjJB2+ay37cAHpjjddy6+9zq+dVjY/zpMcjQY0B5p36Yjb+fJ9ybDh9S2I053zx/nRdAKQuQw2cDZtD3G2CxWXbZfXNd44OmeCRLLY4VUxOp47OrRHiEMhWYTz1W8392xTp/d2+N8O8gmWV43vpYHBFTLYw1gzb0WqswJGU8gV82e4359myUi453gWAcW+tMuDj1rY/qV4iE5Zw5z89LC54oani6Yiv4I0nk03UsBV5XYONd7sZn8IQ0fBv0wa49+E198bDrduKdrjNXnARsNqkg7B654z65E7HIN86pYkEs0fUsHjloCqVVptcYCJC0iOeb0MzPipDcePs9bNfCp1oUhWKMR+G1wUAAXOHUZ8AILpuAsm1Xt272Ej/GHWrzI1NCgZ3dUSegaeWhOXb+Xr1AX+nYCpxASimyDrBpD4VD5vqcLzs/38tAOICUgOdGYpQ+Lbv2ekDEOlHyO9of4uxvOKniEhpY/QqfDgGI2yKlcWzS3z6Fe7P36HSlY3hD6qGCJ4odIBS0UNqoke65ykn3EtdNYIdY8Pzb9H1v130VMaB8nD998GCxAcaBYUIQ/PtCXBGIqmVkf9+uA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xzEnnVemJ3XwYiD2EI1ycpYgjsw2FwTIoUOL/W+BBMdxYWow/Ne3diZaVNX8EJo+b7gcNLbWxCOrOFDhiPReqBh6kFiLKoE4nWFKtCKtjuuI1GUn314QBHh7cRgjIm4cQSQch2j/i6zr6y5KVxrZxla3tqymOPQQmncMkY9lGudJgizDd3ZmXMvm8GrOl0o+8AYFVgInQBoXHxpqUhnP/nrA+KcgAOtfX0h9RMW/cs+E7pnrRNwbVlSBrgmsUsP9ISCemIAjJ8F2Qa5ojBnrpEuAwmJkzPRh4roVXQzi2b1kViEFOr+Jqoo62zgLahIo4pjdLh8rCycibV835SvnYwIyxbqMyFcZ798tEgYsKCzLjNolC1V9Ej/RqD7KKWVBHiLr/wCAYJSlDAOCOMc2U1Zyv8v05EydVJesW8JDHnboRz95OO+fyKEcRHycsQ7k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:15.1836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9347349c-c2bc-468a-f229-08df1261191a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

The enforce-isolation stop and start handlers
iterate the doorbell XArray, but process a user queue
without holding its kref. Therefore, a concurrent queue
destruction process can free a queue before these paths
finish their work, causing use-after-free problems.

This commit fixes this issue by introducing a new helper
amdgpu_userq_xa_find() which finds a queue from a XArray
and hold its kref, and employ this helper in the
enforce-isolation stop and start handlers.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 72 +++++++++++++++++++++--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9fe20cb9af58..1427ff175dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -661,6 +661,54 @@ amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
 	return queue;
 }
 
+/**
+ * amdgpu_userq_xa_find - search the XArray for a queue
+ * @xa: user queue XArray
+ * @index: first index to search, updated by every iteration of the search
+ *
+ * Return: a queue which has the lowest index that is at least @index,
+ * or NULL when no queue was found.
+ *
+ * The caller must release the kref of a queue with amdgpu_userq_put() after use.
+ */
+static struct amdgpu_usermode_queue *
+amdgpu_userq_xa_find(struct xarray *xa, unsigned long *index)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_find(xa, index, ULONG_MAX, XA_PRESENT);
+	while (queue) {
+		/*
+		 * If found a queue but failed to get a kref,
+		 * it means the queue is in destruction process,
+		 * so skip it by continuing the loop.
+		 *
+		 * If get a kref of the queue, break the loop and return it.
+		 */
+		if (kref_get_unless_zero(&queue->refcount))
+			break;
+
+		/*
+		 * If the index is ULONG_MAX, we have reached the end of the XArray.
+		 * Break the loop and return NULL because ULONG_MAX + 1 = 0,
+		 * which is the start of the XArray.
+		 */
+		if (*index == ULONG_MAX) {
+			queue = NULL;
+			break;
+		}
+
+		(*index)++;
+		queue = xa_find(xa, index, ULONG_MAX, XA_PRESENT);
+	}
+
+	xa_unlock_irqrestore(xa, flags);
+
+	return queue;
+}
+
 void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 {
 	if (queue)
@@ -1496,7 +1544,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
@@ -1506,7 +1554,8 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	if (adev->userq_halt_for_enforce_isolation)
 		dev_warn(adev->dev, "userq scheduling already stopped!\n");
 	adev->userq_halt_for_enforce_isolation = true;
-	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
@@ -1518,6 +1567,13 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 				ret = r;
 		}
 		mutex_unlock(&uqm->userq_mutex);
+		amdgpu_userq_put(queue);
+
+		if (queue_id == ULONG_MAX)
+			break;
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
 	}
 
 	return ret;
@@ -1529,7 +1585,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_mgr *uqm;
-	unsigned long queue_id;
+	unsigned long queue_id = 0;
 	int ret = 0, r;
 
 	/* only need to stop gfx/compute */
@@ -1541,7 +1597,8 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 
 	adev->userq_halt_for_enforce_isolation = false;
 
-	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
 		uqm = queue->userq_mgr;
 		mutex_lock(&uqm->userq_mutex);
 		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
@@ -1552,6 +1609,13 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 				ret = r;
 		}
 		mutex_unlock(&uqm->userq_mutex);
+		amdgpu_userq_put(queue);
+
+		if (queue_id == ULONG_MAX)
+			break;
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
 	}
 
 	return ret;
-- 
2.53.0


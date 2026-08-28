Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572A2C61DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 09:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1B210E3F8;
	Fri, 28 Aug 2026 09:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKqR4X7v";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC5C10E39D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 09:53:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFx+1W47KLhA1Pc9NFNDAGjfptwuYEpI5EAgwHUHu+jmZUV95vK9DVa2iHvRASiYjeHcyHYjX6fsN81HcnTYrftr7barFv7WWorrBc9OgMC8z5jmJN1tDQksKpY/qMzZQ8HiFHI0mcqpJk/7dl3pMSoV5k4Olg3zvCg1UW2zjbPJmgM0NRHkGDPA+Jp8z4bZfMqMEwsw+oT03/OxOKdbXmvHIjSN94D1zCTkZKayDOk+uiKZmdLA2fYmcgSYgZxNZGa3CwnrxtTp3R+0K0roBVyf7BWF9clin8mjEOuGH8KvHpT62ebSC+FPh4roTpnzOAZDisn0ErUApIEId0NtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBF0r4R1TbJ2vGi47Fe8cJoie9SQWt7gCgrmGlOlh/8=;
 b=woac6nv0PZgoQI8CNCxdO0DGc4KoV1gw27EK3Z7iR6G2WdRDEP78zpk9DsanE8RjioYskdYTfRXmLgdBWEr4sRlHbBPmlypvttfQTfQAUGZ1dKAqP38HlWfn4xy1M5aO0WSSO9zErxBjSL4QxEn14jxrRRM8ELPuY85X5xSTUovEidnk3LABkeBXt8PsgNVP4F/fbGsheCsNzEBDXU9xxsdMK+zqj/FHJRinmaKZrpkAQiv0WMN6StWDXAAvKxNFXnlQCOEQDX2twQshs4h5IummK92gS9Ns4Mla9MmsXnALEZvfogWjUsaeZ3ShTdZ+9C57FXM9CLRMpVG7RPnIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBF0r4R1TbJ2vGi47Fe8cJoie9SQWt7gCgrmGlOlh/8=;
 b=FKqR4X7vl0SsQO+wQDbZEl3I9QW/vI44xXxFOF4S+9tj9LDO/XC8oFfMrs/m4tSI8Ij+zR01EWGRdzcjUa5Mkjnu1cgSHuuPe9pUiOW2bkgryTivqWifb0lSj836V69v107QpsgNQEnmfhma+hMgdUH9uXe9rV1ljxesVkbF2eA=
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 09:53:54 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::43) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 09:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 09:53:53 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 04:53:51 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 07/10] drm/amdgpu: hold userq kref during isolation scheduling
Date: Fri, 28 Aug 2026 17:53:46 +0800
Message-ID: <20260828095349.9797-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828095349.9797-1-lingshan.zhu@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b18d07-cea8-43a3-9d2e-08df04ea450c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y4lcpQJw3CVTZDTxHoOpDAK4ScWoWs3K4UP+s/n0Oi2DyQywx8HrrSvMCLphK3Edgl6UjnIE/18CAoOSLdFe7AwGOAfml5lwb/02al3QkObBWzHIza9coISmfskPRdNz0Wf/i/ofckSBN2uLMcAVaJPzfDduULiVTbsEpXtDi3GeozFSnwpMpJNB43AH4H2pd7xQIvtt3fNDM1CdWeCYvYM6evsNee7mqZfdpJ1K2gGIUARRZ6cQ6CgxzR2cDDxxuDmZcZjlHqXloEENWqHQVl43SjZ8Y8UU1PMJdhsUo325OvzEzs/QWou/wvlA9e87aYyZnA1qyHsUFCf2rOFbnZcSHH5TeBUYkAWuRGo9MUy/Ti0b33uJ9ZinEtMH7nnx64JjJi2rxEtY5oB1mL6h1AEulkuGZ52BNDRqx0YTWBUOmsHXlYCL56nPR4HGjnKIM4DUVTzlFy8NXKUoi2CxXz56zUUeIyqEfFLKggP/Jv1bjab1Wu7xpE9UW6V+bflkFdMazDkrLus8iPUjQrqRfZcFuSE/iDuu2Eg37JhE0+CpFaE+44L3xgQ7lXMU3BiEFigODFmAoagNjVuApBAgN+qurk83VxxaMdsT5iMA3nqo0QepCp46B8C1tg0fEagiKLitwgx5YeXfptvpbbRrY4OsEfRUG6DaokIOSh568+yXYBqHP+3EXB74RprCmNVo1mxUcRqGnd/defpZMrCRzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8RBP0c/ucyvafUtfzGp0JQSQdF4rW41w7J4lFJG2mVpH20LidExgi0W9qyJk9KjFg1vbcM7A5XQQxATgWUXUDwc0sUyoAo6pL2XTSdDvVyZnItIfZkBsB8mPeI6fXfay3BdEHuSkldtzn649Wh3196+mQjig4pZ63OOclsh+VFhY+HIr7J0QKEQJqFiqhvxk+r2ZwJgLY4DUVaf1473W5MnT1U6n9wnIjpqM0spMW80b+Xz6LFfC9dVKJjLPD13Lh4+f5ttQelMLNivaQb+F9NUuV075FJGqyqUEdzpu8+4hgB6F8aNxbMJvLz0293oAMK5Mzq7NeS7ggHaR5tIjNh28xqr80ZtHNwJXBEMYzjpb8iKZ/EPr8jihwB4W8TFUJmrttnCyGE5WJkwOg+KeGBvtu9/7pWfWs0Gu5AN5SgkPccE0qqbmbc/h2TA+wGN+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:53:53.6406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b18d07-cea8-43a3-9d2e-08df04ea450c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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


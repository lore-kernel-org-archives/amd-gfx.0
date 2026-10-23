Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EB606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FNfRAMkU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C5E112A5D;
	Fri, 23 Oct 2026 09:09:12 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E743E10E5F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rliNV9S+BouMlAOOQ6ogjDx50Vgejm7Nc5SknOkJqe7jTdSh9rzOIZbQpk+6MRa8eDt3pNMPNljghMAleHOWytW8yI1B+djf71qEoZNbek4SvCMKXwo8YU30X0tiEZCnEsUbKXwn30JxDW+VcUNRwtovY5/vdxI3PeD7CvS8Mzxdv8DUm6VtXL1bQLAlfExusvCWzDLi8TCzF+t/n9V4T+UBfPaRcEBQGKU2ZP+IFg1jg85iNVHaXuE9kOtE/9+0EpapuDBX9Q0OazOYtTnxAwcRsMCOII3xE4j/4vyTIaLvJwcL+i07A4udap91VEOBuP3JE3KFoMQvpi4gR0dYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jwBXSgt80azy7zHbh7l2mQvKpVtWXC1LQ4Bia7n/iU=;
 b=bIMomKuDWYN3AbvedtLDR0Df2nzLvaf0gWFoQ9SXlxoJX16MCtmN3FInZrQ9VMp9KlIgVcyZ9yD6pK0ydUlnzBWNI12CO1Jkj1dVazl+1pwC9XODx3Zcj1fi6MJRBnR83rYUcxrAPazgG7OYads4FhA8q/g1RWs1jVWmgYT0cKkZVDEZtJJNFsLIKbMLlvoLRp5ZDfBs5Rw7R4PHrYqWBGaXopABxLHqkW5HExNDqlGSs5M9ZkQEBUdg6ZZ+Wj0tzgBw3sPOBvytF+QPac1Hd9l6V/XUDXWE0Ho6YjSDgE6lE2RIb4VoYV/mHnrtBY0jqFMMNrAjeVmuf0aC3/rKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jwBXSgt80azy7zHbh7l2mQvKpVtWXC1LQ4Bia7n/iU=;
 b=FNfRAMkUNj+JDUbr48qpveCZJk5A7nYznczL1n7k7/8NS74l32EUXdY5HwjphKRG9QkpXy0RirrXi0e1F6FOqJflAb9PdV85QbTRO033SXisT96vugxDVESydfuljpEhnts/pX/VUJzFhWYSciejTjqz3FvGhfToJ4WAUukIum8=
Received: from BN9PR03CA0648.namprd03.prod.outlook.com (2603:10b6:408:13b::23)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:09:02 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::ac) by BN9PR03CA0648.outlook.office365.com
 (2603:10b6:408:13b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:09:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:09:02 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:09:00 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 12/13] drm/amdgpu: implement device PMC handler
Date: Fri, 23 Oct 2026 17:08:44 +0800
Message-ID: <20261023090845.670581-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 45908e6c-07af-4a9f-7593-08df30e547e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|261022075727099003|56012099006|11063799006|10067099003|261021121427099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 05bQNq+y1kbST16FuDBCTzS1zzpAVZX620YTXxxnioyuvL7xkc9tYHTU95Tbo7wUFxlrYFMl5T4JLAYIyg66c3UzmvTW9oqt7+LE5Jjrk8FK0opUnt3hhybMKLGbsWioGFAyOrDO5aloBPLyoCl9jnSrFD0yj4F2wra/4ZoNh+0dBN/8rN3PI9aEfwhiM8xYsY+hKjJJjUCI/g+dgixkr4prASFObQUWDARW8iKncG519Tt/9nLdNogBQqLb0uAd9v2oVXGHBcJULYwMAU5Mbq+ARLkD1n28R3C1WdsLp+Q8ZckF4T6biFAgaJqdDKfbxqbgPb992mnFqicqImc+xl0mJ4dJj/1H8KGT+pDPZbrXEPf64xLKzJkl3T75ODjfmc0fAMal9jIU2492ZNz5UMeTRSlo0ByASY5Ui1aMxO0ctxG4K8RmBbQv+N4FA3Qf+OK7sjGI0GgSd/x9mGei1vR7lKOFKBengc6mPRTOtwJE6QiRqDKg4VXZvS+g9o2CtiYwRrZ8Ok+0Fks+lpAIEBn/e+O0YU+lLx+aK1OIRLMPdxJmSH1vqSnAH80fvtAdJzV5fKRUM2xdehly4CqcDhEMwwY33koXmHBvX4pqVQLyTJbySBc9m8ehC4us3jdBFWjxD0u3VZpxEXYVNBFQrqpWdEPU+mTeqPfYri3Jwa47rxjDnraQIB/iQgujWM5tT73SAxz++fchi/SbJ5+PpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a4b5XC4rdPKd1VfO5Dj/ze8X3LDs22RhqCIrfbdJcjLj+1fxplTP5YS2UppA5BGKtlcm29EqEz4SkQr88w9Du9fmSQ8Z2PaDHlb2vDGDOKTtG3a3oW42mGh7OnN3D3kmG2eqpbi+2apzB0DzoF5kS++mGKzTQsSQ4E8GX/NjI/Vl5VL7az8YA7IXwjhAhFT1FookwZqgwjEjza3lul63nFuofwDA2OGhfsJcwx2sNjrhzuT5A27GyGFFbtu45jrUvvGmk3khbS3HAeMBjmIwdk6R+ARE35tYiW+A9zMfJIfvEzM/5fqMMUYZTqewUs9jeHkZBhCTLtLRXjsWYG/eWkeXaLhmwhtQowOZRHh2Nha53d/fMmtLqB+AY2mdZxE368L7zz/6ApYVQeEbX37F5iSjiJ5BafAznja/EonEFXAeL+NWJ9vaCsYsplxCbs5W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:09:02.1404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45908e6c-07af-4a9f-7593-08df30e547e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit implements device PMC handler

This commit introduces a new helper amdgpu_userq_xa_find.
This helper finds a queue from a XArray which has
the lowest index that is at least the given index,
and hold its kref.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c    | 134 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h    |   2 +
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 276dc75f0e7d..41826f4e7dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -106,7 +106,10 @@ int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
 out:
 	mutex_unlock(&adev->pmc_profiler.lock);
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return amdgpu_set_perfcount(adev, enable);
 }
 
 static int amdgpu_profiler_check_access(struct drm_device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index db09e879b85e..b4a2164068e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -623,6 +623,54 @@ void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
 		kref_put(&queue->refcount, amdgpu_userq_kref_destroy);
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
 static int amdgpu_userq_priority_permit(struct drm_file *filp,
 					int priority)
 {
@@ -1432,6 +1480,92 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_userq_set_perfcount(struct amdgpu_usermode_queue *queue,
+				       bool enable)
+{
+	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_mqd *mqd_funcs = &adev->mqds[queue->queue_type];
+	int r;
+	bool mapped;
+
+	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
+		return;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED &&
+	    queue->state != AMDGPU_USERQ_STATE_UNMAPPED) {
+		drm_file_err(uq_mgr->file,
+			     "user queue %llu is in state %d, skip it when updating PMC\n",
+			      queue->doorbell_index, queue->state);
+		goto out;
+	}
+
+	mapped = queue->state == AMDGPU_USERQ_STATE_MAPPED;
+	queue->userq_prop->perfcount_enable = enable;
+	queue->userq_prop->modify = true;
+
+	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = amdgpu_userq_unmap_helper(queue);
+		if (r) {
+			drm_file_err(uq_mgr->file,
+				     "Failed to unmap user queue %llu when updating PMC\n",
+				      queue->doorbell_index);
+			goto out;
+		}
+	}
+
+	r = mqd_funcs->init_mqd(adev, (void *)queue->mqd.cpu_ptr, queue->userq_prop);
+	if (r) {
+		drm_file_err(uq_mgr->file,
+			     "Failed to update mqd for user queue %llu when updating PMC\n",
+			     queue->doorbell_index);
+		goto out;
+	}
+
+	if (mapped) {
+		r = amdgpu_userq_map_helper(queue);
+		if (r) {
+			drm_file_err(uq_mgr->file,
+				     "Failed to map user queue %llu when updating PMC\n",
+				     queue->doorbell_index);
+		}
+	}
+
+out:
+	mutex_unlock(&uq_mgr->userq_mutex);
+}
+
+/* set perfcount for every queue on the device. */
+int amdgpu_set_perfcount(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id = 0;
+
+	if (amdgpu_in_reset(adev))
+		return -EIO;
+
+	if (adev->userq_halt_for_enforce_isolation)
+		return -EAGAIN;
+
+	queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa, &queue_id);
+	while (queue) {
+		amdgpu_userq_set_perfcount(queue, enable);
+		amdgpu_userq_put(queue);
+
+		if (queue_id == ULONG_MAX)
+			break;
+
+		/* find next queue */
+		queue_id++;
+		queue = amdgpu_userq_xa_find(&adev->userq_doorbell_xa,
+					     &queue_id);
+	}
+
+	return 0;
+}
+
 int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3e19bc6103a0..8f95b2c338f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -178,6 +178,8 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
+
+int amdgpu_set_perfcount(struct amdgpu_device *adev, bool enable);
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
-- 
2.53.0


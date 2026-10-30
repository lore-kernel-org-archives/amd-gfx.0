Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B46F606A31C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YvDOYgHU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBC2112654;
	Fri, 30 Oct 2026 06:31:39 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A9E10E84E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 06:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk5eGldwGcgdfei0Wppds18Hw46TuYNzKyZKj1F2vUB5dmO2gvHHzfZZn21NZBo8w1AHQxDIQouunMr/8l5eaC0FwQd6T6foaUDNhR+CjsZyJPea+Yr9tWnXNhzWnTFxX7+JCHfZiTYL8CtEswmk6E0NX3KsUQKPQbALribVJkxXXtxyiYsWLUkkdTtkvtu2uE5iJ/pX6QPcTCj/CHacegCyerOlz7Dp7L/OSWenZNzmF+PPmXQdCeY9mmR3IAK7XMSGPK2nWVxKO7heuzBiRdNdilwiy1MyzdlZHOSC0hgGfAdLO8yb/vjsBjCfdA+QCA6fUgQa/7wTEquEbcZkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIzEZLp8KfTjSWcgcB3Ua73J+9b2LTgA/7fJtFgwQLE=;
 b=iBBdCz9B+gGYAoajU05FuY7uWPHFE4FP6Ki3PCMgyh3kIqZ0d2Sk4dYMZ8iH/DHuaBh1zx3dswbWxuSNSbebdh0FWj05F43q9aIHruAAb5ABZtNaac+/JbvsJhtuXXWtHVkVwc2TrsvwYPIniLWvr2woBsMoRwj2y533rXxCPVmmxy/qygWYZdkChAaRHXfmnsvXtg/codquS7aqbbnAG0wZ2eeZ6kNqCcjihGu2XR0ApQsk3kvPsnOsb0cbOY2K7WAj4Z0EyiAN68/0AZdAkiiJU3FtkQDZ2S3L7sHlMd660V2O0xmqfUbQ5KQTzx093J9OE+DkuE9q+vKy1wO4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIzEZLp8KfTjSWcgcB3Ua73J+9b2LTgA/7fJtFgwQLE=;
 b=YvDOYgHU/IZFse3Ss2FRR4FI2as4qCdOQKGXGenNombFCTxkdBK7VZOrSUr8gu+/u7sc3r3+Ngv6xjsVtBTkvdNn0p6L9XrJ5X35ava6fw5/ggVqsmW16Ns38WU87JNIO4IPKCSDi70O+3k/El1Ny2kQxK+IErRmmUEVdjGGFVU=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 06:31:27 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::4b) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 06:31:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 06:31:26 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 01:31:24 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>, Benjamin Welton <benjamin.welton@amd.com>
Subject: [PATCH V2 RESEND 12/13] drm/amdgpu: implement device PMC handler
Date: Fri, 30 Oct 2026 14:31:40 +0800
Message-ID: <20261030063141.2773032-13-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030063141.2773032-1-lingshan.zhu@amd.com>
References: <20261030063141.2773032-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd30ced-62f0-4e4d-6f06-08df364f6cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|22082099003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: XpBXm3U2vpC7P03nrpEk4FWDI0d3uwqzsQEg0gfAsgR1yDCcNfISF/FqVbSuT43LM95cbkfHyaelTuNcPVjjHT6BjkA6uaVm4bgacWoIyjnGXRp3n69PGLoOsXxhg8fJH1aklv1z0LwGWKYDPQwHX/Eqf4xtLT1uZhCvwV60hI0q41K8dYNtxIh2RgLwIbMcpTpdlsMA6p4LXmADOekM8ZjgQgFlvJuOMc5hBtMtdODYJUb8d0BmkSV7HLbmMs/RcySIn+GV8HMrXdCFzkBSYzp2Vhdx5qOANJ7uadKGSF3PAlgZGkv+gOQFRwYtNHpfSJIfGzb/KS3xxas83pIJTQCb3YMJ0c5IYgkBFxHKH/wzY+cfbdWCNhVNwu6bpP027t0syWsBIIVa168AM1o30J3s9Zo54e/y9DWBs9wugAobvUckyZCmtH8med9X9tzv4ZTnrPo2RYF6MMC2RzkCQ7QgRZoymNFoY1ETACPPVrY46UM+nQOxRbDLuWR+QZJnYaRi96toGKnM8FKJuqc5RlxiWXh8ZV/4muREmp8K9NrFypHCNTW3XnSXTDWSzANgtRQChRsbBkVXzqdcU7QbN516zcwujtf5oXf8ynXmXvOKJQq0oeLRqf2nL0KUTcJ08A5SDGu5CZfORdn401JVKcFnKkdisYD2BhIQhrvSTsodbJ5EgUsQy4Tjsy5HmfSaxngFjgOFx7nq7SOWNCgMXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uAXLXsHYf1oenlLynaIKUqzHjEdYge2dd8iXLeuibxVWrVCPlKfUtjPXJGwQgReHbU/dH/2gHXxX7Xgb6ZCBnFNFVV9MOdHIvUQjZtIqHb5xXtL8QsisRM+0ob/5lFqB27rQYwySyY5vz4k/0YbljgaRIsASweKevO8QxDPKUN9smfnQoOE5RTRa+6sfeai2SwMS54EncVElNTF2Sljjwf0TpGJDuTlsV3uFN+dvPgg7JkMK7XN4K9la9JbSakIJ3raKb9u2c53l6ZOSV70R3+ih7tI4NqRk9Wc9V9r1+3uo2QvE0aC/liYMXBgiK1rwvdXuSW/FXEe+Y459BnIt84WjEpMidkaEB9CBDLHsNeMQVKP0bzFmYbhhLvJcc3HlasU1AmfJ041QTcAzApDhR3F9hlohNrpJVakK1WI58g0XmFn8LUkRqS65ju+m1o8d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:31:26.5431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd30ced-62f0-4e4d-6f06-08df364f6cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
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

This commit implements device PMC handler

This commit introduces a new helper amdgpu_userq_xa_find.
This helper finds a queue from a XArray which has
the lowest index that is at least the given index,
and hold its kref.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Benjamin Welton <benjamin.welton@amd.com>
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


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D600606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ivO0mnMV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151DC1123D2;
	Thu, 22 Oct 2026 08:20:51 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199F41123D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHAJedd4ivnDVO/Q99Jai3pLt6USKnr+RAHGJGnBSqrrUA6j1o5O3/Jah1G/UjAK0MKRGVk3P3vlYnDMPzd+LjopSMZsD0D7S99NW2OOyu1EamshxlWMiDeT3Nqc8bj6jOMAC/CICRMdGKv/IKA1MFBz1X5ZmVYAssnIFlzYnFz4KIKBDUq/jYJyLKeMIg/UXipsRz8dcDNJh5tuwYiNtibGE+FoOLf7zZUC3yChtGt2LxYUzFlTtlBFvR/uJfm8KkZXPOyaRMrkEZ1RELtNWQqrGysrxeyCUFuIMJpj7XOKVH7D0sj35zSIxqv2t2sG0nVhj9vkrVmzIBGp+uEaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg7K6bTG5tKuZmGy7HiZrP2F2s57er2yfu0PqvfO2N4=;
 b=nAwh/RKjlGlqoujq+1uJFdI6+4DcPXjaHMvTmSZa4Mx7mMXufKihvgkihHTiVpDl6NNipO73ug0Jl9CxK/luxco2iJ15WIFK28b1QeWEP3oRaJLlGnKTQt/U1d/8xHvQLdtfLO4NIgFinjbZlB93LTnnl04cvxFCHzG5mKoDe7LMl9XbHsykSA185MtOCds8bJapZtqzdmyMCLnJaXH/ZUcR10v4VA0BzNUXEXhi5WImrGG8s2yhFCL40R26BYL/sLw1OctOvQH2KiJLqbl1b5+znLmFARo+hgAYAC6IvIr5WbVnXiMi7lnMqzw5EYC7s0qrvGsWFZGQjTetRi+QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg7K6bTG5tKuZmGy7HiZrP2F2s57er2yfu0PqvfO2N4=;
 b=ivO0mnMVhQy3eCXYVcg6dHbW3N7zeheeDGsHzY9XyrdBwh3MuJVPqFdzOvWGGQE0/aUyb7UvnfQ6eQRyWFJweUY6pyr7UBXYiRA3MNR79cj4PVCDMfP4e2wyEd26Fb71/fZlB0hvS0JGrj47VgVWn2tI4yh9f1IUufcjYDzlV/w=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 08:20:41 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::64) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:33 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 08/15] drm/amdgpu/userq: add helpers to keep the user
 queues of one engine across a reset
Date: Thu, 22 Oct 2026 16:19:48 +0800
Message-ID: <20261022082011.331462-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 90495975-9920-42d5-4efe-08df30155bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261021121427099003|6133799003|18002099003|22082099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: L3Xli5lfRfpiSia9kKySRiL0hmjh7v3JXb5Ne34VwS8rkNbDqziMkbp0zCZE7SuoLjxUt+YkSJb0J0oUKhMve9/FUoAbcj0xMX221kXBnjMfor9ZOByqnFzEpYU38/6yM3aetUTJqeVOyZwj/vnT50CgCrDtYv7QbpA/OPbT0rmufLn0jnGxyGMqYGzLwg/psQ4sFCYwqYWEQLUe/bALGBAaHX7mGhAD7n/s8D8T8xGsBIYorm1/jqxmtrTVwNHSvJilAZ8LcPTTsmcH7mDKG/RHa277GC6zwwk2oK+COyh7QRBf9ogF0sEcyVtlUCjLAe5HOhU3NYMxtB9BPuA/5onVzavVZYJM9taF0GtRqJRkbCOy+bIA5dV9tLFjwLt4TkmSHQRic4vvVo6hxAiS83DvYZOKTomNArZ68e3ivnx2WGO+C8FrAYpRTw1BL978qOQLbyjrawzjQhumQ4Rxajz3CnpgLOrkknw6rVXhZ1G9P9rUd2nv8JzVmhUFMOaSUjyb1UyorIXUT5HBRQIRCyVQ61heD9tK9a/cf/Pimb7+YlX+phtQkzeuoH7zpzg0JhNMwTDhQfIGqCa94sk5FsYoyZUr8vHUun87AG24MHMO24Mh4GKkQp++YZJZ/TvPXNodrUUKOZIuMWIvfZiIL6LPeq1S/TLNy4UqeYxqau0cMtMkTNNs3L/pkNb3Khf5KL1YZNl4wAUCzGO72bDahg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261021121427099003)(6133799003)(18002099003)(22082099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PMPCjwbcmW4pW3hzb5lQtkwWIFqBoidI+5VhOB+0ZscbXnTcmk862R+QdCBfGNRRFAvSbQ5RNARROIdxiLA29pv9yD1uq+xPbf19mJnwfVCw1y+2dz8OZ4zY5qD9W79QBY2cxZTlYvTcWgxMySzLQrt8lRlH56kzdhjMZAc8MYuULCU0ISZ211tO//fAKPZpCfYiHO3W1fehff6sQQqd3eE7xJLgw18RVcHGKEMiJ2kqicS+iSC6Z/8FyTwC1q/Pp9upu+tvlTGOmMHeJZtohMQpTI7h/TfsHyND+X4Simcgx/uLXlSbAcBzd78X0/kIgrgdE3h9mWC44jX+bT4GX151hp+rVthzGGEC7KUxo2V9CUO0Uy8rL+A99qamV9EDuf21KEhYQd5RqhQphpSWXurztTdtn+EtRwM8kZQUJOGFm4JcDf9gKZ3VgUqnZdif
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:40.5367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90495975-9920-42d5-4efe-08df30155bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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

An engine reset, eg. of the gfx engine, only resets the queues of one
engine of the GFX IP, while the queues of the other engines keep
running. amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() handle
all the user queues for a full reset. Add separate helpers for the
queues of one engine, which keep them in the state they had:

- amdgpu_userq_pre_engine_reset(), called after the MES suspend, saves
  the ring state of the mapped queues still on a HQD: the reset clears
  their HQD, and MES couldn't preempt them into their MQD. The queues
  MES preempted have their state in their MQD already.
- amdgpu_userq_post_engine_reset(), called after the reset but before
  MES resumes, unmaps those queues, puts the saved ring state in their
  MQD and maps them again: MES doesn't load a queue whose HQD the reset
  cleared on its own, and the unmap may save the cleared HQD into the
  MQD. The queues keep their state and their work, except the one the
  pipe executed: its work in flight depends on pipe state the reset
  cleared, it is dropped and its fences signaled. The queue that hung,
  if any, is unmapped and hung.
- amdgpu_userq_cancel_engine_reset() drops the saved ring state for the
  full reset that follows a failed engine reset.

The helpers walk the queues and unmap and map them as
amdgpu_userq_pre_reset() and amdgpu_userq_post_reset() do. The saved
ring state is kept in the gfx IP, per HQD, and matched to a queue by its
doorbell and MQD address.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 109 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   5 +
 3 files changed, 117 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ba6dcea3f7db..5e9338563de3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -524,6 +524,9 @@ struct amdgpu_gfx {
 
 	/* reset mask */
 	uint32_t 			gfx_supported_reset;
+	/* ring state of the gfx user queues on a HQD, saved by an engine reset */
+	struct amdgpu_gfx_hqd_ptrs	engine_reset_hqds[AMDGPU_MAX_GFX_QUEUES];
+	u32				num_engine_reset_hqds;
 	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 1a2aa85c504e..2c18175a6041 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1597,3 +1597,112 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
 
 	return ret;
 }
+
+/**
+ * amdgpu_userq_pre_engine_reset - save the ring state of the user queues
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ */
+void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32 queue_type)
+{
+	struct amdgpu_gfx_hqd_ptrs ptrs;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long queue_id;
+
+	adev->gfx.num_engine_reset_hqds = 0;
+	if (!adev->gfx.funcs->read_gfx_hqd_ptrs)
+		return;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		if (adev->gfx.num_engine_reset_hqds >= AMDGPU_MAX_GFX_QUEUES)
+			break;
+		if (queue->queue_type != queue_type ||
+		    queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+		if (adev->gfx.funcs->read_gfx_hqd_ptrs(adev, queue->doorbell_index,
+						       &ptrs) && ptrs.on_hqd)
+			adev->gfx.engine_reset_hqds[adev->gfx.num_engine_reset_hqds++] = ptrs;
+	}
+}
+
+static struct amdgpu_gfx_hqd_ptrs *
+amdgpu_userq_engine_reset_hqd(struct amdgpu_device *adev,
+			      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_gfx_hqd_ptrs *ptrs;
+	u32 i;
+
+	for (i = 0; i < adev->gfx.num_engine_reset_hqds; i++) {
+		ptrs = &adev->gfx.engine_reset_hqds[i];
+		/* Check the MQD too: a new queue may reuse the doorbell. */
+		if (ptrs->doorbell_index == queue->doorbell_index &&
+		    ptrs->mqd_addr == queue->mqd.gpu_addr)
+			return ptrs;
+	}
+	return NULL;
+}
+
+/**
+ * amdgpu_userq_post_engine_reset - restore the user queues after an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ * @guilty: the queue that hung, or NULL
+ *
+ * MES doesn't load a queue whose HQD the reset cleared again: unmap it, which
+ * may save the cleared HQD into its MQD, restore its MQD, and map it again.
+ */
+void amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32 queue_type,
+				    struct amdgpu_usermode_queue *guilty)
+{
+	const struct amdgpu_userq_funcs *userq_funcs = adev->userq_funcs[queue_type];
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_gfx_hqd_ptrs *ptrs;
+	unsigned long queue_id;
+	int r;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		if (queue->queue_type != queue_type ||
+		    queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+
+		if (queue == guilty) {
+			userq_funcs->unmap(queue);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			continue;
+		}
+
+		ptrs = amdgpu_userq_engine_reset_hqd(adev, queue);
+		if (!ptrs)
+			continue;
+
+		/* Unmapping may write the cleared HQD into the MQD. */
+		userq_funcs->unmap(queue);
+		if (adev->gfx.funcs->restore_gfx_mqd_ring(adev, queue->mqd.cpu_ptr,
+							  queue->userq_prop->queue_size,
+							  ptrs))
+			amdgpu_userq_fence_driver_force_completion_with_seqno(queue,
+									      ptrs->wptr);
+		r = userq_funcs->map(queue);
+		if (r) {
+			dev_err(adev->dev, "Failed to remap user queue %llu: %d\n",
+				queue->doorbell_index, r);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		}
+	}
+	adev->gfx.num_engine_reset_hqds = 0;
+}
+
+/**
+ * amdgpu_userq_cancel_engine_reset - give up an engine reset
+ * @adev: amdgpu device
+ * @queue_type: AMDGPU_HW_IP_* type of the queues on the reset engine
+ */
+void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
+				      u32 queue_type)
+{
+	adev->gfx.num_engine_reset_hqds = 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..e07c71cd5af5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -181,6 +181,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+void amdgpu_userq_pre_engine_reset(struct amdgpu_device *adev, u32 queue_type);
+void amdgpu_userq_post_engine_reset(struct amdgpu_device *adev, u32 queue_type,
+				    struct amdgpu_usermode_queue *guilty);
+void amdgpu_userq_cancel_engine_reset(struct amdgpu_device *adev,
+				      u32 queue_type);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
 void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
-- 
2.50.1

